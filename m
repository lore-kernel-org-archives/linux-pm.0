From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH v18 01/11] ARM: qcom: Add Subsystem Power Manager (SPM) driver
Date: Fri, 03 Apr 2015 14:53:55 -0700
Message-ID: <7hlhi8280c.fsf@deeprootsystems.com>
References: <1427315136-44321-1-git-send-email-lina.iyer@linaro.org>
	<1427315136-44321-2-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:36594 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752223AbbDCVx7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 3 Apr 2015 17:53:59 -0400
Received: by pabsx10 with SMTP id sx10so36319587pab.3
        for <linux-pm@vger.kernel.org>; Fri, 03 Apr 2015 14:53:59 -0700 (PDT)
In-Reply-To: <1427315136-44321-2-git-send-email-lina.iyer@linaro.org> (Lina
	Iyer's message of "Wed, 25 Mar 2015 14:25:26 -0600")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: daniel.lezcano@linaro.org, sboyd@codeaurora.org, galak@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, lorenzo.pieralisi@arm.com, msivasub@codeaurora.org, devicetree@vger.kernel.org, agross@codeaurora.org, Arnd Bergmann <arnd@arndb.de>

Lina Iyer <lina.iyer@linaro.org> writes:

> SPM is a hardware block that controls the peripheral logic surrounding
> the application cores (cpu/l$). When the core executes WFI instruction,
> the SPM takes over the putting the core in low power state as
> configured. The wake up for the SPM is an interrupt at the GIC, which
> then completes the rest of low power mode sequence and brings the core
> out of low power mode.
>
> The SPM has a set of control registers that configure the SPMs
> individually based on the type of the core and the runtime conditions.
> SPM is a finite state machine block to which a sequence is provided and
> it interprets the bytes and executes them in sequence. Each low power
> mode that the core can enter into is provided to the SPM as a sequence.
>
> Configure the SPM to set the core (cpu or L2) into its low power mode,
> the index of the first command in the sequence is set in the SPM_CTL
> register. When the core executes ARM wfi instruction, it triggers the
> SPM state machine to start executing from that index. The SPM state
> machine waits until the interrupt occurs and starts executing the rest
> of the sequence until it hits the end of the sequence. The end of the
> sequence jumps the core out of its low power mode.
>
> Add support for an idle driver to set up the SPM to place the core in
> Standby or Standalone power collapse mode when the core is idle.
>
> Based on work by: Mahesh Sivasubramanian <msivasub@codeaurora.org>,
> Ai Li <ali@codeaurora.org>, Praveen Chidambaram <pchidamb@codeaurora.org>
> Original tree available at -
> git://codeaurora.org/quic/la/kernel/msm-3.10.git
>
> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Kevin Hilman <khilman@linaro.org>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>

Acked-by: Kevin Hilman <khilman@linaro.org>

and also tested on qcom-apq8064-ifc6410 and
qcom-msm8974-sony-xperia-honami and saw the various states being entered
on all CPUs.

Tested-by: Kevin Hilman <khilman@linaro.org>

Kevin
