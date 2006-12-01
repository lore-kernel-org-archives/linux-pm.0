From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [linux-pm] [RFC] ACPI vs device ordering on resume
Date: Fri, 1 Dec 2006 10:40:40 -0800
Message-ID: <20061201104040.7e936bb9@freekitty>
References: <20061114153026.730deb94@freekitty>
	<200611150203.30965.len.brown@intel.com>
	<Pine.LNX.4.64.0611150839040.3349@woody.osdl.org>
	<20061201093301.GA1842@elf.ucw.cz>
	<Pine.LNX.4.64.0612010810410.3695@woody.osdl.org>
	<45706A4F.6090200@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <45706A4F.6090200@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>, linux-acpi@vger.kernel.org, linux-pm@osdl.org, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On Fri, 01 Dec 2006 20:45:51 +0300
Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com> wrote:

> Linus Torvalds wrote:
> > On Fri, 1 Dec 2006, Pavel Machek wrote:
> >
> >   
> >>>> So it looks like we need this sequence:
> >>>>
> >>>> enable_nonboot_cpus() /* INIT */
> >>>> finish()	/* _WAK */
> >>>> device_resume()
> >>>>         
> >>> Can somebody remind me about this immediately after 2.6.19?
> >>>       
> >> Remind. But note that freezer is not yet SMP safe... Rafael is working
> >> on that.
> >>     
> >
> > Thanks.
> >
> > On the other hand, I really wonder (and suspect) whether the problem isn't 
> > really the freezer or even the kernel resume ordering, but simply an ACPI 
> > internal resume ordering thing.
> >
> > Doesn't ACPI have per-device "WAK" calls anyway? Shouldn't we just call 
> > those _individually_ as we walk the device tree (perhaps in the 
> > "early_resume" stage) rather than calling them all in one chunk?
> >
> > 		Linus
> >   
> _WAK method is system-wide. Individual objects do not have their own 
> resume methods.
> One way of reordering internal ACPI resume is done in patch series to 
> 7122, I mentioned that earlier.
> It's possible to resume ACPI devices after execution of _WAK in pm->finish.

Does it solve the original problem where finish() was getting run after
device_resume(), and finish() was corrupting PCI register settings like
MSI?


-- 
Stephen Hemminger <shemminger@osdl.org>
