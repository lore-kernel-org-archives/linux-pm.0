From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [1/3] cpuidle: powerpc: cpuidle set polling before enabling irqs
Date: Thu, 29 Jun 2017 22:21:10 +1000 (AEST)
Message-ID: <3wyzKL1g2Vz9s65@ozlabs.org>
References: <20170614130241.19865-2-npiggin@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170614130241.19865-2-npiggin@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linuxppc-dev@lists.ozlabs.org
Cc: "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>, linux-pm@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Wed, 2017-06-14 at 13:02:39 UTC, Nicholas Piggin wrote:
> local_irq_enable can cause interrupts to be taken which could
> take significant amount of processing time. The idle process
> should set its polling flag before this, so another process that
> wakes it during this time will not have to send an IPI.
> 
> Expand the TIF_POLLING_NRFLAG coverage to as large as possible.
> 
> Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/3fc5ee927ff4ffed6aa2fcd44d2fbf

cheers
