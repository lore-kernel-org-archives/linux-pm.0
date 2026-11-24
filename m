Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795556872;
	b=0NFX2fiLYrW96mf9vQ6t2cYpqWI1IG7MGktH8ykKvupUH+FbolmFRmGTqiyBF4Qu3DFb
	 nzr7pwNIXs8CkVxuGiBXPz8btLtxNeqEBT6du3Ii8GBrxw3u0lJDzMNJDozWCsl5OqOKc
	 Ewo4zus2YDIkARdq/lZhQ3z/7ztcXqA+g+emQtYWwuejOhbKLjVxwWp5sCeh/5PJheA7O
	 WWhAZDVbRQVuOhY0Kx1Kho/WBoGtpDliCyHLv8l/P4+aY+2cK2nDys9b9NqvuFfzl2Sbx
	 9DpD8K3yRFhNdaVQmHdu7BFrHYZSKhqbn4yfYf8CwNn/iusJ1Zx1jQ69ISM7eSOMfwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795556872;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=FAusodFBrbI8G7AAMkwV4nh7h71Xni9RUPUyfFZl+Wk=;
	b=TYvp/wYUFb91d39R1+9kCQX/89x+h9Cc/8c25svlk5YSQ+AIiJv+U+cG0X2wtU88/2MP
	 qZ0LrZlhaLAAcboL+VJ9rojWf4MXOuS4+RBRTvPJSvK7O+uAasTa9gR6fqriMHZDf3YrV
	 7GmEywDkRCxcelCImAry/8YrasuM30Hci9j0MmdL/AWqpwd+MwAgZ32ne760QaO1Kfy0H
	 cNrahHzzCH2xyr6MXcnHCR1GL5doHLy5dYxFMp+NySGcF4aBQ3GzNetluEjCimoV7YwaI
	 QTbN4tAOyvU3/qOAnHkkGTtqMia3O6i1GH538wib6YEKatjUlWklu4qWVAsePqirXpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=g75F1QQQ;
	arc=none smtp.remote-ip=192.198.163.15
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0816606A33B;
	Tue, 24 Nov 2026 21:47:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0816606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=g75F1QQQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795556871; x=1827092871;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=gQ5DGumkXVY5xtwGUpFVEiU5TLfOLBabHwPqzekY9qk=;
  b=g75F1QQQ8dG3S5YEKdYcTl4HuxKU79AUqtmptshfitKoqUnpeElLqymB
   3ZAtIk2S7NsRT8GUZK3zRu4SWL9HdSErXp+ApfHGfy64hq4Ak0chxPLwF
   oUMSd9PF3RobZDPxcEssjnfI+/yYl2DLOZAMXsbawxeEMi2+gGoC9qqLK
   XuXKj7TpCkc/3nSdoHFLfU2KV6aXfBWVV1Eit0wqRj3cBqpxFVJaSC9S4
   z51wPiouHV+feaAL13sihXiSeyzghdxGkdKc8Is0gjTpz772RR1qVBSQ7
   YZ39cR2MV2DSPY/rcvhK+0MKycNiKaKUtcDo1QsFfNexUQn6x+zsripNl
   A==;
X-CSE-ConnectionGUID: Zq2QFu/HSv2mf8QIKOOzLw==
X-CSE-MsgGUID: bvCHmSRfT3GhQeyieU4khg==
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; 
   d="scan'208";a="4355216"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 06:35:49 -0800
X-CSE-ConnectionGUID: DBADT9mOR3GP8LyuPqes7g==
X-CSE-MsgGUID: kCiXYfZ5SRyT++JDoxRa5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; 
   d="scan'208";a="11471491"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 24 Nov 2026 06:35:46 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xVrcU-00000001PTi-3CLa;
	Tue, 24 Nov 2026 14:35:42 +0000
Date: Tue, 24 Nov 2026 22:35:27 +0800
From: kernel test robot <lkp@intel.com>
To: Markus Elfring <Markus.Elfring@web.de>, linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Sebastian Reichel <sre@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	LKML <linux-kernel@vger.kernel.org>,
	kernel-janitors@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Frank Li <Frank.Li@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH] power: reset: at91: Use devm_clk_get_enabled() in three
 probe functions
Message-ID: <20261124222203.k0pVspdI-lkp@intel.com>
References: <de6c1040-c4d1-4703-9932-b3b668801c72@web.de>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <de6c1040-c4d1-4703-9932-b3b668801c72@web.de>

Hi Markus,

kernel test robot noticed the following build warnings:

[auto build test WARNING on sre-power-supply/for-next]
[also build test WARNING on amd-pstate/linux-next amd-pstate/bleeding-edge clk/clk-next soc/for-next nferre-at91/at91-next linus/master v7.4-rc4 next-20261123]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Markus-Elfring/power-reset-at91-Use-devm_clk_get_enabled-in-three-probe-functions/20261124-095011
base:   https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git for-next
patch link:    https://lore.kernel.org/r/de6c1040-c4d1-4703-9932-b3b668801c72%40web.de
patch subject: [PATCH] power: reset: at91: Use devm_clk_get_enabled() in three probe functions
config: arm-defconfig (https://download.01.org/0day-ci/archive/20261124/20261124222203.k0pVspdI-lkp@intel.com/config)
compiler: clang version 24.0.0git (https://github.com/llvm/llvm-project 2012344e5da8e03ea4b8283ecd6fad6e13f09d64)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261124/20261124222203.k0pVspdI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/20261124222203.k0pVspdI-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/power/reset/at91-poweroff.c:156:6: warning: unused variable 'ret' [-Wunused-variable]
     156 |         int ret;
         |             ^~~
   1 warning generated.


vim +/ret +156 drivers/power/reset/at91-poweroff.c

ae499f0fadaf28b Maxime Ripard     2014-07-03  151  
099806de68b75a0 Uwe Kleine-König  2023-11-04  152  static int at91_poweroff_probe(struct platform_device *pdev)
ae499f0fadaf28b Maxime Ripard     2014-07-03  153  {
0b0408745e7ff24 Alexandre Belloni 2016-10-25  154  	struct device_node *np;
0b0408745e7ff24 Alexandre Belloni 2016-10-25  155  	u32 ddr_type;
064380a12e12412 Alexandre Belloni 2015-08-11 @156  	int ret;
ae499f0fadaf28b Maxime Ripard     2014-07-03  157  
0b64a0e53cc7875 Yangtao Li        2023-07-04  158  	at91_shdwc.shdwc_base = devm_platform_ioremap_resource(pdev, 0);
caa6e150f8fbcf4 Claudiu Beznea    2018-12-06  159  	if (IS_ERR(at91_shdwc.shdwc_base))
caa6e150f8fbcf4 Claudiu Beznea    2018-12-06  160  		return PTR_ERR(at91_shdwc.shdwc_base);
ae499f0fadaf28b Maxime Ripard     2014-07-03  161  
e51202a7ed9dff5 Markus Elfring    2026-11-24  162  	at91_shdwc.sclk = devm_clk_get_enabled(&pdev->dev, NULL);
caa6e150f8fbcf4 Claudiu Beznea    2018-12-06  163  	if (IS_ERR(at91_shdwc.sclk))
caa6e150f8fbcf4 Claudiu Beznea    2018-12-06  164  		return PTR_ERR(at91_shdwc.sclk);
064380a12e12412 Alexandre Belloni 2015-08-11  165  
062836db01f9826 Ladislav Michl    2018-03-16  166  	at91_wakeup_status(pdev);
ae499f0fadaf28b Maxime Ripard     2014-07-03  167  
ae499f0fadaf28b Maxime Ripard     2014-07-03  168  	if (pdev->dev.of_node)
ae499f0fadaf28b Maxime Ripard     2014-07-03  169  		at91_poweroff_dt_set_wakeup_mode(pdev);
ae499f0fadaf28b Maxime Ripard     2014-07-03  170  
0b0408745e7ff24 Alexandre Belloni 2016-10-25  171  	np = of_find_compatible_node(NULL, NULL, "atmel,sama5d3-ddramc");
996463fdb8cdec4 Claudiu Beznea    2018-11-05  172  	if (np) {
caa6e150f8fbcf4 Claudiu Beznea    2018-12-06  173  		at91_shdwc.mpddrc_base = of_iomap(np, 0);
0b0408745e7ff24 Alexandre Belloni 2016-10-25  174  		of_node_put(np);
0b0408745e7ff24 Alexandre Belloni 2016-10-25  175  
e51202a7ed9dff5 Markus Elfring    2026-11-24  176  		if (!at91_shdwc.mpddrc_base)
e51202a7ed9dff5 Markus Elfring    2026-11-24  177  			return -ENOMEM;
0b0408745e7ff24 Alexandre Belloni 2016-10-25  178  
caa6e150f8fbcf4 Claudiu Beznea    2018-12-06  179  		ddr_type = readl(at91_shdwc.mpddrc_base + AT91_DDRSDRC_MDR) &
996463fdb8cdec4 Claudiu Beznea    2018-11-05  180  				 AT91_DDRSDRC_MD;
996463fdb8cdec4 Claudiu Beznea    2018-11-05  181  		if (ddr_type != AT91_DDRSDRC_MD_LPDDR2 &&
996463fdb8cdec4 Claudiu Beznea    2018-11-05  182  		    ddr_type != AT91_DDRSDRC_MD_LPDDR3) {
caa6e150f8fbcf4 Claudiu Beznea    2018-12-06  183  			iounmap(at91_shdwc.mpddrc_base);
caa6e150f8fbcf4 Claudiu Beznea    2018-12-06  184  			at91_shdwc.mpddrc_base = NULL;
996463fdb8cdec4 Claudiu Beznea    2018-11-05  185  		}
996463fdb8cdec4 Claudiu Beznea    2018-11-05  186  	}
996463fdb8cdec4 Claudiu Beznea    2018-11-05  187  
996463fdb8cdec4 Claudiu Beznea    2018-11-05  188  	pm_power_off = at91_poweroff;
0b0408745e7ff24 Alexandre Belloni 2016-10-25  189  
ae499f0fadaf28b Maxime Ripard     2014-07-03  190  	return 0;
ae499f0fadaf28b Maxime Ripard     2014-07-03  191  }
ae499f0fadaf28b Maxime Ripard     2014-07-03  192  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
