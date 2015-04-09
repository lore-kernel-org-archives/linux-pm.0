From: Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [PATCH v18 01/11] ARM: qcom: Add Subsystem Power Manager (SPM)
 driver
Date: Thu, 9 Apr 2015 11:04:49 -0600
Message-ID: <20150409170449.GC943@linaro.org>
References: <1427315136-44321-1-git-send-email-lina.iyer@linaro.org>
 <1427315136-44321-2-git-send-email-lina.iyer@linaro.org>
 <20150409165841.GA30503@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150409165841.GA30503@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: daniel.lezcano@linaro.org, khilman@linaro.org, galak@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, lorenzo.pieralisi@arm.com, msivasub@codeaurora.org, devicetree@vger.kernel.org, agross@codeaurora.org, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-pm@vger.kernel.org

On Thu, Apr 09 2015 at 10:58 -0600, Stephen Boyd wrote:
>On 03/25, Lina Iyer wrote:
>> SPM is a hardware block that controls the peripheral logic surrounding
>> the application cores (cpu/l$). When the core executes WFI instruction,
>> the SPM takes over the putting the core in low power state as
>> configured. The wake up for the SPM is an interrupt at the GIC, which
>> then completes the rest of low power mode sequence and brings the core
>> out of low power mode.
>>
>> The SPM has a set of control registers that configure the SPMs
>> individually based on the type of the core and the runtime conditions.
>> SPM is a finite state machine block to which a sequence is provided and
>> it interprets the bytes and executes them in sequence. Each low power
>> mode that the core can enter into is provided to the SPM as a sequence.
>>
>> Configure the SPM to set the core (cpu or L2) into its low power mode,
>> the index of the first command in the sequence is set in the SPM_CTL
>> register. When the core executes ARM wfi instruction, it triggers the
>> SPM state machine to start executing from that index. The SPM state
>> machine waits until the interrupt occurs and starts executing the rest
>> of the sequence until it hits the end of the sequence. The end of the
>> sequence jumps the core out of its low power mode.
>>
>> Add support for an idle driver to set up the SPM to place the core in
>> Standby or Standalone power collapse mode when the core is idle.
>>
>> Based on work by: Mahesh Sivasubramanian <msivasub@codeaurora.org>,
>> Ai Li <ali@codeaurora.org>, Praveen Chidambaram <pchidamb@codeaurora.org>
>> Original tree available at -
>> git://codeaurora.org/quic/la/kernel/msm-3.10.git
>>
>> Cc: Stephen Boyd <sboyd@codeaurora.org>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: Kevin Hilman <khilman@linaro.org>
>> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
>> ---
>
>Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
>
Thank you.

>I suppose you're going to wait for 4.2 on this? It seems to
>depend on dlezcano's patches in the cpuidle tree and some scm
>patches that have gone through arm-soc.
>
Just this morning, I sent out a mail to Kumar, Olof and Arnd. Lets see
if this can be pulled in before 4.2.
>-- 
>Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
>a Linux Foundation Collaborative Project
