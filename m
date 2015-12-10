From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH V3 0/5] PM / OPP: opp-supported-hw and <prop>-name
 bindings
Date: Thu, 10 Dec 2015 08:58:33 +0000
Message-ID: <20151210085833.GE17876@x1>
References: <cover.1447209519.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:35262 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752103AbbLJI6h (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 10 Dec 2015 03:58:37 -0500
Received: by mail-wm0-f52.google.com with SMTP id u63so14230741wmu.0
        for <linux-pm@vger.kernel.org>; Thu, 10 Dec 2015 00:58:37 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <cover.1447209519.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, robh+dt@kernel.org, sboyd@codeaurora.org, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, mark.rutland@arm.com, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, nm@ti.com, devicetree@vger.kernel.org, b.zolnierkie@samsung.com, m.szyprowski@samsung.com

On Wed, 11 Nov 2015, Viresh Kumar wrote:

> Hi Rafael,
>=20
> Rob only needs to Ack the modified 2/5 patch and then you can safely
> apply this series.
>=20
> The first patch enables us to select only a subset of OPPs from the
> bigger table, based on what version of the hardware we are running on=
=2E
>=20
> The second one enables us to select slightly different values for
> multiple properties, based on what kind of hardware they are running =
on.
>=20
> The third one removes an (unused) binding, which is replaced by the
> second patch with a better solution.
>=20
> The fourth patch is based on what Stephen suggested (and then reviewe=
d)
> in the earlier series, and the 5th one updates the existing users of
> these bindings for it.
>=20
> V2->V3:
> - dropped turbo/suspend named properties
> - Applied all the Acks
>=20
> Viresh Kumar (5):
>   PM / OPP: Add "opp-supported-hw" binding
>   PM / OPP: Add {opp-microvolt|opp-microamp}-<name> binding
>   PM / OPP: Remove 'operating-points-names' binding
>   PM / OPP: Rename OPP nodes as opp@<opp-hz>
>   ARM: dts: exynos4412: Rename OPP nodes as opp@<opp-hz>

Tested-by: Lee Jones <lee.jones@linaro.org>

>  Documentation/devicetree/bindings/opp/opp.txt | 132 ++++++++++++++++=
++--------
>  arch/arm/boot/dts/exynos4412.dtsi             |  28 +++---
>  2 files changed, 107 insertions(+), 53 deletions(-)
>=20

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
