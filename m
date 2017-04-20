From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V4 1/9] PM / OPP: Allow OPP table to be used for
 power-domains
Date: Thu, 20 Apr 2017 15:22:48 +0530
Message-ID: <20170420095248.GJ5436@vireshk-i7>
References: <e772e67a5445319bb8e0f312846ace666adc097f.1490001099.git.viresh.kumar@linaro.org>
 <0a7146f9-72f1-317c-3aab-770a72462968@arm.com>
 <20170413053736.GM5910@vireshk-i7>
 <3adbef6a-7b43-528f-e88f-c2121d30a5d3@arm.com>
 <20170417052758.GF28191@vireshk-i7>
 <95aa4b97-4e1a-13bb-f4d8-982b778012ba@arm.com>
 <20170419114740.GD5436@vireshk-i7>
 <9dee7c0d-e5f4-9fcd-3c92-bf7ec9d43a3b@arm.com>
 <20170420052533.GF5436@vireshk-i7>
 <34c7fb69-0324-ad06-678d-8726064e9a18@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <34c7fb69-0324-ad06-678d-8726064e9a18@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, ulf.hansson@linaro.org, Kevin Hilman <khilman@linaro.org>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, robh+dt@kernel.org, lina.iyer@linaro.org, rnayak@codeaurora.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 20-04-17, 10:43, Sudeep Holla wrote:
> Just that the term performance is closely related to frequency, it needs
> to be explicit on what *exactly* it means. As it stands now,
> it can be used for OPP as I explain which controls both but as you
> clarify that's not what it's designed for.

We are talking about active states of a power domain here and
*performance* is the best word I got. And yes we can still have
frequency as a configurable here, just that current platforms don't
have it.

> I am not sure if choosing highest performance point makes it difficult
> to fit it in regulator framework. It could be some configuration.

I was just pointing out a difference :)

> Also IIUC the actual programming is done in the firmware in this case
> and I fail to see how that adds lot of platform code.

Oh I meant that for converting general regulator only cases to OPP. No
firmware was involved there.

-- 
viresh
