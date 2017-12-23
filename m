From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH 1/3 v7] battery: Add the battery hooking API
Date: Sat, 23 Dec 2017 19:04:30 +0800
Message-ID: <201712231804.7u889GA9%fengguang.wu@intel.com>
References: <20171220151536.GA12278@thinkpad>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171220151536.GA12278@thinkpad>
Sender: platform-driver-x86-owner@vger.kernel.org
Cc: kbuild-all@01.org, Andy Shevchenko <andy.shevchenko@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Ognjen =?utf-8?B?R2FsacSH?= <smclt30p@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, devel@acpica.org, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, Sebastian Reichel <sre@kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, ibm-acpi-devel@lists.sourceforge.net, Linux PM <linux-pm@vger.kernel.org>, Christoph =?iso-8859-1?Q?B=F6hmwalder?= <christoph@boehmwalder.at>, Kevin Locke <kevin@kevinlocke.name>
List-Id: linux-pm@vger.kernel.org

Hi Ognjen,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on platform-drivers-x86/for-next]
[also build test WARNING on v4.15-rc4 next-20171222]
[cannot apply to pm/linux-next]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Ognjen-Galic/battery-Add-the-battery-hooking-API/20171223-144855
base:   git://git.infradead.org/users/dvhart/linux-platform-drivers-x86.git for-next
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)


Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
