/* Magic Mirror Config Sample
 * For more information how you can configurate this file
 * See https://github.com/MichMich/MagicMirror#configuration
 */

var config = {
	address: "0.0.0.0",
	port: 8181,
	ipWhitelist: [],
	language: "uk",
	timeFormat: 24,
	units: "metric",

	modules: [
		{
			module: "alert",
			config: {
				effect: "slide",
				alert_effect: "jelly",
				display_time: 3500,
				position: "center",
				welcome_message: false,
					}
				
		},
		{
			module: "updatenotification",
			position: "top_bar",
			disabled: true,
			config: {
				updateInterval: 10 * 60 * 1000, // every 10 minutes
					}
		},
		{
			module: "clock",
			position: "top_left",
			config: {
				displayType: "digital", // options: digital, analog, both
				displaySeconds: true,
				showPeriod: true,
				showPeriodUpper: false,
				clockBold: false,
				showDate: true,
				showWeek: false,
				dateFormat: "dddd, LL",
					/* specific to the analog clock */
				analogSize: "200px",
				analogFace: "simple", // options: 'none', 'simple', 'face-###' (where ### is 001 to 012 inclusive)
				analogPlacement: "bottom", // options: 'top', 'bottom', 'left', 'right'
				analogShowDate: "top", // options: false, 'top', or 'bottom'
				secondsColor: "#888888",
				timezone: null,
			},
		},
		{
			module: "calendar",
			header: "Календар подій",
			position: "top_left",
			config: {
				calendars: [
					{
						symbol: "calendar-check",
						url: "https://calendar.google.com/calendar/ical/uk.ukrainian%23holiday%40group.v.calendar.google.com/public/basic.ics"},
											{
						symbol: "user-friends",
						url: "https://calendar.google.com/calendar/ical/hvozdyk.family%40gmail.com/private-2845d189915d42bf46415e890975c4e1/basic.ics"}
				],
				maximumEntries: 10, // Total Maximum Entries
				maximumNumberOfDays: 365,
				displaySymbol: true,
				defaultSymbol: "calendar", // Fontawesome Symbol see http://fontawesome.io/cheatsheet/
				showLocation: false,
				displayRepeatingCountTitle: false,
				defaultRepeatingCountTitle: "",
				maxTitleLength: 25,
				wrapEvents: false, // wrap events to multiple lines breaking at maxTitleLength
				maxTitleLines: 3,
				fetchInterval: 5 * 60 * 1000, // Update every 5 minutes.
				animationSpeed: 2000,
				fade: true,
				urgency: 7,
				timeFormat: "relative",
				dateFormat: "MMM Do",
				dateEndFormat: "LT",
				fullDayEventDateFormat: "MMM Do",
				showEnd: false,
				getRelative: 6,
				fadePoint: 0.25, // Start on 1/4th of the list.
				hidePrivate: false,
				hideOngoing: false,
				colored: false,
				coloredSymbolOnly: false,
				tableClass: "small",
				titleReplace: {
				"De verjaardag van ": "",
				"'s birthday": "" },
				broadcastEvents: true,
				excludedEvents: [],
				sliceMultiDayEvents: false,
				broadcastPastEvents: false,
				nextDaysRelative: false,
			}
		},
		{
			module: "compliments",
			position: "lower_third",
			disabled: true,
			config: {
				compliments: {
					anytime: [
						"Hey there sexy!"
							 ],
					morning: [
						"Good morning, handsome!",
						"Enjoy your day!",
						"How was your sleep?"
							 ],
					afternoon: [
						"Hello, beauty!",
						"You look sexy!",
						"Looking good today!"
							   ],
					evening: [
						"Wow, you look hot!",
						"You look nice!",
						"Hi, sexy!"
							 ]
							 },
				updateInterval: 30000,
				remoteFile: null,
				fadeSpeed: 4000,
				morningStartTime: 3,
				morningEndTime: 12,
				afternoonStartTime: 12,
				afternoonEndTime: 17
					},
		},
		{
			module: "currentweather",
			position: "top_right",
			config: {
				location: "Kyiv",
				locationID: "703448",  //ID from http://bulk.openweathermap.org/sample/city.list.json.gz; unzip the gz file and find your city
				appid: "e08cb5e508cb58a65a159a430b833fc4",
				updateInterval: 10 * 60 * 1000, // every 10 minutes
				animationSpeed: 1000,
				showPeriod: true,
				showPeriodUpper: false,
				showWindDirection: true,
				showWindDirectionAsArrow: false,
				useBeaufort: true,
				appendLocationNameToHeader: false,
				useKMPHwind: false,
				decimalSymbol: ".",
				showHumidity: false,
				degreeLabel: false,
				showIndoorTemperature: false,
				showIndoorHumidity: false,
				showFeelsLike: true,

				initialLoadDelay: 0, // 0 seconds delay
				retryDelay: 2500,

				apiVersion: "2.5",
				apiBase: "https://api.openweathermap.org/data/",
				weatherEndpoint: "weather",

				appendLocationNameToHeader: true,
				calendarClass: "calendar",

				onlyTemp: false,
				roundTemp: false,

				iconTable: {
					"01d": "wi-day-sunny",
					"02d": "wi-day-cloudy",
					"03d": "wi-cloudy",
					"04d": "wi-cloudy-windy",
					"09d": "wi-showers",
					"10d": "wi-rain",
					"11d": "wi-thunderstorm",
					"13d": "wi-snow",
					"50d": "wi-fog",
					"01n": "wi-night-clear",
					"02n": "wi-night-cloudy",
					"03n": "wi-night-cloudy",
					"04n": "wi-night-cloudy",
					"09n": "wi-night-showers",
					"10n": "wi-night-rain",
					"11n": "wi-night-thunderstorm",
					"13n": "wi-night-snow",
					"50n": "wi-night-alt-cloudy-windy"
							},
					}
		},
		{
			module: "weatherforecast",
			position: "top_right",
			header: "Weather Forecast",
			config: {
				location: "Kyiv",
				locationID: "703448",  //ID from http://bulk.openweathermap.org/sample/city.list.json.gz; unzip the gz file and find your city
				appid: "e08cb5e508cb58a65a159a430b833fc4",
				maxNumberOfDays: 7,
				showRainAmount: false,
				updateInterval: 10 * 60 * 1000, // every 10 minutes
				animationSpeed: 1000,
				decimalSymbol: ".",
				fade: true,
				fadePoint: 0.25, // Start on 1/4th of the list.
				colored: false,
				scale: false,

				initialLoadDelay: 2500, // 2.5 seconds delay. This delay is used to keep the OpenWeather API happy.
				retryDelay: 2500,

				apiVersion: "2.5",
				apiBase: "https://api.openweathermap.org/data/",
				forecastEndpoint: "forecast/daily",

				appendLocationNameToHeader: true,
				calendarClass: "calendar",
				tableClass: "small",

				roundTemp: false,

				iconTable: {
					"01d": "wi-day-sunny",
					"02d": "wi-day-cloudy",
					"03d": "wi-cloudy",
					"04d": "wi-cloudy-windy",
					"09d": "wi-showers",
					"10d": "wi-rain",
					"11d": "wi-thunderstorm",
					"13d": "wi-snow",
					"50d": "wi-fog",
					"01n": "wi-night-clear",
					"02n": "wi-night-cloudy",
					"03n": "wi-night-cloudy",
					"04n": "wi-night-cloudy",
					"09n": "wi-night-showers",
					"10n": "wi-night-rain",
					"11n": "wi-night-thunderstorm",
					"13n": "wi-night-snow",
					"50n": "wi-night-alt-cloudy-windy"
							},
						}
		},
		{
			module: "newsfeed",
			position: "bottom_bar",
			config: {
				feeds: [
					{
						title: "Українська правда",
						url: "https://www.pravda.com.ua/rss/",
						encoding: "windows-1251"
					}
				],
				showSourceTitle: true,
				showPublishDate: true,
				broadcastNewsFeeds: true,
				broadcastNewsUpdates: true,
				showDescription: true,
				wrapTitle: true,
				wrapDescription: true,
				truncDescription: true,
				lengthDescription: 400,
				hideLoading: false,
				reloadInterval: 5 * 60 * 1000, // every 5 minutes
				updateInterval: 15 * 1000,
				animationSpeed: 2.5 * 1000,
				maxNewsItems: 0, // 0 for unlimited
				ignoreOldItems: false,
				ignoreOlderThan: 24 * 60 * 60 * 1000, // 1 day
				removeStartTags: "",
				removeEndTags: "",
				startTags: [],
				endTags: [],
				prohibitedWords: [],
				scrollLength: 500,
				logFeedWarnings: false,
					}
		},
		{
		module: 'email',
                position: 'top_left',
                header: 'Email',
                disabled: true,
                config: {
                    accounts: [
                        {
                            user: 'hvozdyk.family@gmail.com',
                            password: 'KarambasKMB',
                            host: 'imap.gmail.com',
                            port: 993,
                            tls: true,
                            authTimeout: 10000,
                            numberOfEmails: 5

                        }
                    ],
                    fade: true,
                    maxCharacters: 20
                }
	},
		{
		module: 'MMM-PIR-Sensor',
		disabled: false,
		config: {
			sensorPin: 11,
			powerSaving: true,
			powerSavingDelay: 10
			
		}
	},
	{
	module: 'MMM-PIR',
	disabled: true,
    config: {
        sensorPin: 11,
        delay: 10000,
        turnOffDisplay: true,
        showCountdown: false
    }
},
	{
		module: 'MMM-SmartWebDisplay',
		position: 'top_left',
		config: {

			logDebug: false, 
			height:"100%", 
			width:"100%", 
               		updateInterval: 0, //in min. Set it to 0 for no refresh (for videos)
                	NextURLInterval: 2, //in min, set it to 0 not to have automatic URL change. If only 1 URL given, it will be updated
                	displayLastUpdate: false, //to display the last update of the URL
					displayLastUpdateFormat: 'ddd - HH:mm:ss', //format of the date and time to display
                	url: ["https://www.youtube.com/embed/BAeUq-o9mZ8?list=PLPvEveMOPN1S7U0eeXUPzwkIJ0lMZl0Xr&autoplay=1&frameborder=0"], //source of the URL to be displayed
					scrolling: "no" // allow scrolling or not. html 4 only
			}
	},
{
		module: 'MMM-mqtt',
		config: {
			mqttServer: 'localhost:1883',
			mode: 'receive',
			loadingText: 'Loading MQTT Data...',
			topic: 'myhome/smartmirror/led/status',
			showTitle: false,
			title: 'LED status',
			interval: 300000,
			postText: '',
			roundValue: false,
			decimals: 2
			// See 'Configuration options' for more information.
		}
	},
{
    module: 'MMM-MQTT-Publisher',
    config: {
        mqttServers: [
            {
                address: 'localhost',       // Server address or IP address
                port: '1883',               // Port number if other than default
                publications: [             // multiple topic, notification tuples are allowed
                    {
                        topic: 'myhome/smartmirror/led/set',                // Topic to look for
                        notification: 'CALENDER_EVENTS'         // Broadcast data received by `CLOCK_TICK` notification.
                    }
                ]
            }
        ]
    }
},

		{
			module: 'remotecontrol',
   			position: 'bottom_left',
			config: {
			}
		}

	]

};

/*************** DO NOT EDIT THE LINE BELOW ***************/
if (typeof module !== "undefined") {module.exports = config;}
