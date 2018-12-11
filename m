From: Taniya Das <tdas@codeaurora.org>
Subject: Re: [PATCH v11 2/2] cpufreq: qcom-hw: Add support for QCOM cpufreq HW
 driver
Date: Tue, 11 Dec 2018 19:05:43 +0530
Message-ID: <82b168d1-79bc-f454-8e19-4f7630a34069@codeaurora.org>
References: <1543722903-10989-1-git-send-email-tdas@codeaurora.org>
 <1543722903-10989-3-git-send-email-tdas@codeaurora.org>
 <20181204051231.mm5ixli7ckpfzvd4@vireshk-i7>
 <154396249199.88331.1800559141437859959@swboyd.mtv.corp.google.com>
 <154396472692.88331.13742924031474269133@swboyd.mtv.corp.google.com>
 <49139ae4-4373-9e70-02ad-80f7bbc4494c@codeaurora.org>
 <20181205061600.7zglbpkgbktn27am@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181205061600.7zglbpkgbktn27am@vireshk-i7>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Stephen Boyd <sboyd@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Rajendra Nayak <rnayak@codeaurora.org>, devicetree@vger.kernel.org, robh@kernel.org, skannan@codeaurora.org, linux-arm-msm@vger.kernel.org, evgreen@google.com
List-Id: linux-pm@vger.kernel.org

Hi Viresh,

Sorry for the delayed response. Thanks for the patch.

On 12/5/2018 11:46 AM, Viresh Kumar wrote:
> On 05-12-18, 09:07, Taniya Das wrote:
>> Hello Stephen, Viresh
>>
>> Thanks for the code and suggestions.
>>
>> Having a NR_DOMAINS '2' makes the driver not scalable for re-use.
> 
> Sure, I didn't like it either and that wasn't really what I was suggesting in
> the first place. I didn't wanted to write the code myself and pass it on, but I
> have it now anyway :)
> 
> It may have a bug or two in there, but compiles just fine and is rebased over
> your patch Taniya.
> 

The design here assumes that there would not be any per-cpu/per-cluster 
based SW requirement for the HW during frequency transitions, which 
again makes me think that we would require to re-introduce these 
structures again in case we have such requirements in near future.

Also I think leaving the structures also helps us debug any boot up 
issues looking at the ram contents of the per-(cpu/cluster) structures 
with the contents from the firmware.

Hope these above helps us to go ahead with the current SW design.

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
