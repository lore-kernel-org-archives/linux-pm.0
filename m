From: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v12] Add Mediatek thermal support
Date: Mon, 14 Dec 2015 11:37:39 +0100
Message-ID: <20151214103739.GA14356@pengutronix.de>
References: <1448883753-19068-1-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1448883753-19068-1-git-send-email-s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Eduardo,

Ok, to apply this? There seem to be no further comments.

Sascha

On Mon, Nov 30, 2015 at 12:42:30PM +0100, Sascha Hauer wrote:
> This series adds support for the thermal sensors included in the
> MT8173 SoC. Currently only basic temperature reading is supported
> without any interrupt support.
> 
> The cpufreq driver for MT8173 is currently under review, so there's no
> real cooling device available in mainline. Until this is available the
> thermal driver can be tested with the following dts snippet. It creates
> a fake gpio fan and a fake trip point which is so low that it can easily
> be reached with a "cat /dev/zero > /dev/null" on the command line.
> 
> Sascha
> 
> Changes since v11:
> - Fix usage of uninitialized variable gcc didn't warn about
> 
> changes since v10:
> - Some style cleanup
> - Add comment to make clear why we use the sensors in banks even if we
>   currently only use the maximum of all banks
> 
> changes since v9:
> - rebase on v4.3
> - Add support for reading the calibration values from nvmem fuses
> - Only register a single thermal zone instead of four as it seems
>   that's everything needed
> 
> changes since v8:
> - Add commit description to binding patch
> - rebase on v4.3-rc2
> 
> changes since v7:
> - re-add some used defines removed in v5
> - Use MT8173_THERMAL_ZONE_* defines as array indices in static initializers
> 
> changes since v6:
> - remove dot in Hanyi Wus name
> 
> changes since v5:
> - update copyright
> - remove unused defines
> 
> Changes since v4:
> - give calibration constants more meaningful names (offset, slope)
> - Use define instead of 0x00c for register access.
> 
> Changes since v3:
> - add include/dt-bindings/thermal/mt8173.h for to be able to use sensor names
>   in dts files
> - fix disabling wrong clock in error path
> - remove now unused reset-names property from binding document
> - rename MT8173_NUM_BANKS -> MT8173_NUM_ZONES
> - rename MT8173_NUM_SENSING_POINTS -> MT8173_NUM_SENSORS_PER_ZONE
> - rename struct thermal_zone_device *tz -> struct thermal_zone_device *tzd
> 
> Changes since v2:
> - sort #includes alphabetically
> - Add prefix to register defines
> - drop some members from struct mtk_thermal
> - simplify raw_to_mcelsius()
> - add and use more register bit defines
> - use device_reset() instead of devm_reset_control_get()/reset_control_reset()
> - misc other stuff
> 
> Changes since v1:
> - Use "mediatek," prefix for custom properties
> - Drop "thermal: consistently use int for temperatures" dependency
> 
> -------------
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
> 
> 
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
