From: kbuild test robot <lkp@intel.com>
Subject: Re: [RESEND PATCH v11 2/4] gadget: Support for the usb charger
 framework
Date: Mon, 13 Jun 2016 19:06:09 +0800
Message-ID: <201606131931.mbTrJx63%fengguang.wu@intel.com>
References: <0f69a3bb3451dd850a7c2de30d17266b98ff337d.1465807514.git.baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0F1p//8PRICkK4MW"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:48469 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965246AbcFMLHH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 13 Jun 2016 07:07:07 -0400
Content-Disposition: inline
In-Reply-To: <0f69a3bb3451dd850a7c2de30d17266b98ff337d.1465807514.git.baolin.wang@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
Cc: kbuild-all@01.org, balbi@kernel.org, gregkh@linuxfoundation.org, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, robh@kernel.org, m.szyprowski@samsung.com, ruslan.bilovol@gmail.com, peter.chen@freescale.com, stern@rowland.harvard.edu, r.baldyga@samsung.com, yoshihiro.shimoda.uh@renesas.com, lee.jones@linaro.org, broonie@kernel.org, ckeepax@opensource.wolfsonmicro.com, patches@opensource.wolfsonmicro.com, baolin.wang@linaro.org, linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, device-mainlining@lists.linuxfoundation.org, linux-kernel@vger.kernel.org


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

[auto build test WARNING on balbi-usb/next]
[also build test WARNING on v4.7-rc3 next-20160609]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Baolin-Wang/Introduce-usb-charger-framework-to-deal-with-the-usb-gadget-power-negotation/20160613-165523
base:   https://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git next
reproduce: make htmldocs

All warnings (new ones prefixed by >>):

   include/linux/usb/gadget.h:228: warning: No description found for parameter 'claimed'
   include/linux/usb/gadget.h:228: warning: No description found for parameter 'enabled'
>> include/linux/usb/gadget.h:661: warning: No description found for parameter 'charger'
   include/linux/usb/gadget.h:661: warning: No description found for parameter 'quirk_altset_not_supp'
   include/linux/usb/gadget.h:661: warning: No description found for parameter 'quirk_stall_not_supp'
   include/linux/usb/gadget.h:661: warning: No description found for parameter 'quirk_zlp_not_supp'
   include/linux/usb/composite.h:507: warning: Excess struct/union/enum/typedef member 'setup_pending' description in 'usb_composite_dev'
   include/linux/usb/composite.h:507: warning: Excess struct/union/enum/typedef member 'os_desc_pending' description in 'usb_composite_dev'
   drivers/usb/gadget/function/f_acm.c:1: warning: no structured comments found
   drivers/usb/gadget/function/f_ecm.c:1: warning: no structured comments found
   drivers/usb/gadget/function/f_subset.c:1: warning: no structured comments found
   drivers/usb/gadget/function/f_obex.c:1: warning: no structured comments found
   drivers/usb/gadget/function/f_serial.c:1: warning: no structured comments found

vim +/charger +661 include/linux/usb/gadget.h

d8318d7f include/linux/usb/gadget.h David Cohen     2013-12-09  645  
898c6086 include/linux/usb/gadget.h Felipe Balbi    2011-11-22  646  	unsigned			sg_supported:1;
^1da177e include/linux/usb_gadget.h Linus Torvalds  2005-04-16  647  	unsigned			is_otg:1;
^1da177e include/linux/usb_gadget.h Linus Torvalds  2005-04-16  648  	unsigned			is_a_peripheral:1;
^1da177e include/linux/usb_gadget.h Linus Torvalds  2005-04-16  649  	unsigned			b_hnp_enable:1;
^1da177e include/linux/usb_gadget.h Linus Torvalds  2005-04-16  650  	unsigned			a_hnp_support:1;
^1da177e include/linux/usb_gadget.h Linus Torvalds  2005-04-16  651  	unsigned			a_alt_hnp_support:1;
75a9c82a include/linux/usb/gadget.h Li Jun          2016-02-19  652  	unsigned			hnp_polling_support:1;
75a9c82a include/linux/usb/gadget.h Li Jun          2016-02-19  653  	unsigned			host_request_flag:1;
0b2d2bba include/linux/usb/gadget.h David Cohen     2013-12-09  654  	unsigned			quirk_ep_out_aligned_size:1;
ffd9a0fc include/linux/usb/gadget.h Robert Baldyga  2015-07-28  655  	unsigned			quirk_altset_not_supp:1;
02ded1b0 include/linux/usb/gadget.h Robert Baldyga  2015-07-28  656  	unsigned			quirk_stall_not_supp:1;
ca1023c8 include/linux/usb/gadget.h Robert Baldyga  2015-07-28  657  	unsigned			quirk_zlp_not_supp:1;
80b2502c include/linux/usb/gadget.h Peter Chen      2015-01-28  658  	unsigned			is_selfpowered:1;
ccdf138f include/linux/usb/gadget.h Robert Baldyga  2015-05-04  659  	unsigned			deactivated:1;
ccdf138f include/linux/usb/gadget.h Robert Baldyga  2015-05-04  660  	unsigned			connected:1;
^1da177e include/linux/usb_gadget.h Linus Torvalds  2005-04-16 @661  };
5702f753 include/linux/usb/gadget.h Felipe Balbi    2013-07-17  662  #define work_to_gadget(w)	(container_of((w), struct usb_gadget, work))
^1da177e include/linux/usb_gadget.h Linus Torvalds  2005-04-16  663  
^1da177e include/linux/usb_gadget.h Linus Torvalds  2005-04-16  664  static inline void set_gadget_data(struct usb_gadget *gadget, void *data)
^1da177e include/linux/usb_gadget.h Linus Torvalds  2005-04-16  665  	{ dev_set_drvdata(&gadget->dev, data); }
^1da177e include/linux/usb_gadget.h Linus Torvalds  2005-04-16  666  static inline void *get_gadget_data(struct usb_gadget *gadget)
^1da177e include/linux/usb_gadget.h Linus Torvalds  2005-04-16  667  	{ return dev_get_drvdata(&gadget->dev); }
f48cf80f include/linux/usb/gadget.h Fabien Chouteau 2010-04-23  668  static inline struct usb_gadget *dev_to_usb_gadget(struct device *dev)
f48cf80f include/linux/usb/gadget.h Fabien Chouteau 2010-04-23  669  {

:::::: The code at line 661 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--0F1p//8PRICkK4MW
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--0F1p//8PRICkK4MW--
