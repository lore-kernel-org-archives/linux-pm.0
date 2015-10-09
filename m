From: "Chen, Yu C" <yu.c.chen@intel.com>
Subject: RE: [PATCH][v3] ACPI / PM: Fix incorrect wakeup irq setting before
 suspend-to-idle
Date: Fri, 9 Oct 2015 09:50:21 +0000
Message-ID: <36DF59CE26D8EE47B0655C516E9CE6402865A448@shsmsx102.ccr.corp.intel.com>
References: <1444378813-17857-1-git-send-email-yu.c.chen@intel.com>
 <1AE640813FDE7649BE1B193DEA596E883BAC6884@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E883BAC6884@SHSMSX101.ccr.corp.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Brown, Len" <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

Hi, LV

> -----Original Message-----
> From: Zheng, Lv
> Sent: Friday, October 09, 2015 4:33 PM
> To: Chen, Yu C; rjw@rjwysocki.net; lenb@kernel.org
> Cc: linux-pm@vger.kernel.org; linux-acpi@vger.kernel.org; linux-
> kernel@vger.kernel.org; Zhang, Rui
> Subject: RE: [PATCH][v3] ACPI / PM: Fix incorrect wakeup irq setting before
> suspend-to-idle
> 
> Hi, Yu
> 
> > From: Chen, Yu C
> > Sent: Friday, October 09, 2015 4:20 PM
> >
> >
> >  acpi_status acpi_os_remove_interrupt_handler(u32 irq,
> > acpi_osd_handler handler)
> 
> Why don't you rename irq here to gsi to improve the readability?
> The false naming and the wrong example written for this function are
> probably the root causes of all other bad code.
> So if we want to stop people making future mistakes, we need to cleanup
> ourselves.
> 
OK, will rewrite in next version.

> Thanks and best regards
> -Lv
> 
