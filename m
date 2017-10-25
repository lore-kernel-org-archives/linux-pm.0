From: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: How to power gate a specific single device from outside?
Date: Wed, 25 Oct 2017 20:42:39 +0100
Message-ID: <20171025204239.47a80251@alans-desktop>
References: <CAHKzcEP6dQ1PxB35yCW_R1W8yZCCsJN_HqiZ6uq2d+sZp_9EYw@mail.gmail.com>
        <20171025005635.57f1b926@alans-desktop>
        <CAHKzcEORSo2X7uEsOzeR7WpzN+2T4pYAdh1QDZ5nd9kBD-w=sA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from www.llwyncelyn.cymru ([82.70.14.225]:40484 "EHLO fuzix.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751725AbdJYTmn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 25 Oct 2017 15:42:43 -0400
In-Reply-To: <CAHKzcEORSo2X7uEsOzeR7WpzN+2T4pYAdh1QDZ5nd9kBD-w=sA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

> Now, what I need in the kernel is to _selectively_ suspend devices
> that are not needed in the "backup/emergency" mode.

Which means you need to get the applications using them to die - or you
could rewrite the driver top to bottom to have locking sufficient to
ensure that your power management changes don't interact with any
existing functionality and every function neatly aborts or errors in a
safe way to the userspace which you've also modified extensively to cope.

I knmow which I'd choose.

> If current state of the power frameworks for system sleep, runtime pm,
> genpd etc. are not able to handle this transition, and as far as I
> understand these subsystems they cannot handle this straight away

Correct - nor can you handle it straight away because you might be in the
middle of doing something so need to finish a transactio before you can
drop to a lower power level.

> In DT we could specify which devices should go in low power state when
> in emergency mode eg.
> node {
>     ....
>     suspend-in-emergency;
>     .....
> }

If a component of your hardware has a low power mode then why aren't you
always putting it in lowest power mode except when it's in current use ?

> So the device driver knows if it should be suspended in
> PM_SUSPEND_EMERGENCY or not.  The driver has to provide a callback in
> pm_ops to handle this transition or we could reuse suspend callback if
> possible.

You need to re-use the existing power management logic, and in many cases
that means you'll need to shut down the userspace processes that are
keeping the device busy because they will be keeping it from going to
sleep.

> Just a brief idea. Does it make sense to anyone?

So the normal way you do this kind of stuff is to use runlevels with init
(or the systemd equivalents)

When the power goes poof you change runlevel. init kills off and
shuts down all the services you want to drop. Those close the devices,
which being well behaved shove themselves into the deepest sleep they can.

When the power comes back you switch runlevel back and stuff respawns.

Alan
