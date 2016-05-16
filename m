From: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH 2/3] mfd: axp20x: Extend axp22x_volatile_ranges
Date: Mon, 16 May 2016 19:13:17 +0800
Message-ID: <CAGb2v65nuj4Uh9jNSS4wk8CWkgN6iiuGR2vz4Kat=8QT68EE6Q@mail.gmail.com>
References: <1463248289-16456-1-git-send-email-hdegoede@redhat.com> <1463248289-16456-2-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.csie.ntu.edu.tw ([140.112.30.61]:55196 "EHLO
	smtp.csie.ntu.edu.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750787AbcEPLNm (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 16 May 2016 07:13:42 -0400
In-Reply-To: <1463248289-16456-2-git-send-email-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, linux-pm@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, devicetree <devicetree@vger.kernel.org>, linux-sunxi <linux-sunxi@googlegroups.com>

On Sun, May 15, 2016 at 1:51 AM, Hans de Goede <hdegoede@redhat.com> wrote:
> The axp22x pmic has a bunch of volatile registers besides the interrupt
> ones, extend axp22x_volatile_ranges with these.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
