From: Sricharan R <sricharan@codeaurora.org>
Subject: Re: [PATCH v4 12/12] cpufreq: dt: Reintroduce independent_clocks
 platform data
Date: Mon, 11 Dec 2017 18:54:23 +0530
Message-ID: <30a8a0b5-bd46-9e6f-e534-205a7c00ebe2@codeaurora.org>
References: <1512726150-7204-1-git-send-email-sricharan@codeaurora.org>
 <1512726150-7204-13-git-send-email-sricharan@codeaurora.org>
 <20171211083328.GE25177@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:50670 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752733AbdLKNYa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Dec 2017 08:24:30 -0500
In-Reply-To: <20171211083328.GE25177@vireshk-i7>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: mturquette@baylibre.com, sboyd@codeaurora.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Viresh,

On 12/11/2017 2:03 PM, Viresh Kumar wrote:
> On 08-12-17, 15:12, Sricharan R wrote:
>> The Platform data was removed earlier by,
>> 'commit eb96924acddc ("cpufreq: dt: Kill platform-data")'
>> since there were no users at that time.
>> Now this is required when the each of the cpu clocks
>> can be scaled independently, which is the case
>> for krait cores. So reintroduce it.
>>
>> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
>> ---
>>  drivers/cpufreq/cpufreq-dt.c | 7 ++++++-
>>  drivers/cpufreq/cpufreq-dt.h | 6 ++++++
>>  2 files changed, 12 insertions(+), 1 deletion(-)
> 
> Nack. This information should come from the OPP layer (Hint:
> dev_pm_opp_of_get_sharing_cpus()).
> 

Thanks. Understand. As replied on the other patch, after using
dev_pm_opp_set_prop_name and opp-v2 bindings, this patch is no more
required.

Regards,
 Sricharan
-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation

---
This email has been checked for viruses by Avast antivirus software.
https://www.avast.com/antivirus
