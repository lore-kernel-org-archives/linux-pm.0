From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: suspend/resume issue (Was: [PATCH 2/2] Fix
	console	handling during suspend/resume)
Date: Fri, 16 Jun 2006 11:02:13 +1000
Message-ID: <1150419733.7725.51.camel@localhost.localdomain>
References: <Pine.LNX.4.64.0606131418580.5498@g5.osdl.org>
	<Pine.LNX.4.64.0606131435400.5498@g5.osdl.org>
	<20060614103404.GC28536@elf.ucw.cz>
	<Pine.LNX.4.64.0606140820420.5498@g5.osdl.org>
	<Pine.LNX.4.64.0606141042260.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606141042260.5498@g5.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: Power management list <linux-pm@lists.osdl.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org


> My Mac Mini (Intel dual-core CPU) now resumes and suspends in SMP mode =

> too, which was not true just a couple of days ago. It even seems to do it =

> fairly reliable.
> =

> The debugging patch helped me figure out a number of the problems (and =

> even more problems that then didn't actually make any difference once I =

> started getting things working ;)

Hi Linus !

Heh, good to see you on the PM wagon :) One thing we really need to look
into is the problem that when the suspend process starts, at any point
in time, kmalloc() might block forever.

The basic issue is as usual the swap device(s) going down, thus any
allocation that might try to push things out to swap will possibly sleep
forever.

I think we might need something like kmalloc silently switching to NOIO
or something like that when the system state changes to "suspending".

As-is, we have all sort of well hidden possible deadlocks, where a
driver will have some part (a bottom half for example) blocked in a
kmalloc & holding mutex X while that driver's suspend routine gets
called and tries to acquire that same mutex... there are plenty
others... driver suspend calling thigns that implicitely will block on a
kmalloc, etc etc...

My very early proposal for suspend callbacks (years ago, maybe you
remember), had an additional round of callbacks to drivers called
"prepare for suspend" for that. Drivers were supposed to enter a state
where they avoided blocking allocation etc...

Of course, I realize that this was not a good approach: too complex and
we would never have all drivers to properly handle that.

Another source of problems is the request_firmware() interface. Most
drivers use it synchronously and do it at resume() time, when coming
back from sleep. However, on resume, userland is still frozen...the
kernel might still be able to launch things but I wouldn't be too much
on the result, especially since the swap device might potentially be
still suspended too. This is a typical cause of either deadlocks or
non-working wireless devices on resume. Not sure what the perfect
solution here... drivers will _have_ to delay their resume process for
that... one possibility would be to make request_firmware() kind of
interfaces asynchronous only (with a completion callback) and have the
core delay it... that leads to the next issue .. :)

 ... which is hotplug events happening during the suspend process...
Very similar to the above problem: Trying to run userland things when
userland isn't supposed to be in a state where it can handle them.

I proposed a while ago that a way to fix both issues is to 1- make
request_firmware type of interfaces asynchronous only and 2- have the
"core" queue up all userland helper calls when the  suspend process is
in progress and send them as a batch on resume. Of course, that isn't
necessarily totally efficient. A more elaborate option would be to drop
them relying on: 1- for normal hotplug events, we only send a single
"rescan all" event to userland at the end of the resume process where it
basically re-does what it does at boot. 2- call_usermodehelper just
fails with something like -EAGAIN when called in the suspend/resume
process. Thus normal hotplug events are just dropped on the floor. For
request_firmware, the fix is hidden in the implementation of
request_firmware_async which will then queue up the request and re-emit
after the suspend process is over.

All these issues lead to a need to globally:

 - Know that the suspend process has started. That is, userland can't be
relied upon and touching swap is not an option (GFP_KERNEL can
deadlock).
 - Be notified of the above and of the end of the above situation
(suspend process aborted or resume finished). Could just be a global
notifier, I don't think we need that much ordering for this.

With the above, some subsystems could enter a "suspend safe" state that
would make things a lot more reliable. One example is slab/buddy turning
gfp_kernel into noio (and sync'ing all CPUs after doing that to avoid
having a big lock), the usermodehelper stuff, the request firmware
stuff, etc...

Ideas ?

Ben.
 =
