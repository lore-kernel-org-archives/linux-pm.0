From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] cpuidle: Allow menu governor to enter deeper sleep states
 after some time
Date: Thu, 19 Oct 2017 03:46:36 -0400
Message-ID: <CAJvTdKkDcfNvLUq6fond7s2qG-UiZOAjszJOUmoGHsE6MTsVyw@mail.gmail.com>
References: <a181bf42-9462-476c-6dcd-39fc7151957f@tu-dresden.de> <4491b9f9-bc6f-f173-5816-c46a2f41de8e@tu-dresden.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f178.google.com ([209.85.220.178]:48842 "EHLO
        mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751828AbdJSHqh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Oct 2017 03:46:37 -0400
Received: by mail-qk0-f178.google.com with SMTP id d67so9311394qkg.5
        for <linux-pm@vger.kernel.org>; Thu, 19 Oct 2017 00:46:37 -0700 (PDT)
In-Reply-To: <4491b9f9-bc6f-f173-5816-c46a2f41de8e@tu-dresden.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Ilsche <thomas.ilsche@tu-dresden.de>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Alex Shi <alex.shi@linaro.org>, Ingo Molnar <mingo@kernel.org>, Rik van Riel <riel@redhat.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Nicholas Piggin <npiggin@gmail.com>, Linux PM list <linux-pm@vger.kernel.org>, =?UTF-8?Q?Marcus_H=C3=A4hnel?= <mhaehnel@os.inf.tu-dresden.de>, Daniel Hackenberg <daniel.hackenberg@tu-dresden.de>, =?UTF-8?Q?Robert_Sch=C3=B6ne?= <robert.schoene@tu-dresden.de>, "mario.bielert@tu-dresden.de" <mario.bielert@tu-dresden.de>

Thomas,

Thanks for doing this investigation and sending this note.   It was
very helpful that you boiled down the stimulus to a simple example
sequence.  I created an "idle-virus" using that sequence, and I can
reproduce your results on my hardware.

Indeed, it is actually possible to observe this issue by comparing a
big idle system in single user mode vs multi-user mode.  Simply run
turbostat in both scenarios and watch the C-states requested and
Pkg%pc6 achieved, and the RAPL DC power consumed.  The "background OS
noise" in multi-user mode is enough to trigger the issue you describe.
C1E is requested and Pkg%pc6 sometimes go to zero, even when Busy% is
0.

To prove that this is the result of OS C-state demotion, I have
implemented option "d)" in your paper.  I added a module param,
currently called "cpuidle.powersave", that causes cpuidle to bypass
the governor altogether and select the deepest state that is allowed
by PM_QOS.  (maybe I should call it cpuidle.bypass, or
cpuidle.deepest...)  When i set this parameter,  multi-user C-state
residency and power equal that seen in single-user mode, with no
spikes.

Note that the paper is not correct when it states that the OS can not
enforce latency constraints when relying on HW C-state selection.  The
OS PM_QOS constraint is still effective in this path because it can
still limit the OS request, and the HW will never "promote" to a
deeper state than that requested by the OS -- the hardware can only
demote and then un-demote -- but never deeper than the OS request.

Indeed, on systems where PM_QOS is used properly (and it is working
correctly, a different story), and where the hardware is smart about
demoting C-states, one can make a case that the menu governor is not
needed at all.

Regarding your proposed patch.  I agree with the concept, but not the
implementation.  Rather than create a new timer, we should simply
decline to disable the OS tick when we predict short idle on the
tickless-idle-kernel.  That existing timer is a sufficient "safety
net" to assure that the shallow C-state does not run too long.
Indeed, Aubrey Li has discovered that it is also a latency issue for
the OS to be disabling and then re-enabling the timer tick for short
idles, so this is a situation where if we do less work, we can help
both performance and power!:-)

Also, I think we should re-examine menu governor's heuristic that you
pointed out where it throws out some results -- maybe that isn't such
a great heuristic...

thanks,
-Len

ps. I strongly encourage you to universally use the words "shallow"
and "deep" to describe C-states, and never use the words of "high" and
"low".  The former are never ambiguous.  The later can get very
confusing because a higher latency C-state have lower power, and the
numbering of C-states has lower power C-states with higher numbers...
