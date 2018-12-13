From: Taniya Das <tdas@codeaurora.org>
Subject: Re: [PATCH v11 2/2] cpufreq: qcom-hw: Add support for QCOM cpufreq HW
 driver
Date: Thu, 13 Dec 2018 13:18:39 +0530
Message-ID: <72a7312a-5529-92df-63e9-c3e6905103c2@codeaurora.org>
References: <1543722903-10989-1-git-send-email-tdas@codeaurora.org>
 <1543722903-10989-3-git-send-email-tdas@codeaurora.org>
 <20181204051231.mm5ixli7ckpfzvd4@vireshk-i7>
 <154396249199.88331.1800559141437859959@swboyd.mtv.corp.google.com>
 <154396472692.88331.13742924031474269133@swboyd.mtv.corp.google.com>
 <49139ae4-4373-9e70-02ad-80f7bbc4494c@codeaurora.org>
 <20181205061600.7zglbpkgbktn27am@vireshk-i7>
 <82b168d1-79bc-f454-8e19-4f7630a34069@codeaurora.org>
 <20181212044702.jp2r3mviq4ffal42@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181212044702.jp2r3mviq4ffal42@vireshk-i7>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Stephen Boyd <sboyd@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Rajendra Nayak <rnayak@codeaurora.org>, devicetree@vger.kernel.org, robh@kernel.org, skannan@codeaurora.org, linux-arm-msm@vger.kernel.org, evgreen@google.com
List-Id: linux-pm@vger.kernel.org

Hello Viresh,

On 12/12/2018 10:17 AM, Viresh Kumar wrote:
> On 11-12-18, 19:05, Taniya Das wrote:
>> The design here assumes that there would not be any per-cpu/per-cluster
>> based SW requirement for the HW during frequency transitions, which again
>> makes me think that we would require to re-introduce these structures again
>> in case we have such requirements in near future.
> 
> Firstly, even in such cases we can go ahead with the design we proposed. And I
> am not at all concerned about some hardware which we don't have right now. We
> will see what to do when such hardware comes, maybe reintroduce the structures,
> but that doesn't matter right now.
> 
>> Also I think leaving the structures also helps us debug any boot up issues
>> looking at the ram contents of the per-(cpu/cluster) structures with the
>> contents from the firmware.
> 
> I don't see how debugging would be hard without those structures in place.
> 
>> Hope these above helps us to go ahead with the current SW design.
> 
> Sorry, but I don't see any satisfactory reason on why you shouldn't make the
> suggested changes. We are trying to make your (and any other developer who will
> work on that driver) life simple by simplifying the code. Nothing beyond that :)
> 

Sure, Thanks, will submit the next patch series for your ACK :).

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
