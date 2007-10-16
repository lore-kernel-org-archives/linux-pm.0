From: David Brownell <david-b@pacbell.net>
Subject: Re: Question about suspending a system
Date: Tue, 16 Oct 2007 10:31:19 -0700
Message-ID: <20071016173119.5266C23BD7D@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
References: <38b2ab8a0710150543k6d35ae12h6dceef96acb00a71@mail.gmail.com>
	<1192464239.3349.57.camel@johannes.berg>
	<20071015164159.3273923A692@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
	<38b2ab8a0710160649r5085d5ccs3a7e298bbde7867a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <38b2ab8a0710160649r5085d5ccs3a7e298bbde7867a@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: francis.moro@gmail.com
Cc: linux-pm@lists.linux-foundation.org, johannes@sipsolutions.net
List-Id: linux-pm@vger.kernel.org

> > In conjunction with that model, the last step of entering a system
> > suspend state should involve disabling all IRQs that aren't flagged as
> > wakeup sources by enable_irq_wake().
>
> Ok, I missed that because I'm using a 2.6.17 kernel.

Yeah, that part went mainline with the genirq framework, which
ISTR merged sometime after that.  But then, few non-{ARM,x86}
platforms do much with power management yet either.


> >  That's shortly before the magic
> > which powers down memory and CPU, but after devices have all been told
> > to suspend themselves.
>
> Is it done in pm_ops->enter method ?

Yes, that's the last step of entering the system power state.
After IRQs are off, etc.


> > Of course, the CPU itself is often only a small part of the system's
> > power usage.  More power is saved by powering devices down, or even
> > off.
>
> I'm thinking of making powering the disk off because when suspended it
> still uses more that 5W !

That would make me want to power it off too!


> >  In that example of a disk drive, one way to handle that would
> > be to introduce a power domain within which the drive's controller
> > and the drive both live.  If that's properly located in the driver
> > model tree, as a device node, then its suspend and resume methods
> > could poer the drive off and on (respectively).
>
> Do you have any examples that you could give ?

No example, sorry -- Linux has weak support of power/voltage domains,
unlike clock domains.  Hence my suggestion of packaging it as a device
tree node, so at least the suspend() and resume() methods get called
in the right place in the system sleep/wake sequence.

Most of the systems I've worked with don't have rotating media, unless
someone sticks a MicroDrive into a CF slot.

- Dave
