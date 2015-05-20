From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH V4 1/3] OPP: Redefine bindings to overcome shortcomings
Date: Wed, 20 May 2015 12:39:18 -0700
Message-ID: <555CE2E6.80304@codeaurora.org>
References: <cover.1430394884.git.viresh.kumar@linaro.org> <d225e73f183e01fa0b71e4b9248b6a19a3f7d697.1430394884.git.viresh.kumar@linaro.org> <555BDA7C.7020506@codeaurora.org> <20150520020715.GA6465@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:42240 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752896AbbETTjV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 20 May 2015 15:39:21 -0400
In-Reply-To: <20150520020715.GA6465@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, rob.herring@linaro.org, arnd.bergmann@linaro.org, nm@ti.com, broonie@kernel.org, mike.turquette@linaro.org, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, grant.likely@linaro.org, olof@lixom.net, Sudeep.Holla@arm.com, devicetree@vger.kernel.org, viswanath.puttagunta@linaro.org, l.stach@pengutronix.de, thomas.petazzoni@free-electrons.com, linux-arm-kernel@lists.infradead.org, ta.omasab@gmail.com, kesavan.abhilash@gmail.com, khilman@linaro.org, santosh.shilimkar@oracle.com

On 05/19/15 19:07, Viresh Kumar wrote:
> On 19-05-15, 17:51, Stephen Boyd wrote:
>
>> Also I wonder if all properties should be optional? I don't have this
>> scenario today, but perhaps the frequencies could be encoded in fuses,
>> but the voltages wouldn't be and so we might want to read out the
>> frequencies for a fixed set of voltages. Of course, if there's nothing
>> in the OPP node at all, it's not very useful, so perhaps some statement
>> that at least one of the frequency/voltage/amperage properties should be
>> present.
> I am not sure. What we are trying to do (fill partially in DT and
> partially in platform), is a trick and not the right use of bindings.
>
> Ideally whatever is passed in DT should be complete by itself and
> doesn't require platform to tweak it (which it can't). For example,
> the cpufreq-dt driver will try to initialize OPPs from the DT directly
> and wouldn't know about the platform tweaks. That can work eventually
> as platform will add OPPs for the same bindings before cpufreq driver
> will try to do, but that's a trick.
>
> And then its all about frequency in the first place, and so marking
> that optional looks wrong. Probably not the right use of these
> bindings.

Ok then I won't be using these bindings on any of the new platforms I
have where half the data is in one place, and half in another. But for
some of Krait based platforms I have they should be useable.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

