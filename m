From: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH v2 1/4] power: axp20x_usb: Add support for usb
 power-supply on axp22x pmics
Date: Fri, 3 Jun 2016 09:39:24 +0800
Message-ID: <CAGb2v66_UMf-fccSoPoJKJmygLXU8kYOq6RrwDPiq_Q6+kTARg@mail.gmail.com>
References: <1464887936-17020-1-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.csie.ntu.edu.tw ([140.112.30.61]:43126 "EHLO
	smtp.csie.ntu.edu.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750754AbcFCBjw (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 2 Jun 2016 21:39:52 -0400
In-Reply-To: <1464887936-17020-1-git-send-email-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, linux-pm@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, devicetree <devicetree@vger.kernel.org>

On Fri, Jun 3, 2016 at 1:18 AM, Hans de Goede <hdegoede@redhat.com> wrote:
> The usb power-supply on the axp22x pmics is mostly identical to the
> one on the axp20x pmics. One significant difference is that it cannot
> measure / monitor the usb voltage / current.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
