From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/6] ARM: Tegra: Add CPU's OPPs for using cpufreq-cpu0 driver
Date: Thu, 8 Aug 2013 19:41:13 +0530
Message-ID: <CAKohpon=GGn5-8ucTrrf6TyPMn3+1Oh6Sd5bAj_ztpVDONZ3QA@mail.gmail.com>
References: <cover.1375886595.git.viresh.kumar@linaro.org>
	<d4cd498d9b63d761039b025216e65278dc8e0e37.1375886595.git.viresh.kumar@linaro.org>
	<52028719.8070908@wwwdotorg.org>
	<CAKohpo=MpOyMGFTGeZWmoCRwmZ7+nQtP_yCGokPanEVYL0xbMw@mail.gmail.com>
	<52029811.9080704@wwwdotorg.org>
	<1375970318.4276.52.camel@weser.hi.pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1375970318.4276.52.camel@weser.hi.pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Mark Rutland <Mark.Rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, linaro-kernel@lists.linaro.org, swarren@nvidia.com, Ian Campbell <ian.campbell@citrix.com>, Pawel Moll <pawel.moll@arm.com>, linux-pm@vger.kernel.org, patches@linaro.org, linux-kernel@vger.kernel.org, cpufreq@vger.kernel.org, rjw@sisk.pl, Rob Herring <rob.herring@calxeda.com>, mturquette@linaro.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On 8 August 2013 19:28, Lucas Stach <l.stach@pengutronix.de> wrote:
> From what I learned those voltage levels are dependent on both the
> Speedo and the process ID of the specific Tegra processor. So you really
> get a two dimensional mapping table instead of a single OPP.
> Also you can not scale the CPU voltage on it's own, but have to make
> sure the core voltage isn't too far away from. Then core voltage also
> depends on the operating states of engines like GR2D or even display.

So if they depend on a certain type of SoC, which they should, then we
can get these initialized from that SoC's dts/dtsi file instead of a common
file.. And so that would resolve the issue you just reported.

Now I haven't proposed in the patch that we will change these voltage
levels at all.. This is regulator specific code and would come into play
only when regulators are registered for cpu.. Otherwise we will just
play with frequency..

Passing OPP instead of just list of frequencies is the generic way this
is done now a days..
