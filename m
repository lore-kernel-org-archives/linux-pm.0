From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [PATCH][v3] ACPI / PM: Fix incorrect wakeup irq setting before
 suspend-to-idle
Date: Sat, 10 Oct 2015 02:28:05 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E883BAC6C82@SHSMSX101.ccr.corp.intel.com>
References: <1444378813-17857-1-git-send-email-yu.c.chen@intel.com>
 <1AE640813FDE7649BE1B193DEA596E883BAC6884@SHSMSX101.ccr.corp.intel.com>
 <36DF59CE26D8EE47B0655C516E9CE6402865A448@shsmsx102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <36DF59CE26D8EE47B0655C516E9CE6402865A448@shsmsx102.ccr.corp.intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
To: "Chen, Yu C" <yu.c.chen@intel.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Brown, Len" <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

Hi,

> From: Chen, Yu C
> Sent: Friday, October 09, 2015 5:50 PM
> 
> Hi, LV
> 
> > From: Zheng, Lv
> > Sent: Friday, October 09, 2015 4:33 PM
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

You can add Acked-by: Lv Zheng <lv.zheng@intel.com>
And don't forget to mark it as a stable material.

One more question is:
Do you want the modules to use "acpi_sci_irq"?
If the answer is no, then please ignore this question.

Thanks and best regards
-Lv 


> 
> > Thanks and best regards
> > -Lv
> >

