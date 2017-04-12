From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V4 0/9] PM / Domains: Implement domain performance states
Date: Wed, 12 Apr 2017 19:54:14 +0530
Message-ID: <20170412142414.GF5910@vireshk-i7>
References: <cover.1490001099.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cover.1490001099.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, ulf.hansson@linaro.org, Kevin Hilman <khilman@kernel.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Nishanth Menon <nm@ti.com>, robh+dt@kernel.org, lina.iyer@linaro.org, rnayak@codeaurora.org
List-Id: linux-pm@vger.kernel.org

On 20-03-17, 15:02, Viresh Kumar wrote:
> Hi,
> 
> The main feedback I got for the V3 series came from Kevin, who suggested
> that we should reuse OPP tables for genpd devices as well, instead of
> creating a new table type. And that's what this version is trying to do.
> 
> Some platforms have the capability to configure the performance state of
> their power domains. The process of configuring the performance state is
> pretty much platform dependent and we may need to work with a wide range
> of configurables.  For some platforms, like Qcom, it can be a positive
> integer value alone, while in other cases it can be voltage levels, etc.
> 
> The power-domain framework until now was only designed for the idle
> state management of the device and this needs to change in order to
> reuse the power-domain framework for active state management of the
> devices.

Hi Ulf/Kevin,

Over 3 weeks since the time this version was posted :(
Can we get some reviews of this stuff and decide on how we are
supposed to proceed on this ?

Its getting delayed a lot unnecessarily. Thanks.

-- 
viresh
