From: Taniya Das <tdas@codeaurora.org>
Subject: Re: [PATCH v1] cpufreq: qcom: Read voltage LUT and populate OPP
Date: Mon, 7 Jan 2019 13:07:16 +0530
Message-ID: <10e458b8-e17f-0502-5b2a-84ca179656ea@codeaurora.org>
References: <1545415608-15163-1-git-send-email-tdas@codeaurora.org>
 <154542875327.13075.3548703610883534822@swboyd.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <154542875327.13075.3548703610883534822@swboyd.mtv.corp.google.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Boyd <swboyd@chromium.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Rajendra Nayak <rnayak@codeaurora.org>, devicetree@vger.kernel.org, robh@kernel.org, skannan@codeaurora.org, linux-arm-msm@vger.kernel.org, amit.kucheria@linaro.org, Matthias Kaehlcke <mka@chromium.org>, evgreen@google.com
List-Id: linux-pm@vger.kernel.org



On 12/22/2018 3:15 AM, Stephen Boyd wrote:
> Quoting Taniya Das (2018-12-21 10:06:48)
>> Add support to read the voltage look up table and populate OPP for all
>> corresponding CPUS.
> 
> Yes, but why? Please specify the motivations in the commit text.
> 
Sure, would update in the next patch.

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
