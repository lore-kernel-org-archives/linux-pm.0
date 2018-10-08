From: Taniya Das <tdas@codeaurora.org>
Subject: Re: [PATCH v8 2/2] cpufreq: qcom-hw: Add support for QCOM cpufreq HW
 driver
Date: Mon, 8 Oct 2018 16:29:10 +0530
Message-ID: <52643019-07d9-0055-ecd3-24c1a7863481@codeaurora.org>
References: <1537698793-15285-1-git-send-email-tdas@codeaurora.org>
 <1537698793-15285-3-git-send-email-tdas@codeaurora.org>
 <20181008084012.GA23693@centauri.lan>
 <20181008095952.gl7di2tnuv3jwew6@vireshk-i7>
 <20181008103856.GA10890@centauri.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181008103856.GA10890@centauri.lan>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Niklas Cassel <niklas.cassel@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>, Rajendra Nayak <rnayak@codeaurora.org>, devicetree@vger.kernel.org, robh@kernel.org, skannan@codeaurora.org, linux-arm-msm@vger.kernel.org, amit.kucheria@linaro.org, evgreen@google.com
List-Id: linux-pm@vger.kernel.org



On 10/8/2018 4:08 PM, Niklas Cassel wrote:
> On Mon, Oct 08, 2018 at 03:29:52PM +0530, Viresh Kumar wrote:
>> On 08-10-18, 10:40, Niklas Cassel wrote:
>>>> +		ret = of_parse_phandle_with_args(cpu_np, "qcom,freq-domain",
>>>> +				"#freq-domain-cells", 0, &args);
>>>
>>> Hello Taniya,
>>>
>>> in your DT binding, you use
>>>
>>> #freq-domains-cells = <1>
>>>
>>> Yet here you parse for "#freq-domain-cells".
>>
>> And what is the problem with that ? Or are you suggesting her to call
>> of_parse_phandle_with_fixed_args() ?
> 
> Hello Viresh,
> 
> #freq-domain-cells != #freq-domains-cells
> 
> The code should parse for the exact same property name as stated in the
> DT binding.
> 
> Kind regards,
> Niklas
> 

The extra 's' was a typo, would fix it in the next patch.

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
