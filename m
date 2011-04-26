From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC PATCH v2 1/3] PM / Core: suspend_again callback
 for device PM.
Date: Wed, 27 Apr 2011 00:14:20 +0200
Message-ID: <20110426221420.GC29092__40015.3122064241$1303861735$gmane$org@elf.ucw.cz>
References: <1303288106-2965-1-git-send-email-myungjoo.ham@samsung.com>
	<1303781471-2477-1-git-send-email-myungjoo.ham@samsung.com>
	<201104261347.21811.rjw@sisk.pl> <20110426131737.GA13597@suse.de>
	<20110426203853.GC27140@elf.ucw.cz>
	<20110426205745.GB20381@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20110426205745.GB20381@suse.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Greg KH <gregkh@suse.de>
Cc: Len Brown <len.brown@intel.com>, LKML <linux-kernel@vger.kernel.org>, kyungmin.park@samsung.com, MyungJoo Ham <myungjoo.ham@samsung.com>, "Ben Dooks (embedded platforms)" <ben-linux@fluff.org>, "Jean Delvare (PC drivers core)" <khali@linux-fr.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi!

> > > What is the root problem that this is trying to solve?
> > 
> > It is trying to fix machines that need to run periodic kernel tasks
> > even when user asked them to sleep. Zaurus needs to periodicaly wake
> > up to be able to charge battery in s2ram state, for example.
> 
> That sounds like a bug in userspace you are trying to work around.  Why
> not solve it there first?

Can you be more specific?

The userspace is standard Debian; or maybe even init=/bin/bash. I want
to sleep the machine before I move, so I do echo mem >
/sys/power/state, as I do on PC.

Then I do plug the machine into AC when I move near outlet. In PC,
embedded controller wakes up and starts charging. In Zaurus, it is
kernel (SPI+charging drivers) that wake up, start charging, and go
back to sleep.

Then I (the user) press the power button and get "bash#" back. Where
is the userspace bug?
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
