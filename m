From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V2 0/5] PM / OPP: opp-supported-hw and <prop>-name bindings
Date: Thu, 05 Nov 2015 23:31:16 +0100
Message-ID: <3673640.WbFJib59uF@vostro.rjw.lan>
References: <cover.1446687367.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:63919 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755475AbbKEWCG (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 5 Nov 2015 17:02:06 -0500
In-Reply-To: <cover.1446687367.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: robh+dt@kernel.org, sboyd@codeaurora.org, lee.jones@linaro.org, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, mark.rutland@arm.com, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, nm@ti.com, devicetree@vger.kernel.org, b.zolnierkie@samsung.com, m.szyprowski@samsung.com

On Thursday, November 05, 2015 07:11:51 AM Viresh Kumar wrote:
> Hi Rafael,
> 
> All the bindings are Reviewed by Stephen now and Rob didn't had a
> problem with them (though he didn't Ack them separately yet) :)
> 
> The first patch enables us to select only a subset of OPPs from the
> bigger table, based on what version of the hardware we are running on.
> 
> The second one enables us to select slightly different values for
> multiple properties, based on what kind of hardware they are running on.
> 
> The third one removes an (unused) binding, which is replaced by the
> second patch with a better solution.
> 
> The fourth patch is based on what Stephen suggested (and then reviewed)
> in the earlier series, and the 5th one updates the existing users of
> these bindings for it.
> 
> Viresh Kumar (5):
>   PM / OPP: Add "opp-supported-hw" binding
>   PM / OPP: Add
>     {opp-microvolt|opp-microamp|turbo-mode|opp-suspend}-<name> binding
>   PM / OPP: Remove 'operating-points-names' binding
>   PM / OPP: Rename OPP nodes as opp@<opp-hz>
>   ARM: dts: exynos4412: Rename OPP nodes as opp@<opp-hz>
> 
>  Documentation/devicetree/bindings/opp/opp.txt | 143 +++++++++++++++++++-------
>  arch/arm/boot/dts/exynos4412.dtsi             |  28 ++---
>  2 files changed, 118 insertions(+), 53 deletions(-)

So this clearly is a new feature and it clearly missed the merge window boundary
for v4.4.  I can queue it up for v4.5.

Thanks,
Rafael

