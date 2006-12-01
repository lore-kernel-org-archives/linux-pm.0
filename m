From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [linux-pm] [RFC] ACPI vs device ordering on resume
Date: Fri, 1 Dec 2006 08:12:11 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0612010810410.3695@woody.osdl.org>
References: <20061114153026.730deb94@freekitty> <200611150203.30965.len.brown@intel.com>
 <Pine.LNX.4.64.0611150839040.3349@woody.osdl.org> <20061201093301.GA1842@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20061201093301.GA1842@elf.ucw.cz>
Sender: linux-acpi-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Len Brown <lenb@kernel.org>, linux-pm@lists.osdl.org, Stephen Hemminger <shemminger@osdl.org>, Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>, linux-acpi@vger.kernel.org, linux-pm@osdl.org, "Rafael J. Wysocki" <rjw@sisk.pl>
List-Id: linux-pm@vger.kernel.org



On Fri, 1 Dec 2006, Pavel Machek wrote:

> > > So it looks like we need this sequence:
> > > 
> > > enable_nonboot_cpus() /* INIT */
> > > finish()	/* _WAK */
> > > device_resume()
> > 
> > Can somebody remind me about this immediately after 2.6.19?
> 
> Remind. But note that freezer is not yet SMP safe... Rafael is working
> on that.

Thanks.

On the other hand, I really wonder (and suspect) whether the problem isn't 
really the freezer or even the kernel resume ordering, but simply an ACPI 
internal resume ordering thing.

Doesn't ACPI have per-device "WAK" calls anyway? Shouldn't we just call 
those _individually_ as we walk the device tree (perhaps in the 
"early_resume" stage) rather than calling them all in one chunk?

		Linus
