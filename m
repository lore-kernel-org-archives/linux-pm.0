From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 05/13] PM: Add option to disable
	/sys/power/state interface
Date: Mon, 9 Feb 2009 10:15:06 +0100
Message-ID: <20090209091506.GE28794@atrey.karlin.mff.cuni.cz>
References: <1233802226-23386-1-git-send-email-arve@android.com>
	<200902090040.22364.rjw@sisk.pl>
	<d6200be20902081558r272e13b1q28692eaba758878b@mail.gmail.com>
	<200902090126.17899.rjw@sisk.pl>
	<d6200be20902081735l734ac6c9h811b8ad6f40e2562@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <d6200be20902081735l734ac6c9h811b8ad6f40e2562@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Arve Hj?nnev?g <arve@android.com>
Cc: ncunningham@crca.org.au, u.luckas@road.de, Brian Swetland <swetland@google.com>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi!

> >> > Also, please observe that if there is a mechanism allowing us to put individual
> >> > devices, or entire subsystems (such as a bus with devices attached to it), into
> >> > low power states at run time, without placing the entire system in a sleep
> >> > state, and put them back into the full power state as needed, we won't need
> >> > anything like the "early suspend" introduced by this series of patches.
> >>
> >> While early-suspend is not needed, it is still convenient on an
> >> embedded device where some drivers are clearly only used when the
> >> screen is on.
> >
> > Ah, that's interesting.  So in fact you want some devices to go into low power
> > states as soon as the screen is off and that's why you fint the early-suspend
> > useful.  Is this correct?
> 
> Yes. We turn off the touchscreen and trackball when the screen turns
> off since both these devices use additional power when enabled.
> Neither of these devices can be turned off (after a timeout) while the
> screen is on.

Ok, first: It is not at all clear to me that trackball / touchscreen
is unusable with screen off. For weird cases (using android to
remotely control PC?) screen-off trackball-on makes
sense. Actually... if you are charging than maybe waking up the device
by touching the screen is a good idea? So maybe you are putting a bit
too much policy into kernel.

OTOH, as long as you do it in android-specific code, that's probably
okay.

So lets assume that trackball is unusable with screen off. Stuff is
easy, then either

1) make your useland close trackball/touchscreen devices when they
turn the screen off.

(This is actually preffered, as it keeps policy out of the kernel)

or

2) Just use notifier chain to notify trackball/touchscreen when the
screen is going off.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
