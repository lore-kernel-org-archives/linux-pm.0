From: Sricharan R <sricharan@codeaurora.org>
Subject: Re: [PATCH V12 00/14] Krait clocks + Krait CPUfreq
Date: Wed, 24 Oct 2018 09:41:26 +0530
Message-ID: <a9fed22d-89c2-9d3d-f6bb-594dac0e3ec5@codeaurora.org>
References: <1534248753-2440-1-git-send-email-sricharan@codeaurora.org>
 <2ae96741-94c0-ba4c-fc19-05d33179683c@codeaurora.org>
 <d682580d-5070-0271-197f-29d988172937@codeaurora.org>
 <D8FC68C0-2572-4A86-81D9-D0099D314A45@gmail.com>
 <F5A89365-C613-4FE2-AD32-DC0AC6DF380B@gmail.com>
 <fb81b8d5-3d24-b413-8d59-33cb70e46f8b@codeaurora.org>
 <153979105280.5275.841088095583550635@swboyd.mtv.corp.google.com>
 <153980741313.5275.10376918222904341760@swboyd.mtv.corp.google.com>
 <c5f492c0-19a2-db8f-a114-d3cfe17ae6c6@codeaurora.org>
 <20181022153005.GA23950@centauri.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181022153005.GA23950@centauri.lan>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Niklas Cassel <niklas.cassel@linaro.org>
Cc: Stephen Boyd <sboyd@kernel.org>, Craig <ctatlor97@gmail.com>, andy.gross@linaro.org, david.brown@linaro.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-soc@vger.kernel.org, linux@arm.linux.org.uk, linux@armlinux.org.uk, mark.rutland@arm.com, mturquette@baylibre.com, rjw@rjwysocki.net, robh@kernel.org, sboyd@codeaurora.org, sudeep.holla@arm.com, thierry.escande@linaro.org, viresh.kumar@linaro.org
List-Id: linux-pm@vger.kernel.org

Hi Niklas,

On 10/22/2018 9:00 PM, Niklas Cassel wrote:
> On Mon, Oct 22, 2018 at 09:39:03AM +0530, Sricharan R wrote:
>> Hi Stephen,
>>
>> On 10/18/2018 1:46 AM, Stephen Boyd wrote:
>>> Quoting Stephen Boyd (2018-10-17 08:44:12)
>>>> Quoting Sricharan R (2018-09-20 06:03:31)
>>>>>
>>>>>
>>>>> On 9/20/2018 1:54 AM, Craig wrote:
>>>>>> Yup, this patch seems to have fixed the higher frequencies from the quick test I did.
>>>>>>
>>>>>       Thanks !!. Can i take that as 
>>>>>           Tested-by: Craig Tatlor <ctatlor97@gmail.com>  ?
>>>>>
>>>>
>>>> Is this patch series going to be resent?
>>>>
>>>
>>> Nevermind. Looking at it I think I can apply all the clk ones and we're
>>> good to go. If you can send a followup patch series to change the
>>> registration and provider APIs to be clk_hw instead of clk based I would
>>> appreciate it.
>>>
>>
>> Sorry for the late response. Was away.
>> Only pending thing was separating out the binding documentation for the cpu-freq
>> driver and fixing the text in documentation.  That means, yes its fine to merge
>> the clk ones as you said. I will resend that. Also, will send a follow up series for clk_hw to
>> clk change as you mentioned separately.
> 
> Hello Sricharan,
> 
> Great to see that the clk parts has been marged to clk-next!
> 
> Are you also planning on sending out a new version of the cpufreq driver
> consolidation parts?
> 
   yeah right, will send a new version, sometime next week.

> I'm planning on extending your consilidated cpufreq driver with support
> for msm8916 (Cortex-A53), where I plan to read PVS/speedbin, in order to
> set opp_supported_hw(), and also register with cpufreq (since Viresh/Ulf
> suggested that we shouldn't register with cpufreq in the CPR power-domain
> driver).

   ok sure.

Regards,
 Sricharan

-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
