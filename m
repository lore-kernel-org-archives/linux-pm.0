From: kbuild test robot <lkp-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 6/7] typec: tcpm: Represent source supply through
 power_supply class
Date: Wed, 20 Dec 2017 23:24:56 +0800
Message-ID: <201712202347.ku5eez8B%fengguang.wu@intel.com>
References: <4a578dd161acf70aa33cc887493d2854547c0a2b.1513599506.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4a578dd161acf70aa33cc887493d2854547c0a2b.1513599506.git.Adam.Thomson.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Adam Thomson <Adam.Thomson.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Cc: kbuild-all-JC7UmRfGjtg@public.gmane.org, Heikki Krogerus <heikki.krogerus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Yueyao Zhu <yueyao.zhu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rui Miguel Silva <rmfrfs-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, support.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Hi Adam,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on next-20171214]
[cannot apply to usb/usb-testing hwmon/hwmon-next v4.15-rc3 v4.15-rc2 v4.15-rc1 v4.15-rc4]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Adam-Thomson/typec-tcpm-Add-sink-side-support-for-PPS/20171220-205656


coccinelle warnings: (new ones prefixed by >>)

>> drivers/usb/typec/tcpm.c:4396:1-3: WARNING: PTR_ERR_OR_ZERO can be used

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
