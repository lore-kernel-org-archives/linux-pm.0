From: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH 08/10] ARM: dts: sun8i-a33-sinlinx-sina33: use AXP223 DTSI
Date: Fri, 25 Nov 2016 18:05:22 +0800
Message-ID: <CAGb2v64cStm1R9Y_dwSp+1tFq7Q=L4Vda75LhzQEHzoS7MWqEg@mail.gmail.com>
References: <20161125090921.23138-1-quentin.schulz@free-electrons.com> <20161125090921.23138-9-quentin.schulz@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.csie.ntu.edu.tw ([140.112.30.61]:41380 "EHLO
        smtp.csie.ntu.edu.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753016AbcKYKGj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 25 Nov 2016 05:06:39 -0500
In-Reply-To: <20161125090921.23138-9-quentin.schulz@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Chen-Yu Tsai <wens@csie.org>, Russell King <linux@armlinux.org.uk>, Maxime Ripard <maxime.ripard@free-electrons.com>, Lee Jones <lee.jones@linaro.org>, "open list:THERMAL" <linux-pm@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

On Fri, Nov 25, 2016 at 5:09 PM, Quentin Schulz
<quentin.schulz@free-electrons.com> wrote:
> Previously, the Sinlinx SinA33 used everything declared in AXP221 DTSI
> while it has an AXP223 PMIC.
>
> This corrects that so the Sinlinx SinA33 can get some features the
> AXP223 has (at the moment, ability to have 100mA as maximal current on
> VBUS power supply).
>
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
