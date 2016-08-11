From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 2/2] x86, ACPI: Fix the wrong assignment when Handle
 apic/x2apic entries
Date: Thu, 11 Aug 2016 10:46:52 +0200
Message-ID: <20160811084652.GA4249@gmail.com>
References: <1470697311-1292-1-git-send-email-bhe@redhat.com>
 <1470697311-1292-2-git-send-email-bhe@redhat.com>
 <20160810125333.GB9028@gmail.com>
 <20160810130333.GA5598@x1.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160810130333.GA5598@x1.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Baoquan He <bhe@redhat.com>
Cc: linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


* Baoquan He <bhe@redhat.com> wrote:

> On 08/10/16 at 02:53pm, Ingo Molnar wrote:
> > 
> > * Baoquan He <bhe@redhat.com> wrote:
> > 
> > > It won't impact the result, we still should fix the code bug.
> > > 
> > > Signed-off-by: Baoquan He <bhe@redhat.com>
> > > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > > Cc: Len Brown <len.brown@intel.com>
> > > Cc: Pavel Machek <pavel@ucw.cz>
> > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > Cc: Ingo Molnar <mingo@redhat.com>
> > > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > > Cc: x86@kernel.org
> > > Cc: linux-pm@vger.kernel.org
> > > ---
> > >  arch/x86/kernel/acpi/boot.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
> > > index 90d84c3..2b25d3f 100644
> > > --- a/arch/x86/kernel/acpi/boot.c
> > > +++ b/arch/x86/kernel/acpi/boot.c
> > > @@ -1031,8 +1031,8 @@ static int __init acpi_parse_madt_lapic_entries(void)
> > >  			return ret;
> > >  		}
> > >  
> > > -		x2count = madt_proc[0].count;
> > > -		count = madt_proc[1].count;
> > > +		count = madt_proc[0].count;
> > > +		x2count = madt_proc[1].count;
> > >  	}
> > >  	if (!count && !x2count) {
>           ~~~~~~~~~~~~~~~~~~~~~
> I mean here the value checking won't be impacted by the wrong
> assignment.

Indeed!

Mind putting that into the changelog? Something like:

"By pure accident the bug makes no functional difference, because the only 
 expression where we are using these values is (!count && !x2count), in which
 the variables are interchangeable, but it makes sense to fix the bug 
 nevertheless."

Thanks,

	Ingo
