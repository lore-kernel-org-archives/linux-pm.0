From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [1/3] cpuidle: powerpc: cpuidle set polling before enabling irqs
Date: Fri, 30 Jun 2017 13:45:09 +1000
Message-ID: <878tkaqgu2.fsf@concordia.ellerman.id.au>
References: <20170614130241.19865-2-npiggin@gmail.com> <3wyzKL1g2Vz9s65@ozlabs.org> <CAJZ5v0g2DMRcL78k2+qA0svxGqtt-sTW2BpcfvRjU-=iCBjEYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from ozlabs.org ([103.22.144.67]:57299 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751696AbdF3DpM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 29 Jun 2017 23:45:12 -0400
In-Reply-To: <CAJZ5v0g2DMRcL78k2+qA0svxGqtt-sTW2BpcfvRjU-=iCBjEYg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>, Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>, Linux PM <linux-pm@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

"Rafael J. Wysocki" <rafael@kernel.org> writes:

> On Thu, Jun 29, 2017 at 2:21 PM, Michael Ellerman
> <patch-notifications@ellerman.id.au> wrote:
>> On Wed, 2017-06-14 at 13:02:39 UTC, Nicholas Piggin wrote:
>>> local_irq_enable can cause interrupts to be taken which could
>>> take significant amount of processing time. The idle process
>>> should set its polling flag before this, so another process that
>>> wakes it during this time will not have to send an IPI.
>>>
>>> Expand the TIF_POLLING_NRFLAG coverage to as large as possible.
>>>
>>> Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
>>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>>
>> Series applied to powerpc next, thanks.
>>
>> https://git.kernel.org/powerpc/c/3fc5ee927ff4ffed6aa2fcd44d2fbf
>
> OK
>
> I've applied it too, so I guess I should drop it?

Erk sorry. I hadn't heard anything so I picked it up.

If you can drop it that would be good, but if not git will probably work
it out mostly :)

cheers
