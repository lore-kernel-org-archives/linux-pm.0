From: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [RFC PATCH v2 1/2] interconnect: qcom: Add sdm845 interconnect
 provider driver
Date: Mon, 6 Aug 2018 15:52:52 -0700
Message-ID: <20180806225252.GQ30024@minitux>
References: <1531967820-27483-1-git-send-email-daidavid1@codeaurora.org>
 <1531967820-27483-2-git-send-email-daidavid1@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1531967820-27483-2-git-send-email-daidavid1@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: David Dai <daidavid1@codeaurora.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, georgi.djakov@linaro.org, vincent.guittot@linaro.org, amit.kucheria@linaro.org, ilina@codeaurora.org, seansw@qti.qualcomm.com, grahamr@qti.qualcomm.com
List-Id: linux-pm@vger.kernel.org

On Wed 18 Jul 19:36 PDT 2018, David Dai wrote:
> diff --git a/drivers/interconnect/qcom/sdm845.c b/drivers/interconnect/qcom/sdm845.c
[..]
> +DEFINE_QNODE(ipa_core_master, MASTER_IPA_CORE, 1, 8, 1, SLAVE_IPA_CORE);
[..]
> +DEFINE_QNODE(ipa_core_slave, SLAVE_IPA_CORE, 1, 8, 0);

As discussed before; while the two sides of IPA_CORE are controlled
through the "bus mechanism", they do represent the clock of the IPA
block.

I think it would make sense to make this interconnect provider also
register a clock provider and expose this as a clock, for the IPA driver
to consume.

Regards,
Bjorn
