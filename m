From: Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [PATCH v3 3/8] PM / Domains: Allow domain power states to be
 read from DT
Date: Mon, 24 Oct 2016 10:48:46 -0600
Message-ID: <20161024164846.GE72940@linaro.org>
References: <1476467276-75094-1-git-send-email-lina.iyer@linaro.org>
 <1476467276-75094-4-git-send-email-lina.iyer@linaro.org>
 <6ed96121-5040-474d-2d71-7927e8567c50@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6ed96121-5040-474d-2d71-7927e8567c50@arm.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: ulf.hansson@linaro.org, khilman@kernel.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, andy.gross@linaro.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, brendan.jackman@arm.com, lorenzo.pieralisi@arm.com, Juri.Lelli@arm.com, Marc Titinger <mtitinger+renesas@baylibre.com>
List-Id: linux-pm@vger.kernel.org

Hi Sudeep,

On Mon, Oct 24 2016 at 07:39 -0600, Sudeep Holla wrote:
>
>
>On 14/10/16 18:47, Lina Iyer wrote:
>>This patch allows domains to define idle states in the DT. SoC's can
>>define domain idle states in DT using the "domain-idle-states" property
>>of the domain provider. Add API to read the idle states from DT that can
>>be set in the genpd object.
>>
>>This patch is based on the original patch by Marc Titinger.
>>
>>Signed-off-by: Marc Titinger <mtitinger+renesas@baylibre.com>
>>Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>>Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
>>---
>> drivers/base/power/domain.c | 94 +++++++++++++++++++++++++++++++++++++++++++++
>> include/linux/pm_domain.h   |  8 ++++
>> 2 files changed, 102 insertions(+)
>>
>>diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
>>index 37ab7f1..9af75ba 100644
>>--- a/drivers/base/power/domain.c
>>+++ b/drivers/base/power/domain.c
>>@@ -1916,6 +1916,100 @@ out:
>> 	return ret ? -EPROBE_DEFER : 0;
>> }
>> EXPORT_SYMBOL_GPL(genpd_dev_pm_attach);
>>+
>>+static const struct of_device_id idle_state_match[] = {
>>+	{ .compatible = "arm,idle-state", },
>>+	{ }
>>+};
>>+
>
>I still think it's better to have another compatible to serve this
>purpose. We don't want to end up creating genpd domains just because
>they are "arm,idle-state" compatible IMO ?
>
>I agree you can prevent it checking for OSC mode support in the
>firmware. But I want to understand if you have any strong reasons for
>avoiding that approach.
>
Why are you still held up with OSI/PC PSCI modes? I repeat again this
series is not about any of that, it is just about PM domains. PM domains
have idle states and the idle-state description is similar in definition
to arm,idle-state and therefore uses the same compatible. There is no
point re-defining something that already exists in the kernel.

I was able to find the original thread, where we discussed this [1].

I suggest, you read about PM domains and its idle states and understand
this series in the context of PM domains.

Thanks,
Lina

[1]. http://www.serverphorums.com/read.php?12,1303996
