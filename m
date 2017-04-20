From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH V4 1/9] PM / OPP: Allow OPP table to be used for
 power-domains
Date: Thu, 20 Apr 2017 10:43:36 +0100
Message-ID: <34c7fb69-0324-ad06-678d-8726064e9a18@arm.com>
References: <cover.1490001099.git.viresh.kumar@linaro.org>
 <e772e67a5445319bb8e0f312846ace666adc097f.1490001099.git.viresh.kumar@linaro.org>
 <0a7146f9-72f1-317c-3aab-770a72462968@arm.com>
 <20170413053736.GM5910@vireshk-i7>
 <3adbef6a-7b43-528f-e88f-c2121d30a5d3@arm.com>
 <20170417052758.GF28191@vireshk-i7>
 <95aa4b97-4e1a-13bb-f4d8-982b778012ba@arm.com>
 <20170419114740.GD5436@vireshk-i7>
 <9dee7c0d-e5f4-9fcd-3c92-bf7ec9d43a3b@arm.com>
 <20170420052533.GF5436@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:51738 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S944113AbdDTJno (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 20 Apr 2017 05:43:44 -0400
In-Reply-To: <20170420052533.GF5436@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Rafael Wysocki <rjw@rjwysocki.net>, ulf.hansson@linaro.org, Kevin Hilman <khilman@linaro.org>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, robh+dt@kernel.org, lina.iyer@linaro.org, rnayak@codeaurora.org, devicetree@vger.kernel.org



On 20/04/17 06:25, Viresh Kumar wrote:
> On 19-04-17, 14:58, Sudeep Holla wrote:
>> On 19/04/17 12:47, Viresh Kumar wrote:
>>> On 18-04-17, 17:01, Sudeep Holla wrote:

[...]

>> 
>> Yes, I completely agree. I am not saying the direction is wrong. I
>> am saying it's confusing and binding needs to be more clear.
> 
> What exactly isn't clear? (Yeah, there had been lots of emails and I 
> want to know what improvements are you looking for).
> 

Just that the term performance is closely related to frequency, it needs
to be explicit on what *exactly* it means. As it stands now,
it can be used for OPP as I explain which controls both but as you
clarify that's not what it's designed for.

>> On the contrary(playing devil's advocate here), we can treat all 
>> existing regulators alone as OPP then if you strip the voltages
>> and treat it as abstract number.
> 
> But then we are going to have lots of platform specific code which 
> will program the actual hardware, etc. Which is all handled by the 
> regulator framework. Also note that the regulator core selects the 
> common voltage selected by all the children, while we want to select 
> the highest performance point here.
> 

I am not sure if choosing highest performance point makes it difficult
to fit it in regulator framework. It could be some configuration.
Also IIUC the actual programming is done in the firmware in this case
and I fail to see how that adds lot of platform code.

> Even if we have to configure both clock and voltage for the power 
> domain using standard clk/regulator frameworks, OPP will work just 
> fine as it will do that then. So, its not that we are bypassing the 
> regulator framework here. It will be used if we have the voltages 
> available for the power-domain's performance states.
> 

Yes I understand that.

-- 
Regards,
Sudeep
