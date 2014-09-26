From: Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [PATCH v6 1/5] qcom: spm: Add Subsystem Power Manager driver
Date: Fri, 26 Sep 2014 11:19:30 -0600
Message-ID: <20140926171930.GF390@ilina-mac.local>
References: <1411516281-58328-1-git-send-email-lina.iyer@linaro.org>
 <1411516281-58328-2-git-send-email-lina.iyer@linaro.org>
 <7h61ga48sq.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:41836 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755653AbaIZRTf (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 26 Sep 2014 13:19:35 -0400
Received: by mail-pd0-f182.google.com with SMTP id y10so1429944pdj.41
        for <linux-pm@vger.kernel.org>; Fri, 26 Sep 2014 10:19:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7h61ga48sq.fsf@deeprootsystems.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kevin Hilman <khilman@kernel.org>
Cc: galak@codeaurora.org, sboyd@codeaurora.org, daniel.lezcano@linaro.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, msivasub@codeaurora.org, lorenzo.pieralisi@arm.com, linux-pm@vger.kernel.org

On Fri, Sep 26 2014 at 10:59 -0600, Kevin Hilman wrote:
>Lina Iyer <lina.iyer@linaro.org> writes:
>
>> Based on work by many authors, available at codeaurora.org
>>
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
>> it interprets the bytes  and executes them in sequence. Each low power
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
>> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
>
>[...]
>
>> +enum {
>> +	MSM_SPM_REG_SAW2_CFG,
>> +	MSM_SPM_REG_SAW2_AVS_CTL,
>> +	MSM_SPM_REG_SAW2_AVS_HYSTERESIS,

>Do you really need the MSM_SPM_REG_ prefix on all of these?  As these
>names are all local to the driver, the extra prefix isn't needed IMO.
>
Nope, I dont.. I will remove them.

>Also, consdiering that SPM seems to be sub-block of SAW2, the fact that
>the SPM shows up twice in some of the names is a bit confusing.
>
I understand. I will fix that.

>
