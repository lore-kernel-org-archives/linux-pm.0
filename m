From: Pavel Machek <pavel@ucw.cz>
Subject: Re: hibernation/snapshot design [was Re: [PATCH] Remove
	process freezer from suspend to RAM pathway]
Date: Mon, 9 Jul 2007 01:00:42 +0200
Message-ID: <20070708230042.GH5401__28428.8984061734$1183935822$gmane$org@elf.ucw.cz>
References: <Pine.LNX.4.44L0.0707072224270.10912-100000@netrider.rowland.org>
	<200707082115.27363.rjw@sisk.pl>
	<1183928612.3388.289.camel@localhost.localdomain>
	<200707082345.27859.rjw@sisk.pl>
	<1183931688.3388.316.camel@localhost.localdomain>
	<20070708221315.GF5401@elf.ucw.cz>
	<Pine.LNX.4.64.0707081519210.25614@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0707081519210.25614@asgard.lang.hm>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: david@lang.hm
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-kernel@vger.kernel.org, Kyle Moffett <mrmacman_g4@mac.com>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi!

> >>>Actaully, I'm perfectly fine with that, as long as each task blocked by 
> >>>the
> >>>driver due to suspend has PF_FROZEN (or something similar) set.  Then, at
> >>>least theoretically, we'll be able to drop the freezer from the suspend 
> >>>code
> >>>path and move it after device_suspend() (or the hibernation-specific
> >>>equivalent) for hibernation (in that case there shouldn't be a problem 
> >>>with
> >>>any task waiting on I/O while the freezer is running ;-)).
> >>
> >>I don't see the need for a freezer for snapshot but that's a different
> >>issue. (stop_machine looks good enough to me).
> >
> >Freezer is not needed for snapshot -- it is needed so that we can
> >write out the snapshot to disk without the need for special
> >drivers/block/simple-ide-for-suspend.c. (We are doing snapshot, then
> >write to disk from userland code in uswsusp).
> 
> instead of trying to freeze most of the system, could you do something 
> like start a virtual machine sandbox to write the data out, and not let 
> any userspace other then the sandbox operate?
> 
> you would need to throw away disk buffers so that you don't mix current 
> pending I/O with I/O from the sandbox, and this would be a visable change 
> for how suspend is setup, but wouldn't this work?

It feels kind of expensive, but yes, we could use another kernel for
doing the dump. Kdump people are using that. We could use hypervisor
for doing the dump. Xen people are doing that. (But I do not think any
of those solutions is suitable for "lets hibernate my notebook" case).

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
