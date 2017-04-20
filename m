From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH V4 1/9] PM / OPP: Allow OPP table to be used for
 power-domains
Date: Thu, 20 Apr 2017 10:51:27 +0100
Message-ID: <af22ce1e-cd71-6b5e-8fd6-98e73438da9f@arm.com>
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
 <CAPDyKFq5xwv5Vy6wNfjFYi_4+immDH9UKTS1EG2j6c4OwnQONg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:51864 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S944119AbdDTJvd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 20 Apr 2017 05:51:33 -0400
In-Reply-To: <CAPDyKFq5xwv5Vy6wNfjFYi_4+immDH9UKTS1EG2j6c4OwnQONg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Rafael Wysocki <rjw@rjwysocki.net>, Kevin Hilman <khilman@linaro.org>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Rob Herring <robh+dt@kernel.org>, Lina Iyer <lina.iyer@linaro.org>, Rajendra Nayak <rnayak@codeaurora.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>



On 20/04/17 09:23, Ulf Hansson wrote:
> Viresh, Sudeep,
> 
> Sorry for jumping in late.
> 
> [...]
> 
>>> On the contrary(playing devil's advocate here), we can treat all
>>> existing regulators alone as OPP then if you strip the voltages and
>>> treat it as abstract number.
>>
>> But then we are going to have lots of platform specific code which
>> will program the actual hardware, etc. Which is all handled by the
>> regulator framework. Also note that the regulator core selects the
>> common voltage selected by all the children, while we want to select
>> the highest performance point here.
> 
> If I understand correctly, Sudeep is not convinced that this is about
> PM domain regulator(s), right?
> 

No, I am saying that it has to be modeled as regulators or some kind of
advanced regulators. I am against modeling it as some new feature and
using similar terminology that are quite close to OPP/CPPC in which case
it's quite hard not to misunderstand the concepts and eventually use
these bindings incorrectly.

> To me there is no doubt, these regulators is exactly the definition of
> PM domain regulators.
> 

+1

> That said, long time ago we have decided PM domain regulator shall be
> modeled as exactly that. From DT point of view, this means the handle
> to the PM domain regulator belongs in the node of the PM domain
> controller - and not in each device's node of those belonging to the
> PM domain.
> 
> Isn't that what this discussion really boils down to? Or maybe I am
> not getting it.
> 

I completely agree with you on all the above points. I am against the
performance state terminology. Since the regulators and OPP are already
defined in the bindings, all we need to explicitly state(if not already)
is that there are hierarchical.

-- 
Regards,
Sudeep
