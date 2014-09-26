From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH v6 1/5] qcom: spm: Add Subsystem Power Manager driver
Date: Fri, 26 Sep 2014 12:04:28 -0700
Message-ID: <7hwq8q2og3.fsf@deeprootsystems.com>
References: <1411516281-58328-1-git-send-email-lina.iyer@linaro.org>
	<1411516281-58328-2-git-send-email-lina.iyer@linaro.org>
	<1F7E5951-7704-4ADE-A1D1-2E380FF2540A@codeaurora.org>
	<20140924184750.GA1004@ilina-mac.local>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20140924184750.GA1004@ilina-mac.local> (Lina Iyer's message of
	"Wed, 24 Sep 2014 12:47:50 -0600")
Sender: linux-arm-msm-owner@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: Kumar Gala <galak@codeaurora.org>, sboyd@codeaurora.org, daniel.lezcano@linaro.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, msivasub@codeaurora.org, lorenzo.pieralisi@arm.com, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Lina Iyer <lina.iyer@linaro.org> writes:

> On Wed, Sep 24 2014 at 12:07 -0600, Kumar Gala wrote:
>>
>>On Sep 23, 2014, at 6:51 PM, Lina Iyer <lina.iyer@linaro.org> wrote:
>>
>>> Based on work by many authors, available at codeaurora.org
>>>
>>> SPM is a hardware block that controls the peripheral logic surrounding
>>> the application cores (cpu/l$). When the core executes WFI instruction,
>>> the SPM takes over the putting the core in low power state as
>>> configured. The wake up for the SPM is an interrupt at the GIC, which
>>> then completes the rest of low power mode sequence and brings the core
>>> out of low power mode.
>>>
>>> The SPM has a set of control registers that configure the SPMs
>>> individually based on the type of the core and the runtime conditions.
>>> SPM is a finite state machine block to which a sequence is provided and
>>> it interprets the bytes  and executes them in sequence. Each low power
>>> mode that the core can enter into is provided to the SPM as a sequence.
>>>
>>> Configure the SPM to set the core (cpu or L2) into its low power mode,
>>> the index of the first command in the sequence is set in the SPM_CTL
>>> register. When the core executes ARM wfi instruction, it triggers the
>>> SPM state machine to start executing from that index. The SPM state
>>> machine waits until the interrupt occurs and starts executing the rest
>>> of the sequence until it hits the end of the sequence. The end of the
>>> sequence jumps the core out of its low power mode.
>>>
>>> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
>>> [lina: simplify the driver for initial submission, clean up and update
>>> commit text]
>>> ---
>>> Documentation/devicetree/bindings/arm/msm/spm.txt |  43 +++
>>> drivers/soc/qcom/Kconfig                          |   8 +
>>> drivers/soc/qcom/Makefile                         |   1 +
>>> drivers/soc/qcom/spm.c                            | 388 ++++++++++++++++++++++
>>> include/soc/qcom/spm.h                            |  38 +++
>>> 5 files changed, 478 insertions(+)
>>> create mode 100644 Documentation/devicetree/bindings/arm/msm/spm.txt
>>> create mode 100644 drivers/soc/qcom/spm.c
>>> create mode 100644 include/soc/qcom/spm.h
>>
>>General comment, lets use qcom instead of msm for various things.
>>
>>[snip]
>>
> OK, Done. I renamed all msm_ functions to qcom_ functions as well.
>

Does that apply to the other parts of this series too?  like the msm-pm
and cpuidle layers?

Kevin
