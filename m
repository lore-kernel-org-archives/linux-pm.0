From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 2/2] PM / sleep: don't suspend parent when async child
 suspend_{noirq,early} fails
Date: Thu, 27 Oct 2016 17:34:06 +0200
Message-ID: <20161027153406.GA3208@kroah.com>
References: <1476923170-111986-1-git-send-email-briannorris@chromium.org>
 <1476923170-111986-2-git-send-email-briannorris@chromium.org>
 <20161020004610.GC78840@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:34590 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937392AbcJ0Pjn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Oct 2016 11:39:43 -0400
Content-Disposition: inline
In-Reply-To: <20161020004610.GC78840@google.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Brian Norris <briannorris@chromium.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org, Doug Anderson <dianders@chromium.org>, Brian Norris <computersforpeace@gmail.com>, Jeffy Chen <jeffy.chen@rock-chips.com>, linux-pm@vger.kernel.org, Chuansheng Liu <chuansheng.liu@intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Wed, Oct 19, 2016 at 05:46:11PM -0700, Brian Norris wrote:
> Ugh, as I hope the patch context makes clear, the subject should be
> 
> s/early/late/
> 
> as should the body of the commit message.
> 
> On Wed, Oct 19, 2016 at 05:26:10PM -0700, Brian Norris wrote:
> > Consider two devices, A and B, where B is a child of A, and B utilizes
> > asynchronous suspend (it does not matter whether A is sync or async). If
> > B fails to suspend_noirq() or suspend_early(), or is interrupted by a
> 
> s/early/late/
> 
> > wakeup (pm_wakeup_pending()), then it aborts and sets the async_error
> > variable. However, device A does not (immediately) check the async_error
> > variable; it may continue to run its own suspend_noirq()/suspend_early()
> 
> s/early/late/
> 
> > callback. This is bad.
> > 
> > We can resolve this problem by checking the async_error flag after
> > waiting for children to suspend, using the same logic for the noirq and
> > late suspend cases as we already do for __device_suspend().
> > 
> > It's easy to observe this erroneous behavior by, for example, forcing a
> > device to sleep a bit in its suspend_noirq() (to ensure the parent is
> > waiting for the child to complete), then return an error, and watch the
> > parent suspend_noirq() still get called. (Or similarly, fake a wakeup
> > event at the right (or is it wrong?) time.)
> > 
> > Fixes: de377b397272 ("PM / sleep: Asynchronous threads for suspend_late")
> > Fixes: 28b6fd6e3779 ("PM / sleep: Asynchronous threads for suspend_noirq")
> > Reported-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> > Signed-off-by: Brian Norris <briannorris@chromium.org>
> 
> If the patch is otherwise acceptable, feel free to make the above edits.
> Or I can fix them up if I send v2.

Please fix up, we should never have to hand-edit a changelog text...
