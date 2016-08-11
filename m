From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH 2/2] x86, ACPI: Fix the wrong assignment when Handle
 apic/x2apic entries
Date: Thu, 11 Aug 2016 22:20:26 +0800
Message-ID: <20160811142026.GA26981@x1.redhat.com>
References: <1470697311-1292-1-git-send-email-bhe@redhat.com>
 <1470697311-1292-2-git-send-email-bhe@redhat.com>
 <20160810125333.GB9028@gmail.com>
 <20160810130333.GA5598@x1.redhat.com>
 <20160811084652.GA4249@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54548 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750832AbcHKOUd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 11 Aug 2016 10:20:33 -0400
Content-Disposition: inline
In-Reply-To: <20160811084652.GA4249@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, linux-pm@vger.kernel.org

On 08/11/16 at 10:46am, Ingo Molnar wrote:
> > > > -		count = madt_proc[1].count;
> > > > +		count = madt_proc[0].count;
> > > > +		x2count = madt_proc[1].count;
> > > >  	}
> > > >  	if (!count && !x2count) {
> >           ~~~~~~~~~~~~~~~~~~~~~
> > I mean here the value checking won't be impacted by the wrong
> > assignment.
> 
> Indeed!
> 
> Mind putting that into the changelog? Something like:
> 
> "By pure accident the bug makes no functional difference, because the only 
>  expression where we are using these values is (!count && !x2count), in which
>  the variables are interchangeable, but it makes sense to fix the bug 
>  nevertheless."

Sure, this is much clearer. Will use this and repost. Thanks a lot, will
try to do each post using patch log like this.

Thanks
Baoquan

