From: Julius Werner <jwerner@chromium.org>
Subject: Re: [PATCH] cpuidle: Measure idle state durations with monotonic clock
Date: Wed, 14 Nov 2012 09:15:58 -0800
Message-ID: <CAODwPW873M32d9zFT9fpJT9+PuMbz8htzUxdF1TNE+J1zR3jYA@mail.gmail.com>
References: <1352843563-16392-1-git-send-email-jwerner@chromium.org>
	<50A37ADD.8040000@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <50A37ADD.8040000@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Kevin Hilman <khilman@ti.com>, Andrew Morton <akpm@linux-foundation.org>, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Deepthi Dharwar <deepthi@linux.vnet.ibm.com>, Trinabh Gupta <g.trinabh@gmail.com>, Sameer Nanda <snanda@chromium.org>, Lists Linaro-dev <linaro-dev@lists.linaro.org>
List-Id: linux-pm@vger.kernel.org

> Maybe you can remove all these computations and set the flag
> en_core_tk_irqen for the driver ? That will be handled by the cpuidle
> framework, no ?
>
> Same comment for the intel_idle driver.

Yeah, I thought about that, too. I was a little too afraid of touching
the sched_clock_idle_wakeup_event() parameter that is tied to the
measurement, but it seems to have been vestigial for some time now and
other drivers also just set it 0. I will whip up another version of
the patch (won't change the PPC further though, if this version works
I would just leave it at that... thanks for testing, Deepthi).
