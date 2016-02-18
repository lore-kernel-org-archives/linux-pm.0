From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH v12] Add Mediatek thermal support
Date: Thu, 18 Feb 2016 07:53:02 -0800
Message-ID: <20160218155300.GA20378@localhost.localdomain>
References: <1448883753-19068-1-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1448883753-19068-1-git-send-email-s.hauer@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, linux-kernel@vger.kernel.org, kernel@pengutronix.de, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Mon, Nov 30, 2015 at 12:42:30PM +0100, Sascha Hauer wrote:
> This series adds support for the thermal sensors included in the
> MT8173 SoC. Currently only basic temperature reading is supported
> without any interrupt support.
> 

Merged v12.

> 
> 	fan: gpio_fan {
> 		compatible = "gpio-fan";
> 		gpios = <&pio 24 0>;
> 		gpio-fan,speed-map = <0    0
> 				      4500 1>;
> 		#cooling-cells = <2>;
> 	};
> 
> 	thermal-zones {
> 			cpu_thermal: cpu_thermal {
> 			polling-delay-passive = <1000>; /* milliseconds */
> 			polling-delay = <1000>; /* milliseconds */
> 
> 			thermal-sensors = <&thermal>;
> 
> 			trips {
> 				cpu_passive: cpu_passive {
> 					temperature = <47000>; /* millicelsius */
> 					hysteresis = <2000>; /* millicelsius */
> 					type = "passive";
> 				};
> 
> 				cpu_crit {
> 					temperature = <90000>; /* millicelsius */
> 					hysteresis = <2000>; /* millicelsius */
> 					type = "critical";
> 				};
> 			};
> 
> 			cooling-maps {
> 				map0 {
> 					trip = <&cpu_passive>;
> 					cooling-device = <&fan THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> 				};
> 			};
> 		};
> 	};

But, as usual, the dt changes go via your machine tree.

You may add my 
Acked-by: Eduardo Valentin <edubezval@gmail.com>

in your DT patch.

> 
