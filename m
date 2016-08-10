From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH 2/2] x86, ACPI: Fix the wrong assignment when Handle
 apic/x2apic entries
Date: Wed, 10 Aug 2016 21:03:33 +0800
Message-ID: <20160810130333.GA5598@x1.redhat.com>
References: <1470697311-1292-1-git-send-email-bhe@redhat.com>
 <1470697311-1292-2-git-send-email-bhe@redhat.com>
 <20160810125333.GB9028@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40320 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S941179AbcHJTIH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 10 Aug 2016 15:08:07 -0400
Content-Disposition: inline
In-Reply-To: <20160810125333.GB9028@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, linux-pm@vger.kernel.org

On 08/10/16 at 02:53pm, Ingo Molnar wrote:
> 
> * Baoquan He <bhe@redhat.com> wrote:
> 
> > It won't impact the result, we still should fix the code bug.
> > 
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > Cc: Len Brown <len.brown@intel.com>
> > Cc: Pavel Machek <pavel@ucw.cz>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > Cc: x86@kernel.org
> > Cc: linux-pm@vger.kernel.org
> > ---
> >  arch/x86/kernel/acpi/boot.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
> > index 90d84c3..2b25d3f 100644
> > --- a/arch/x86/kernel/acpi/boot.c
> > +++ b/arch/x86/kernel/acpi/boot.c
> > @@ -1031,8 +1031,8 @@ static int __init acpi_parse_madt_lapic_entries(void)
> >  			return ret;
> >  		}
> >  
> > -		x2count = madt_proc[0].count;
> > -		count = madt_proc[1].count;
> > +		count = madt_proc[0].count;
> > +		x2count = madt_proc[1].count;
> >  	}
> >  	if (!count && !x2count) {
          ~~~~~~~~~~~~~~~~~~~~~
I mean here the value checking won't be impacted by the wrong
assignment.

> >  		printk(KERN_ERR PREFIX "No LAPIC entries present\n");
> 
> Why does this bug have no effect?
> 
> Thanks,
> 
> 	Ingo
