From: Fengguang Wu <fengguang.wu@intel.com>
Subject: Re: [PATCH 2/3][v2] ACPI: Using correct irq when waiting for events
Date: Mon, 26 Oct 2015 09:22:05 +0800
Message-ID: <20151026012205.GB26877@wfg-t540p.sh.intel.com>
References: <1445706156-20203-1-git-send-email-yu.c.chen@intel.com>
 <201510250151.vYKQmll5%fengguang.wu@intel.com>
 <36DF59CE26D8EE47B0655C516E9CE6402865EE80@shsmsx102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <36DF59CE26D8EE47B0655C516E9CE6402865EE80@shsmsx102.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: "Chen, Yu C" <yu.c.chen@intel.com>
Cc: "kbuild-all@01.org" <kbuild-all@01.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "lenb@kernel.org" <lenb@kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>, "Zheng, Lv" <lv.zheng@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>, "Li, Philip" <philip.li@intel.com>
List-Id: linux-pm@vger.kernel.org

On Sun, Oct 25, 2015 at 10:08:29AM +0800, Chen, Yu C wrote:
> This should not be a valid warning IMO, 
> because PATCH 2/3 is  based on PATCH 1/3,
> and the warning of implicit declaration is defined 
> in PATCH 1/3.

Yes sorry, the robot treats the patchset as 3 independent patches:

2754 N L Oct 25 Chen Yu         (  34:0) [PATCH 2/3][v2] ACPI: Using correct irq when waiting for events                                                               
2756 N L Oct 25 Chen Yu         (  52:0) [PATCH 3/3][v2] ACPI / PM: Fix incorrect wakeup irq setting before suspend-to-idle
2757 N L Oct 25 Chen Yu         (  75:0) [PATCH 1/3][v2] ACPI: Using correct irq when uninstalling acpi irq handler

And the root cause is, the 3 patches are likely sent one by one
_out of order_. And there is no in-reply-to field to help reorder
them into a logical patchset.

Thanks,
Fengguang

> > -----Original Message-----
> > From: lkp
> > Sent: Sunday, October 25, 2015 1:19 AM
> > To: Chen, Yu C
> > Cc: kbuild-all@01.org; rjw@rjwysocki.net; lenb@kernel.org; Zhang, Rui;
> > Zheng, Lv; linux-acpi@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> > pm@vger.kernel.org; Chen, Yu C; stable@vger.kernel.org
> > Subject: Re: [PATCH 2/3][v2] ACPI: Using correct irq when waiting for events
> > 
> > Hi Chen,
> > 
> > [auto build test ERROR on pm/linux-next -- if it's inappropriate base, please
> > suggest rules for selecting the more suitable base]
> > 
> > url:    https://github.com/0day-ci/linux/commits/Chen-Yu/ACPI-Using-
> > correct-irq-when-waiting-for-events/20151025-010210
> > config: x86_64-randconfig-x015-201543 (attached as .config)
> > reproduce:
> >         # save the attached .config to linux build tree
> >         make ARCH=x86_64
> > 
> > All error/warnings (new ones prefixed by >>):
> > 
> >    In file included from include/uapi/linux/stddef.h:1:0,
> >                     from include/linux/stddef.h:4,
> >                     from include/uapi/linux/posix_types.h:4,
> >                     from include/uapi/linux/types.h:13,
> >                     from include/linux/types.h:5,
> >                     from include/linux/list.h:4,
> >                     from include/linux/module.h:9,
> >                     from drivers/acpi/osl.c:26:
> >    drivers/acpi/osl.c: In function 'acpi_os_wait_events_complete':
> > >> drivers/acpi/osl.c:1183:6: error: implicit declaration of function
> > 'acpi_sci_irq_valid' [-Werror=implicit-function-declaration]
> >      if (acpi_sci_irq_valid())
> >          ^
> >    include/linux/compiler.h:147:28: note: in definition of macro '__trace_if'
> >      if (__builtin_constant_p((cond)) ? !!(cond) :   \
> >                                ^
> > >> drivers/acpi/osl.c:1183:2: note: in expansion of macro 'if'
> >      if (acpi_sci_irq_valid())
> >      ^
> > >> drivers/acpi/osl.c:1184:23: error: 'acpi_sci_irq' undeclared (first use in this
> > function)
> >       synchronize_hardirq(acpi_sci_irq);
> >                           ^
> >    drivers/acpi/osl.c:1184:23: note: each undeclared identifier is reported only
> > once for each function it appears in
> >    cc1: some warnings being treated as errors
> > 
> > vim +/acpi_sci_irq_valid +1183 drivers/acpi/osl.c
> > 
> >   1177	void acpi_os_wait_events_complete(void)
> >   1178	{
> >   1179		/*
> >   1180		 * Make sure the GPE handler or the fixed event handler is
> > not used
> >   1181		 * on another CPU after removal.
> >   1182		 */
> > > 1183		if (acpi_sci_irq_valid())
> > > 1184			synchronize_hardirq(acpi_sci_irq);
> >   1185		flush_workqueue(kacpid_wq);
> >   1186		flush_workqueue(kacpi_notify_wq);
> >   1187	}
> > 
> > ---
> > 0-DAY kernel test infrastructure                Open Source Technology Center
> > https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
