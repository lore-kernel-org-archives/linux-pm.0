From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH v19 4/4] power: wm831x_power: Support USB charger current
 limit management
Date: Mon, 20 Feb 2017 18:20:30 +0800
Message-ID: <201702201823.LswrRqOw%fengguang.wu@intel.com>
References: <c785b7bd9ad81bffa5c7311e52b6eda46c16f310.1487578977.git.baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ZPt4rx8FFjLCG7dd"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:27696 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751232AbdBTKVU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 20 Feb 2017 05:21:20 -0500
Content-Disposition: inline
In-Reply-To: <c785b7bd9ad81bffa5c7311e52b6eda46c16f310.1487578977.git.baolin.wang@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
Cc: kbuild-all@01.org, balbi@kernel.org, gregkh@linuxfoundation.org, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, robh@kernel.org, jun.li@nxp.com, m.szyprowski@samsung.com, ruslan.bilovol@gmail.com, peter.chen@freescale.com, stern@rowland.harvard.edu, grygorii.strashko@ti.com, yoshihiro.shimoda.uh@renesas.com, lee.jones@linaro.org, broonie@kernel.org, john.stultz@linaro.org, neilb@suse.com, ckeepax@opensource.wolfsonmicro.com, patches@opensource.wolfsonmicro.com, baolin.wang@linaro.org, linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, device-mainlining@lists.linuxfoundation.org, linux-kernel@vger.kernel.org


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Baolin,

[auto build test ERROR on v4.9-rc8]
[cannot apply to balbi-usb/next usb/usb-testing battery/master next-20170220]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Baolin-Wang/Introduce-usb-charger-framework-to-deal-with-the-usb-gadget-power-negotation/20170220-173051
config: i386-randconfig-x017-201708 (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   In file included from drivers/power/supply/wm831x_power.c:16:0:
   include/linux/usb/charger.h: In function 'usb_charger_get_state':
   include/linux/usb/charger.h:151:9: error: 'USB_CHARGER_REMOVE' undeclared (first use in this function)
     return USB_CHARGER_REMOVE;
            ^~~~~~~~~~~~~~~~~~
   include/linux/usb/charger.h:151:9: note: each undeclared identifier is reported only once for each function it appears in
   drivers/power/supply/wm831x_power.c: In function 'wm831x_usb_limit_change':
>> drivers/power/supply/wm831x_power.c:151:2: error: 'best' undeclared (first use in this function)
     best = 0;
     ^~~~
>> drivers/power/supply/wm831x_power.c:152:7: error: 'i' undeclared (first use in this function)
     for (i = 0; i < ARRAY_SIZE(wm831x_usb_limits); i++) {
          ^

vim +/best +151 drivers/power/supply/wm831x_power.c

    10	
    11	#include <linux/module.h>
    12	#include <linux/err.h>
    13	#include <linux/platform_device.h>
    14	#include <linux/power_supply.h>
    15	#include <linux/slab.h>
  > 16	#include <linux/usb/charger.h>
    17	
    18	#include <linux/mfd/wm831x/core.h>
    19	#include <linux/mfd/wm831x/auxadc.h>
    20	#include <linux/mfd/wm831x/pmu.h>
    21	#include <linux/mfd/wm831x/pdata.h>
    22	
    23	struct wm831x_power {
    24		struct wm831x *wm831x;
    25		struct power_supply *wall;
    26		struct power_supply *usb;
    27		struct power_supply *battery;
    28		struct power_supply_desc wall_desc;
    29		struct power_supply_desc usb_desc;
    30		struct power_supply_desc battery_desc;
    31		char wall_name[20];
    32		char usb_name[20];
    33		char battery_name[20];
    34		bool have_battery;
    35		struct usb_charger *usb_charger;
    36		struct notifier_block usb_notify;
    37	};
    38	
    39	static int wm831x_power_check_online(struct wm831x *wm831x, int supply,
    40					     union power_supply_propval *val)
    41	{
    42		int ret;
    43	
    44		ret = wm831x_reg_read(wm831x, WM831X_SYSTEM_STATUS);
    45		if (ret < 0)
    46			return ret;
    47	
    48		if (ret & supply)
    49			val->intval = 1;
    50		else
    51			val->intval = 0;
    52	
    53		return 0;
    54	}
    55	
    56	static int wm831x_power_read_voltage(struct wm831x *wm831x,
    57					     enum wm831x_auxadc src,
    58					     union power_supply_propval *val)
    59	{
    60		int ret;
    61	
    62		ret = wm831x_auxadc_read_uv(wm831x, src);
    63		if (ret >= 0)
    64			val->intval = ret;
    65	
    66		return ret;
    67	}
    68	
    69	/*********************************************************************
    70	 *		WALL Power
    71	 *********************************************************************/
    72	static int wm831x_wall_get_prop(struct power_supply *psy,
    73					enum power_supply_property psp,
    74					union power_supply_propval *val)
    75	{
    76		struct wm831x_power *wm831x_power = dev_get_drvdata(psy->dev.parent);
    77		struct wm831x *wm831x = wm831x_power->wm831x;
    78		int ret = 0;
    79	
    80		switch (psp) {
    81		case POWER_SUPPLY_PROP_ONLINE:
    82			ret = wm831x_power_check_online(wm831x, WM831X_PWR_WALL, val);
    83			break;
    84		case POWER_SUPPLY_PROP_VOLTAGE_NOW:
    85			ret = wm831x_power_read_voltage(wm831x, WM831X_AUX_WALL, val);
    86			break;
    87		default:
    88			ret = -EINVAL;
    89			break;
    90		}
    91	
    92		return ret;
    93	}
    94	
    95	static enum power_supply_property wm831x_wall_props[] = {
    96		POWER_SUPPLY_PROP_ONLINE,
    97		POWER_SUPPLY_PROP_VOLTAGE_NOW,
    98	};
    99	
   100	/*********************************************************************
   101	 *		USB Power
   102	 *********************************************************************/
   103	static int wm831x_usb_get_prop(struct power_supply *psy,
   104				       enum power_supply_property psp,
   105				       union power_supply_propval *val)
   106	{
   107		struct wm831x_power *wm831x_power = dev_get_drvdata(psy->dev.parent);
   108		struct wm831x *wm831x = wm831x_power->wm831x;
   109		int ret = 0;
   110	
   111		switch (psp) {
   112		case POWER_SUPPLY_PROP_ONLINE:
   113			ret = wm831x_power_check_online(wm831x, WM831X_PWR_USB, val);
   114			break;
   115		case POWER_SUPPLY_PROP_VOLTAGE_NOW:
   116			ret = wm831x_power_read_voltage(wm831x, WM831X_AUX_USB, val);
   117			break;
   118		default:
   119			ret = -EINVAL;
   120			break;
   121		}
   122	
   123		return ret;
   124	}
   125	
   126	static enum power_supply_property wm831x_usb_props[] = {
   127		POWER_SUPPLY_PROP_ONLINE,
   128		POWER_SUPPLY_PROP_VOLTAGE_NOW,
   129	};
   130	
   131	/* In milliamps */
   132	static const unsigned int wm831x_usb_limits[] = {
   133		0,
   134		2,
   135		100,
   136		500,
   137		900,
   138		1500,
   139		1800,
   140		550,
   141	};
   142	
   143	static int wm831x_usb_limit_change(struct notifier_block *nb,
   144					   unsigned long limit, void *data)
   145	{
   146		struct wm831x_power *wm831x_power = container_of(nb,
   147								 struct wm831x_power,
   148								 usb_notify);
   149	
   150		/* Find the highest supported limit */
 > 151		best = 0;
 > 152		for (i = 0; i < ARRAY_SIZE(wm831x_usb_limits); i++) {
   153			if (limit >= wm831x_usb_limits[i] &&
   154			    wm831x_usb_limits[best] < wm831x_usb_limits[i])
   155				best = i;

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--ZPt4rx8FFjLCG7dd
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
b9Fkr5H/AegW4kZgjwEA

--ZPt4rx8FFjLCG7dd--
