From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH v5 1/5] gadget: Introduce the notifier functions
Date: Fri, 6 Nov 2015 20:33:19 +0800
Message-ID: <201511062023.SE2RpVbQ%fengguang.wu@intel.com>
References: <acd08255d6535082973a5e432c40433429544dbc.1446807915.git.baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="fUYQa+Pmc3FrFX/N"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:8692 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752424AbbKFMeb (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 6 Nov 2015 07:34:31 -0500
Content-Disposition: inline
In-Reply-To: <acd08255d6535082973a5e432c40433429544dbc.1446807915.git.baolin.wang@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
Cc: kbuild-all@01.org, balbi@ti.com, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, broonie@kernel.org, linux-kernel@vger.kernel.org, baolin.wang@linaro.org, gregkh@linuxfoundation.org, peter.chen@freescale.com, stern@rowland.harvard.edu, r.baldyga@samsung.com, yoshihiro.shimoda.uh@renesas.com, linux-usb@vger.kernel.org, device-mainlining@lists.linuxfoundation.org, sameo@linux.intel.com, lee.jones@linaro.org, ckeepax@opensource.wolfsonmicro.com, patches@opensource.wolfsonmicro.com, linux-pm@vger.kernel.org


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Baolin,

[auto build test WARNING on v4.3-rc7]
[also build test WARNING on next-20151106]

url:    https://github.com/0day-ci/linux/commits/Baolin-Wang/Introduce-usb-charger-framework-to-deal-with-the-usb-gadget-power-negotation/20151106-194008
reproduce: make htmldocs

All warnings (new ones prefixed by >>):

   include/linux/usb/gadget.h:226: warning: No description found for parameter 'claimed'
>> include/linux/usb/gadget.h:628: warning: No description found for parameter 'nh'
>> include/linux/usb/gadget.h:628: warning: No description found for parameter 'lock'
   include/linux/usb/gadget.h:628: warning: No description found for parameter 'quirk_altset_not_supp'
   include/linux/usb/gadget.h:628: warning: No description found for parameter 'quirk_stall_not_supp'
   include/linux/usb/gadget.h:628: warning: No description found for parameter 'quirk_zlp_not_supp'
>> include/linux/usb/gadget.h:1193: warning: No description found for parameter 'gadget'
>> include/linux/usb/gadget.h:1193: warning: No description found for parameter 'nb'
   include/linux/usb/composite.h:501: warning: Excess struct/union/enum/typedef member 'setup_pending' description in 'usb_composite_dev'
   include/linux/usb/composite.h:501: warning: Excess struct/union/enum/typedef member 'os_desc_pending' description in 'usb_composite_dev'
   drivers/usb/gadget/function/f_acm.c:1: warning: no structured comments found
   drivers/usb/gadget/function/f_ecm.c:1: warning: no structured comments found
   drivers/usb/gadget/function/f_subset.c:1: warning: no structured comments found
   drivers/usb/gadget/function/f_obex.c:1: warning: no structured comments found
   drivers/usb/gadget/function/f_serial.c:1: warning: no structured comments found

vim +/nh +628 include/linux/usb/gadget.h

a64cbb7e92 include/linux/usb/gadget.h Baolin Wang     2015-11-06  612  	struct raw_notifier_head	nh;
a64cbb7e92 include/linux/usb/gadget.h Baolin Wang     2015-11-06  613  	struct mutex			lock;
d8318d7f6b include/linux/usb/gadget.h David Cohen     2013-12-09  614  
898c608678 include/linux/usb/gadget.h Felipe Balbi    2011-11-22  615  	unsigned			sg_supported:1;
^1da177e4c include/linux/usb_gadget.h Linus Torvalds  2005-04-16  616  	unsigned			is_otg:1;
^1da177e4c include/linux/usb_gadget.h Linus Torvalds  2005-04-16  617  	unsigned			is_a_peripheral:1;
^1da177e4c include/linux/usb_gadget.h Linus Torvalds  2005-04-16  618  	unsigned			b_hnp_enable:1;
^1da177e4c include/linux/usb_gadget.h Linus Torvalds  2005-04-16  619  	unsigned			a_hnp_support:1;
^1da177e4c include/linux/usb_gadget.h Linus Torvalds  2005-04-16  620  	unsigned			a_alt_hnp_support:1;
0b2d2bbade include/linux/usb/gadget.h David Cohen     2013-12-09  621  	unsigned			quirk_ep_out_aligned_size:1;
ffd9a0fcbb include/linux/usb/gadget.h Robert Baldyga  2015-07-28  622  	unsigned			quirk_altset_not_supp:1;
02ded1b0d8 include/linux/usb/gadget.h Robert Baldyga  2015-07-28  623  	unsigned			quirk_stall_not_supp:1;
ca1023c81d include/linux/usb/gadget.h Robert Baldyga  2015-07-28  624  	unsigned			quirk_zlp_not_supp:1;
80b2502cea include/linux/usb/gadget.h Peter Chen      2015-01-28  625  	unsigned			is_selfpowered:1;
ccdf138fe3 include/linux/usb/gadget.h Robert Baldyga  2015-05-04  626  	unsigned			deactivated:1;
ccdf138fe3 include/linux/usb/gadget.h Robert Baldyga  2015-05-04  627  	unsigned			connected:1;
^1da177e4c include/linux/usb_gadget.h Linus Torvalds  2005-04-16 @628  };
5702f75375 include/linux/usb/gadget.h Felipe Balbi    2013-07-17  629  #define work_to_gadget(w)	(container_of((w), struct usb_gadget, work))
^1da177e4c include/linux/usb_gadget.h Linus Torvalds  2005-04-16  630  
^1da177e4c include/linux/usb_gadget.h Linus Torvalds  2005-04-16  631  static inline void set_gadget_data(struct usb_gadget *gadget, void *data)
^1da177e4c include/linux/usb_gadget.h Linus Torvalds  2005-04-16  632  	{ dev_set_drvdata(&gadget->dev, data); }
^1da177e4c include/linux/usb_gadget.h Linus Torvalds  2005-04-16  633  static inline void *get_gadget_data(struct usb_gadget *gadget)
^1da177e4c include/linux/usb_gadget.h Linus Torvalds  2005-04-16  634  	{ return dev_get_drvdata(&gadget->dev); }
f48cf80f93 include/linux/usb/gadget.h Fabien Chouteau 2010-04-23  635  static inline struct usb_gadget *dev_to_usb_gadget(struct device *dev)
f48cf80f93 include/linux/usb/gadget.h Fabien Chouteau 2010-04-23  636  {

:::::: The code at line 628 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--fUYQa+Pmc3FrFX/N
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
yoWtEoJf4tH760ZVAAA=

--fUYQa+Pmc3FrFX/N--
