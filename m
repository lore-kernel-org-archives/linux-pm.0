From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH v7 2/4] gadget: Support for the usb charger framework
Date: Wed, 16 Mar 2016 20:50:03 +0800
Message-ID: <201603162048.ygzBKxuk%fengguang.wu@intel.com>
References: <a746d95b767f7662fd52d533267d989ca4695fa1.1458128215.git.baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="d6Gm4EdcadzBjdND"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <a746d95b767f7662fd52d533267d989ca4695fa1.1458128215.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: kbuild-all@01.org, balbi@kernel.org, gregkh@linuxfoundation.org, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, peter.chen@freescale.com, stern@rowland.harvard.edu, r.baldyga@samsung.com, yoshihiro.shimoda.uh@renesas.com, lee.jones@linaro.org, broonie@kernel.org, ckeepax@opensource.wolfsonmicro.com, patches@opensource.wolfsonmicro.com, baolin.wang@linaro.org, linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, device-mainlining@lists.linuxfoundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Baolin,

[auto build test WARNING on v4.5-rc7]
[also build test WARNING on next-20160316]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Baolin-Wang/Introduce-usb-charger-framework-to-deal-with-the-usb-gadget-power-negotation/20160316-195102
reproduce: make htmldocs

All warnings (new ones prefixed by >>):

   include/linux/usb/gadget.h:228: warning: No description found for parameter 'claimed'
   include/linux/usb/gadget.h:228: warning: No description found for parameter 'enabled'
>> include/linux/usb/gadget.h:656: warning: No description found for parameter 'charger'
   include/linux/usb/gadget.h:656: warning: No description found for parameter 'quirk_altset_not_supp'
   include/linux/usb/gadget.h:656: warning: No description found for parameter 'quirk_stall_not_supp'
   include/linux/usb/gadget.h:656: warning: No description found for parameter 'quirk_zlp_not_supp'
   include/linux/usb/composite.h:501: warning: Excess struct/union/enum/typedef member 'setup_pending' description in 'usb_composite_dev'
   include/linux/usb/composite.h:501: warning: Excess struct/union/enum/typedef member 'os_desc_pending' description in 'usb_composite_dev'
   drivers/usb/gadget/function/f_acm.c:1: warning: no structured comments found
   drivers/usb/gadget/function/f_ecm.c:1: warning: no structured comments found
   drivers/usb/gadget/function/f_subset.c:1: warning: no structured comments found
   drivers/usb/gadget/function/f_obex.c:1: warning: no structured comments found
   drivers/usb/gadget/function/f_serial.c:1: warning: no structured comments found

vim +/charger +656 include/linux/usb/gadget.h

77e9162f include/linux/usb/gadget.h Baolin Wang     2016-03-16  640  	/* negotiate the power with the usb charger */
77e9162f include/linux/usb/gadget.h Baolin Wang     2016-03-16  641  	struct usb_charger		*charger;
d8318d7f include/linux/usb/gadget.h David Cohen     2013-12-09  642  
898c6086 include/linux/usb/gadget.h Felipe Balbi    2011-11-22  643  	unsigned			sg_supported:1;
^1da177e include/linux/usb_gadget.h Linus Torvalds  2005-04-16  644  	unsigned			is_otg:1;
^1da177e include/linux/usb_gadget.h Linus Torvalds  2005-04-16  645  	unsigned			is_a_peripheral:1;
^1da177e include/linux/usb_gadget.h Linus Torvalds  2005-04-16  646  	unsigned			b_hnp_enable:1;
^1da177e include/linux/usb_gadget.h Linus Torvalds  2005-04-16  647  	unsigned			a_hnp_support:1;
^1da177e include/linux/usb_gadget.h Linus Torvalds  2005-04-16  648  	unsigned			a_alt_hnp_support:1;
0b2d2bba include/linux/usb/gadget.h David Cohen     2013-12-09  649  	unsigned			quirk_ep_out_aligned_size:1;
ffd9a0fc include/linux/usb/gadget.h Robert Baldyga  2015-07-28  650  	unsigned			quirk_altset_not_supp:1;
02ded1b0 include/linux/usb/gadget.h Robert Baldyga  2015-07-28  651  	unsigned			quirk_stall_not_supp:1;
ca1023c8 include/linux/usb/gadget.h Robert Baldyga  2015-07-28  652  	unsigned			quirk_zlp_not_supp:1;
80b2502c include/linux/usb/gadget.h Peter Chen      2015-01-28  653  	unsigned			is_selfpowered:1;
ccdf138f include/linux/usb/gadget.h Robert Baldyga  2015-05-04  654  	unsigned			deactivated:1;
ccdf138f include/linux/usb/gadget.h Robert Baldyga  2015-05-04  655  	unsigned			connected:1;
^1da177e include/linux/usb_gadget.h Linus Torvalds  2005-04-16 @656  };
5702f753 include/linux/usb/gadget.h Felipe Balbi    2013-07-17  657  #define work_to_gadget(w)	(container_of((w), struct usb_gadget, work))
^1da177e include/linux/usb_gadget.h Linus Torvalds  2005-04-16  658  
^1da177e include/linux/usb_gadget.h Linus Torvalds  2005-04-16  659  static inline void set_gadget_data(struct usb_gadget *gadget, void *data)
^1da177e include/linux/usb_gadget.h Linus Torvalds  2005-04-16  660  	{ dev_set_drvdata(&gadget->dev, data); }
^1da177e include/linux/usb_gadget.h Linus Torvalds  2005-04-16  661  static inline void *get_gadget_data(struct usb_gadget *gadget)
^1da177e include/linux/usb_gadget.h Linus Torvalds  2005-04-16  662  	{ return dev_get_drvdata(&gadget->dev); }
f48cf80f include/linux/usb/gadget.h Fabien Chouteau 2010-04-23  663  static inline struct usb_gadget *dev_to_usb_gadget(struct device *dev)
f48cf80f include/linux/usb/gadget.h Fabien Chouteau 2010-04-23  664  {

:::::: The code at line 656 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--d6Gm4EdcadzBjdND
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
0AqvTPFm4pCF4D/uX+/MUVgAAA==

--d6Gm4EdcadzBjdND--
