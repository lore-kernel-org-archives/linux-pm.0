From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 1/4] power: axp20x_usb: Add support for usb
 power-supply on axp22x pmics
Date: Mon, 6 Jun 2016 08:26:38 -0500
Message-ID: <20160606132638.GA17368@rob-hp-laptop>
References: <1464887936-17020-1-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f47.google.com ([209.85.218.47]:36751 "EHLO
	mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750764AbcFFN0k (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 6 Jun 2016 09:26:40 -0400
Content-Disposition: inline
In-Reply-To: <1464887936-17020-1-git-send-email-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree <devicetree@vger.kernel.org>

On Thu, Jun 02, 2016 at 07:18:53PM +0200, Hans de Goede wrote:
> The usb power-supply on the axp22x pmics is mostly identical to the
> one on the axp20x pmics. One significant difference is that it cannot
> measure / monitor the usb voltage / current.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2:
> -Use compatible instead of axp20x->variant to detect pmic type
> ---
>  .../bindings/power_supply/axp20x_usb_power.txt     |  3 +-

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/power/axp20x_usb_power.c                   | 92 ++++++++++++++++------
>  2 files changed, 71 insertions(+), 24 deletions(-)
