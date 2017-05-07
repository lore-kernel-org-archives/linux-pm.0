From: Lukas Wunner <lukas@wunner.de>
Subject: Question on 1d9174fbc55e (pm_runtime_force_suspend/resume)
Date: Sun, 7 May 2017 11:13:27 +0200
Message-ID: <20170507091327.GA20263@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.hostsharing.net ([83.223.95.204]:33787 "EHLO
        mailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756936AbdEGWKH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 7 May 2017 18:10:07 -0400
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-pm@vger.kernel.org, Marek Szyprowski <m.szyprowski@samsung.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Kevin Hilman <khilman@baylibre.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Hi Ulf,

I'm trying (and failing) to understand your commit 1d9174fbc55e ("PM /
Runtime: Defer resuming of the device in pm_runtime_force_resume()")
and was hoping that you could give me a clue:

You're acquiring a runtime PM ref on the parent when a device is force-
suspended and releasing it when it's force-resumed.  Moreover you're only
doing this if the device was runtime active upon force-suspend.

What is the purpose of this?

I researched in the mailing list archive and it seems your commit
superseded a patch submitted by Laurent Pinchart which sought to prevent
a gratuitous runtime resume when coming out of system sleep if the device
was runtime suspended before sleep:
https://lkml.org/lkml/2016/3/3/807

The commit message of 1d9174fbc55e also cites this as motivation for the
change.  It does not explain why a runtime PM ref on the parent needs to
be held.

The commit adds a "goto out" to pm_runtime_force_resume() and this would
already seem sufficient to achieve the objective described in the commit
message.

The commit adds the following comment to pm_runtime_force_suspend():

+       /*
+        * Increase the runtime PM usage count for the device's parent, in case
+        * when we find the device being used when system suspend was invoked.
+        * This informs pm_runtime_force_resume() to resume the parent
+        * immediately, which is needed to be able to resume its children,
+        * when not deferring the resume to be managed via runtime PM.
+        */
+       if (dev->parent && atomic_read(&dev->power.usage_count) > 1)
+               pm_runtime_get_noresume(dev->parent);

The comment talks about pm_runtime_force_resume() having to "resume the
parent immediately", but there is no code to that effect in the function.

"Resuming immediately" would presumably involve pm_runtime_get_sync() to
ensure that the parent is runtime active before the force-suspended device
can be resumed.  But there is no call to pm_runtime_get_sync() in
pm_runtime_force_resume().  Instead, the function *drops* a runtime PM ref
on the parent, allowing it to runtime suspend!

So let's look at it the other way round, what is the *effect* of your
change, maybe this will explain what its purpose is:  The effect is that
you keep the parent runtime active while the child is force-suspended.

First of all, this seems entirely gratuitous because the parent will
not runtime suspend as long as its child_count is non-zero.  You're
not decreasing the parent's child_count in pm_runtime_force_suspend(),
so the parent cannot suspend and consequently increasing its usage_count
is superfluous.

(Okay the argument is moot if ignore_children is set on the parent,
but you're not checking that field in pm_runtime_force_suspend/resume().)

Secondly, why would you want to prevent the parent from suspending while
the child is force-suspended?  It seems like a waste of energy to me.

Thirdly, in pm_runtime_force_resume(), you're releasing the runtime PM
ref on the parent *before* the child is resumed.  If the purpose of the
runtime PM ref is to ensure wakefulness of the parent when the child is
force-resumed, shouldn't the PM ref be held until *after* the child is
runtime active again?

Another thing that confuses me is that you're acquiring the runtime PM
ref with "_noresume" and releasing with "_noidle".  In other words, the
effect of your change as stated above, that you keep the parent runtime
active while the child is force-suspend, is not achieved if the parent
was runtime suspended upon force-suspending the child.  (I can only see
this happening if ignore_children is set on the parent, but then why is
a runtime PM ref necessary at all?)

My confusion is complete, can you help me make sense of it?

Thanks,

Lukas
