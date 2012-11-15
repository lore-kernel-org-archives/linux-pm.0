From: Preeti Murthy <preeti.lkml@gmail.com>
Subject: Re: [PATCH] cpuidle: Measure idle state durations with monotonic clock
Date: Thu, 15 Nov 2012 14:34:41 +0530
Message-ID: <CAM4v1pPhaP=pVnFMXUU_nmrOxhY5yPNtbBdQsT5MH37MndK6LQ@mail.gmail.com>
References: <CAODwPW873M32d9zFT9fpJT9+PuMbz8htzUxdF1TNE+J1zR3jYA@mail.gmail.com>
	<1352944590-8776-1-git-send-email-jwerner@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1352944590-8776-1-git-send-email-jwerner@chromium.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Julius Werner <jwerner@chromium.org>
Cc: linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Kevin Hilman <khilman@ti.com>, Andrew Morton <akpm@linux-foundation.org>, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Deepthi Dharwar <deepthi@linux.vnet.ibm.com>, Trinabh Gupta <g.trinabh@gmail.com>, Sameer Nanda <snanda@chromium.org>, Lists Linaro-dev <linaro-dev@lists.linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>
List-Id: linux-pm@vger.kernel.org

Hi all,

The code looks correct and inviting to me as it has led to good cleanups.
I dont think passing 0 as the argument to the function
sched_clock_idle_wakeup_event()
should lead to problems,as it does not do anything useful with the
passed arguments.

My only curiosity is what was the purpose of passing idle residency time to
sched_clock_idle_wakeup_event() when this data could always be retrieved from
dev->last_residency for each cpu,which gets almost immediately updated.

But this does not seem to come in way of this patch for now.Anyway I
have added Peter to
the list so that he can opine about this issue if possible and needed.

Reviewed-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>


Regards
Preeti U Murthy
