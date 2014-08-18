From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH v7 1/8] arm64: kernel: refactor the CPU suspend API for
 retention states
Date: Mon, 18 Aug 2014 15:47:51 +0800
Message-ID: <53F1AFA7.5040003@linaro.org>
References: <1407945127-27554-1-git-send-email-lorenzo.pieralisi@arm.com> <1407945127-27554-2-git-send-email-lorenzo.pieralisi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:61352 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751444AbaHRHtZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 18 Aug 2014 03:49:25 -0400
Received: by mail-pd0-f178.google.com with SMTP id w10so7000266pde.23
        for <linux-pm@vger.kernel.org>; Mon, 18 Aug 2014 00:49:24 -0700 (PDT)
In-Reply-To: <1407945127-27554-2-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc: devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Charles Garcia Tobin <Charles.Garcia-Tobin@arm.com>, Nicolas Pitre <nico@linaro.org>, Rob Herring <robh+dt@kernel.org>, Grant Likely <grant.likely@linaro.org>, Peter De Schrijver <pdeschrijver@nvidia.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Antti Miettinen <ananaza@iki.fi>, Stephen Boyd <sboyd@codeaurora.org>, Kevin Hilman <khilman@linaro.org>, Sebastian Capella <sebcape@gmail.com>, Tomasz Figa <t.figa@samsung.com>, Mark Brown <broonie@kernel.org>, Paul Walmsley <paul@pwsan.com>, Chander Kashyap <k.chander@samsung.com>, Geoff Levand <geoff@infradead.org>, Bartlomiej

On 2014-8-13 23:52, Lorenzo Pieralisi wrote:
> CPU suspend is the standard kernel interface to be used to enter
> low-power states on ARM64 systems. Current cpu_suspend implementation
> by default assumes that all low power states are losing the CPU context,
> so the CPU registers must be saved and cleaned to DRAM upon state
> entry. Furthermore, the current cpu_suspend() implementation assumes
> that if the CPU suspend back-end method returns when called, this has
> to be considered an error regardless of the return code (which can be
> successful) since the CPU was not expected to return from a code path that
> is different from cpu_resume code path - eg returning from the reset vector.
> 
> All in all this means that the current API does not cope well with low-power
> states that preserve the CPU context when entered (ie retention states),
> since first of all the context is saved for nothing on state entry for
> those states and a successful state entry can return as a normal function
> return, which is considered an error by the current CPU suspend
> implementation.
> 
> This patch refactors the cpu_suspend() API so that it can be split in
> two separate functionalities. The arm64 cpu_suspend API just provides
> a wrapper around CPU suspend operation hook. A new function is
> introduced (for architecture code use only) for states that require
> context saving upon entry:
> 
> __cpu_suspend(unsigned long arg, int (*fn)(unsigned long))
> 
> __cpu_suspend() saves the context on function entry and calls the
> so called suspend finisher (ie fn) to complete the suspend operation.
> The finisher is not expected to return, unless it fails in which case
> the error is propagated back to the __cpu_suspend caller.
> 
> The API refactoring results in the following pseudo code call sequence for a
> suspending CPU, when triggered from a kernel subsystem:
> 
> /*
>  * int cpu_suspend(unsigned long idx)
>  * @idx: idle state index
>  */
> {
> -> cpu_suspend(idx)
> 	|---> CPU operations suspend hook called, if present
> 		|--> if (retention_state)
> 			|--> direct suspend back-end call (eg PSCI suspend)
> 		     else
> 			|--> __cpu_suspend(idx, &back_end_finisher);
> }
> 
> By refactoring the cpu_suspend API this way, the CPU operations back-end
> has a chance to detect whether idle states require state saving or not
> and can call the required suspend operations accordingly either through
> simple function call or indirectly through __cpu_suspend() which carries out
> state saving and suspend finisher dispatching to complete idle state entry.
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

This patch is pretty fine to me,

Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>

Thanks
Hanjun
