From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Run-time PM idea (was: Re: [RFC][PATCH 0/2]
	PM:	Rearrange core suspend code)
Date: Wed, 24 Jun 2009 17:03:09 +0200
Message-ID: <20090624150309.GD1784@ucw.cz>
References: <20090608130509.GA3272@elte.hu>
	<20090608131159.GA15100@srcf.ucam.org>
	<20090608132235.GC13214@elte.hu>
	<20090608133215.GA15482@srcf.ucam.org>
	<20090608134647.GA14234@elte.hu>
	<20090608135431.GA16052@srcf.ucam.org>
	<20090608142450.GE14234@elte.hu>
	<20090608143513.GB16752@srcf.ucam.org>
	<20090608144455.GA20905@elte.hu>
	<20090608145102.GA17427@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20090608145102.GA17427@srcf.ucam.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org


> > > [...] Yes, we can greatly expand the userland-visible interface to 
> > > every piece of hardware in order to make this work, but that's a 
> > > huge amount of effort to avoid a model where userspace sets some 
> > > tunables appropriately.
> > 
> > What huge amount of effort? All you are doing is to track the "is 
> > the device really used" state in user-space - and, if the current 
> > desktop experience is any measure, highly imperfectly so.
> > 
> > What i'm suggesting is to track it properly in the kernel. It's not 
> > like the kernel doesnt need to know whether a piece of hardware is 
> > under use or not ...
> 
> So, for instance, we need to add interfaces like "I care about hotplug 
> events on this SATA port" and "I'm listening for these keys so please 
> don't suspend the device" and "The service bound to this port needs to 
> maintain network connectivity and the one bound to this port doesn't, so 
> only put the wireless card into deep powersave if the first exits", and 
> then we need to wait for userspace to adopt these interfaces before we 
> can enable any of the functionality because otherwise old userspace will 
> be broken with new kernels.

Yes, that's the way to go. It is not particulary easy way, but at
least such userspace will work with upcoming hardware and kernel will
be able to get features such as 'system autosuspend'...
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
