From: Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH 5/6] arm64: wire frequency-invariant accounting support up
 to the task scheduler
Date: Mon, 12 Jun 2017 16:32:28 +0200
Message-ID: <CAKfTPtDzsWPgZsf0gMSKPR7GJ8ovmvdW3_vXv=eyVH_Z6buYzw@mail.gmail.com>
References: <20170608075513.12475-1-dietmar.eggemann@arm.com> <20170608075513.12475-6-dietmar.eggemann@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f47.google.com ([209.85.215.47]:36081 "EHLO
        mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752067AbdFLOcu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Jun 2017 10:32:50 -0400
Received: by mail-lf0-f47.google.com with SMTP id o83so51872657lff.3
        for <linux-pm@vger.kernel.org>; Mon, 12 Jun 2017 07:32:49 -0700 (PDT)
In-Reply-To: <20170608075513.12475-6-dietmar.eggemann@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, LAK <linux-arm-kernel@lists.infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <rmk+kernel@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Juri Lelli <juri.lelli@arm.com>, Peter Zijlstra <peterz@infradead.org>, Morten Rasmussen <morten.rasmussen@arm.com>

On 8 June 2017 at 09:55, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
> Commit dfbca41f3479 ("sched: Optimize freq invariant accounting")
> changed the wiring which now has to be done by associating
> arch_scale_freq_capacity with the actual implementation provided
> by the architecture.
>
> Define arch_scale_freq_capacity to use the arch_topology "driver"
> function topology_get_freq_scale() for the task scheduler's
> frequency-invariant accounting instead of the default
> arch_scale_freq_capacity() in kernel/sched/sched.h.
>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Juri Lelli <juri.lelli@arm.com>
> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>

Acked-by: Vincent Guittot <vincent.guittot@linaro.org>
