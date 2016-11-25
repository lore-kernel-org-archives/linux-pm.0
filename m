From: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH 04/10] power: supply: axp20x_usb_power: add 100mA max
 current limit for AXP223
Date: Fri, 25 Nov 2016 17:56:56 +0800
Message-ID: <CAGb2v66WZCR3afRk6e03gs4RqUPbV4ixb_6=T3=qSMWgcscX3w@mail.gmail.com>
References: <20161125090921.23138-1-quentin.schulz@free-electrons.com> <20161125090921.23138-5-quentin.schulz@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.csie.ntu.edu.tw ([140.112.30.61]:41294 "EHLO
        smtp.csie.ntu.edu.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753347AbcKYJ5V (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 25 Nov 2016 04:57:21 -0500
In-Reply-To: <20161125090921.23138-5-quentin.schulz@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Chen-Yu Tsai <wens@csie.org>, Russell King <linux@armlinux.org.uk>, Maxime Ripard <maxime.ripard@free-electrons.com>, Lee Jones <lee.jones@linaro.org>, "open list:THERMAL" <linux-pm@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

On Fri, Nov 25, 2016 at 5:09 PM, Quentin Schulz
<quentin.schulz@free-electrons.com> wrote:
> The X-Powers AXP223 shares most of its behaviour with the AXP221 PMIC
> but allows the VBUS power supply max current to be set to 100mA (like
> the AXP209 PMIC).
>
> This basically adds a new compatible to the VBUS power supply driver and
> adds a check on the compatible when setting current max limit.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
