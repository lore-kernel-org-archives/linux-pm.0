From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] cpuidle:powernv: Make the snooze timeout dynamic.
Date: Mon, 04 Jun 2018 21:27:40 +1000
Message-ID: <87fu22bxlf.fsf@concordia.ellerman.id.au>
References: <1527768909-32637-1-git-send-email-ego@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1527768909-32637-1-git-send-email-ego@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Daniel Lezcano <daniel.lezcano@linaro.org>, Stewart Smith <stewart@linux.vnet.ibm.com>, Michael Neuling <mikey@neuling.org>, Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>, Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>, Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
List-Id: linux-pm@vger.kernel.org

"Gautham R. Shenoy" <ego@linux.vnet.ibm.com> writes:

> From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
>
> The commit 78eaa10f027c ("cpuidle: powernv/pseries: Auto-promotion of
> snooze to deeper idle state") introduced a timeout for the snooze idle
> state so that it could be eventually be promoted to a deeper idle
> state. The snooze timeout value is static and set to the target
> residency of the next idle state, which would train the cpuidle
> governor to pick the next idle state eventually.
>
> The unfortunate side-effect of this is that if the next idle state(s)
> is disabled, the CPU will forever remain in snooze, despite the fact
> that the system is completely idle, and other deeper idle states are
> available.

That sounds like a bug, I'll add?

Fixes: 78eaa10f027c ("cpuidle: powernv/pseries: Auto-promotion of snooze to deeper idle state")
Cc: stable@vger.kernel.org # v4.2+

cheers
