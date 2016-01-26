From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH 2/2] power: ucs1002: Add support for Programmable USB
 Port Power Controller
Date: Tue, 26 Jan 2016 21:10:38 +0800
Message-ID: <201601262113.QMsv6ZED%fengguang.wu@intel.com>
References: <1453799541-5445-3-git-send-email-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:51175 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965726AbcAZNLY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 26 Jan 2016 08:11:24 -0500
Content-Disposition: inline
In-Reply-To: <1453799541-5445-3-git-send-email-enric.balletbo@collabora.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: kbuild-all@01.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Sjoerd Simons <sjoerd.simons@collabora.co.uk>, Martyn Welch <martyn.welch@collabora.com>

Hi Enric,

[auto build test WARNING on battery/master]
[also build test WARNING on v4.5-rc1 next-20160125]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Enric-Balletbo-i-Serra/Add-UCS1002-USB-Port-Power-Controller/20160126-171717
base:   git://git.infradead.org/battery-2.6.git master


coccinelle warnings: (new ones prefixed by >>)

>> drivers/power/ucs1002_power.c:203:40-49: ERROR: info -> pdata is NULL but dereferenced.

vim +203 drivers/power/ucs1002_power.c

   187		/* Read the polarity setting determined by the SEL pin */
   188		ret = regmap_read(info->regmap, UCS1002_REG_PIN_STATUS, &regval);
   189		if (ret < 0)
   190			return ret;
   191	
   192		if (regval & F_SEL_PIN)
   193			val = enable ? F_PWR_EN_SET : 0;
   194		else
   195			val = enable ? 0 : F_PWR_EN_SET;
   196	
   197		if (info->pdata) {
   198			ret = regmap_update_bits(info->regmap, UCS1002_REG_SWITCH_CFG,
   199						 F_PWR_EN_SET, val);
   200			if (ret < 0)
   201				return ret;
   202		} else {
 > 203			gpiod_set_value_cansleep(info->pdata->gpiod_pwr, val ? 0 : 1);
   204		}
   205	
   206		info->enabled = enable;
   207	
   208		return 0;
   209	}
   210	
   211	static int ucs1002_get_online(struct ucs1002_info *info,

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
