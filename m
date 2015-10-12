From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH][v3] ACPI / PM: Fix incorrect wakeup irq setting before suspend-to-idle
Date: Mon, 12 Oct 2015 22:20:28 +0200
Message-ID: <4932550.izVA1bjiZk@vostro.rjw.lan>
References: <1444378813-17857-1-git-send-email-yu.c.chen@intel.com> <1AE640813FDE7649BE1B193DEA596E883BAC6884@SHSMSX101.ccr.corp.intel.com> <36DF59CE26D8EE47B0655C516E9CE6402865A448@shsmsx102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:62049 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752715AbbJLTvt (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 12 Oct 2015 15:51:49 -0400
In-Reply-To: <36DF59CE26D8EE47B0655C516E9CE6402865A448@shsmsx102.ccr.corp.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Chen, Yu C" <yu.c.chen@intel.com>
Cc: "Zheng, Lv" <lv.zheng@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Brown, Len" <len.brown@intel.com>

On Friday, October 09, 2015 09:50:21 AM Chen, Yu C wrote:
> Hi, LV
> 
> > -----Original Message-----
> > From: Zheng, Lv
> > Sent: Friday, October 09, 2015 4:33 PM
> > To: Chen, Yu C; rjw@rjwysocki.net; lenb@kernel.org
> > Cc: linux-pm@vger.kernel.org; linux-acpi@vger.kernel.org; linux-
> > kernel@vger.kernel.org; Zhang, Rui
> > Subject: RE: [PATCH][v3] ACPI / PM: Fix incorrect wakeup irq setting before
> > suspend-to-idle
> > 
> > Hi, Yu
> > 
> > > From: Chen, Yu C
> > > Sent: Friday, October 09, 2015 4:20 PM
> > >
> > >
> > >  acpi_status acpi_os_remove_interrupt_handler(u32 irq,
> > > acpi_osd_handler handler)
> > 
> > Why don't you rename irq here to gsi to improve the readability?
> > The false naming and the wrong example written for this function are
> > probably the root causes of all other bad code.
> > So if we want to stop people making future mistakes, we need to cleanup
> > ourselves.
> > 
> OK, will rewrite in next version.

It would be good to change the subject of the patch too I think, because it is
not about wakeup IRQs only any more.

Thanks,
Rafael

