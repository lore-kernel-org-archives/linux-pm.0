From: Michael Tokarev <mjt@tls.msk.ru>
Subject: hibernate after suspend?
Date: Fri, 31 Oct 2014 14:54:44 +0300
Message-ID: <54537884.9080501@msgid.tls.msk.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from isrv.corpit.ru ([86.62.121.231]:60090 "EHLO isrv.corpit.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757863AbaJaLyt (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 31 Oct 2014 07:54:49 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

Hello.

I've been using a feature for a long time which I found to be
very useful, but which somehow is not really supported by linux,
at least not in an elegant way.  Windows have it out of the box
for a long time.

What I'm talking about is hibernate after suspend, when a computer
turns power after some time being in suspend mode.

Imagine you work on a laptop, you close the lid, and the device
goes to sleep.  If you open it again shortly after, it just resumes
and all is well.   But if you don't use it for longer, it will
slowly draw battery until it is empty.  So next time you open
it, it will not run because battery needs charging.

But it does not really need to be powered up all this time -- it
can just easily turn power much sooner, say, after half a hour
of suspend time (or 10 minutes, whatever -- configurable), just
to be ready and with good battery the next time you open it up,
and with all your processes/work running still.

Another example is when you suspend your desktop and it goes to
hibernate mode just to save power, etc.

Ofcourse after it hibernates it may take longer to resume (or
else you can just hibernate always), but in many situations it
is really worth it.  Like that laptop case, -- the bonus is
that the laptop actually works when you need it.

For a long time I had a script in my suspend handlers (in pm-
utils initially, now in /lib/systemd/system-sleep/), which,
when entering suspend state, saved current rtc time to a file
in /run and started an rtc timer to be woken up within 10
minutes.  When it wakes, it checks the current rtc time, and
if it is within these 10 minutes +/- 20 sec, it does hibernation,
or else it cancels the rtc timer.

It works.

But it requires complete machine wakeup, with spinning up all
rotational disks etc, just to suspend again.  Which is very
inefficient ofcourse, and, in case of laptop, draws additional
energy.

If we did hybrid-suspend initially, the only thing needed to
complete the procedure in this case is to turn the power off,
there's no need to awake at all, since all images are already
saved.

So what I'm asking is -- what's needed for the kernel (I guess
it shuld be the kernel) to assist in this?

Note that Intel has a very similar technology implemented in
firmware, named Rapid Start Technology (intel_rst) -- it does
basically the same thing, the machine wakes up after configured
time in suspend and the firmware saves memory content to a
partition on an SSD.  It works, but linux implementation is
much faster, it works not only on ssd, it is much easier to
setup (if it were supported, -- right now one have to write a
script to handle it in /lib/systemd/system-sleep/ or equivalent).

Ofcourse, the whole thing needs to be supported in the userspace
too, eg in gnome/kde/whatever, so that the timeout(s) will be
configurable.

Or maybe there's some other mechanism I'm overlooking?

Thanks,

/mjt

