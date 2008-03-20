From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH -mm] kexec jump -v9
Date: Fri, 21 Mar 2008 00:40:32 +0100
Message-ID: <200803210040.33982.rjw__17765.0482081392$1206056596$gmane$org@sisk.pl>
References: <200803202345.25083.rjw@sisk.pl>
	<Pine.LNX.4.44L0.0803201858030.8453-100000@netrider.rowland.org>
	<20080320232205.GF17431@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080320232205.GF17431@elf.ucw.cz>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Len Brown <len.brown@intel.com>, nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Vivek Goyal <vgoyal@redhat.com>
List-Id: linux-pm@vger.kernel.org

On Friday, 21 of March 2008, Pavel Machek wrote:
> On Thu 2008-03-20 19:01:56, Alan Stern wrote:
> > On Thu, 20 Mar 2008, Rafael J. Wysocki wrote:
> > 
> > > > > >> Well, I've been saying that for I-don't-remember-how-long: on my box, if you
> > > > > >> use S5 instead of entering S4, the fan doesn't work correctly after the
> > > > > >> resume.  Plain and simple.
> > > > > >> 
> > > > > >> Perhaps there's a problem with our ACPI drivers that causes this to happen,
> > > > > >> but I have no idea what that can be at the moment.
> > > > > >
> > > > > > IMO it would be worthwhile to track this down.  It's a clear indication 
> > > > > > that something is wrong somewhere.
> > > > > >
> > > > > > Could it be connected with the way the boot kernel hands control over
> > > > > > to the image kernel?  Presumably ACPI isn't prepared to deal with that
> > > > > > sort of thing during a boot from S5.  It would have to be fooled into
> > > > > > thinking the two kernels were one and the same.
> > > > > 
> > > > > It should be easy to test if it is a hand over problem, by turning off
> > > > > the laptop by placing it in S5 (shutdown -h now) and then booting same
> > > > > kernel again.
> > > > 
> > > > Feel free to help with testing.
> > > > 
> > > > I believe ACPI is simply getting confused by us overwriting memory
> > > > with that from old image. I don't see how you can emulate it with
> > > > shutdown.
> > > 
> > > Well, in fact ACPI has something called the NVS memory, which we're supposed
> > > to restore during the resume and which we're not doing.  The problem may be
> > > related to this.
> > 
> > No, it can't be.  ACPI won't expect the NVS memory to be restored 
> > following an S5-shutdown.  In fact, as far as ACPI is concerned, 
> > resuming from an S5-type hibernation should not be considered a resume 
> > at all but just an ordinary reboot.

I agree here.

> > All ACPI-related memory areas in the boot kernel should be passed directly
> > through to the image kernel.

However, the image kernel is supposed to restore the NVS area (from the
image) before executing _WAK.

> How can we pass interpretter state? I do not think we do this kind of
> passing.

The interpreter state is passed withing the image.  The platform state is not.

> If it was enough to pass some static area, we could just mark it
> nosave...
> 
> Len: Is ACPI AML permitted to allocate memory (like in ACPI_ALLOC or
> something)? Could we easily identify BIOS data so we could mark them
> nosave?

This wouldn't work even if we could (at least on x86-64).

In fact I'm going to remove the 'nosave' section in the future (another
thing on the todo list).

Thanks,
Rafael
