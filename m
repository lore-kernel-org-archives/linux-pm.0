From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Fri, 06 Jul 2007 08:46:54 +1000
Message-ID: <1183675615.3388.81.camel__11179.3002266952$1183675663$gmane$org@localhost.localdomain>
References: <20070703042916.GA17240@srcf.ucam.org>
	<200707031608.06348.nigel@nigel.suspend2.net>
	<1183447184.10386.102.camel@localhost.localdomain>
	<200707031456.40890.rjw@sisk.pl>
	<1183497290.3388.4.camel@localhost.localdomain>
	<20070705093013.GA3228@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070705093013.GA3228@elf.ucw.cz>
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
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thu, 2007-07-05 at 11:30 +0200, Pavel Machek wrote:
> 
> ...but the moment you start blocking tasks that done driver request,
> you _do_ have mini-freezer of your own, with pretty much the same
> problems.

No, not at all the same problems. Those tasks will block, but that will
be harmless because we won't have some "freezer" things waiting for all
tasks to reach a "stable" point (calling try_to_freeze()). We just let
them block wherever we want, as long as it doesn't prevent a -driver-
from suspending, which should be allright, we have no problem.

> In another message I shown that removing freezer will not help with
> FUSE in general case.

I disagree.

> It probably does not help with firmware, too; as soon as udev attempts
> to do something with your wireless card, it is blocked, and if the
> wireless card needs the firmware from udev, you are deadlocked.

Firmware load has been a problem since day 1, I've talked about it
multiple times, it's broken with or without the freezer, and so far, the
reaction of pretty much everybody has been to dig their head deeper in
the mud and ignore the problem.

There are other issues (again, with or without freezer) that should be
dealt with. For example, drivers that haven't yet got their suspend()
callback or already have got their resume() may rely on services of the
kernel that are still blocked, that's where things may go hairy.
request_firmware() within resume() is a typical example of that.

There are a few things we should do in that area. For example, once we
start to call driver suspend's, we should probably set a system wide
flag that will do things such as:

 - block usermode helpers (either make call_usermodehelper return
something like -EBUSY or have it queue up the calls and issue them later
when thing are resuming, we need to look closely at what semantic we
want here).

 - Silently add GFP_NOIO to all allocations, to avoid having things
blocking in kmalloc() with a mutex held that will deadlock with
suspend() in a driver for example. Or set some way to have all GFP
waiters wakeup and fail rather than wait for IOs. It's hard/bizarre but
necessary, again, with or without a freezer.

 - Deal with the firmware problem. The best way is probably to have an
async request_firmware interface(). Another thing is, drivers may want
to cache their firmware in main memory, that sort of thing...

And that's just a small list off the top of my mind, of known problems
that will cause deadlocks or misbehaviours today, with or without the
freezer, and that need to be addressed.

Ben.
