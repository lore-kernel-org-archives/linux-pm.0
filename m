From: Christopher Covington <cov@codeaurora.org>
Subject: Re: [PATCH v2 14/15] cpufreq: Add module to register cpufreq on Krait
 CPUs
Date: Mon, 08 Sep 2014 13:15:46 -0400
Message-ID: <540DE442.6060505@codeaurora.org>
References: <1409957256-23729-1-git-send-email-sboyd@codeaurora.org> <1409957256-23729-16-git-send-email-sboyd@codeaurora.org> <CAKohpokLFMMK-h2657=_BCBr3oXCTiQDA+C-rDgorxfrPR-9YQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <CAKohpokLFMMK-h2657=_BCBr3oXCTiQDA+C-rDgorxfrPR-9YQ@mail.gmail.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>, Mike Turquette <mturquette@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 09/08/2014 12:46 AM, Viresh Kumar wrote:
> On 6 September 2014 04:17, Stephen Boyd <sboyd@codeaurora.org> wrote:
> 
>> diff --git a/drivers/cpufreq/qcom-cpufreq.c b/drivers/cpufreq/qcom-cpufreq.c
>> new file mode 100644
>> index 000000000000..aa8eb97144b6
>> --- /dev/null
>> +++ b/drivers/cpufreq/qcom-cpufreq.c
>> @@ -0,0 +1,199 @@
>> +/* Copyright (c) 2014, The Linux Foundation. All rights reserved.
> 
> Shouldn't this have Qcom instead?

No. The copyright has been transferred.

Christopher

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by the Linux Foundation.
