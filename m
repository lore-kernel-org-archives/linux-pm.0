From: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH v2 13/16] power: supply: axp288_fuel_gauge: Rework get_status()
Date: Wed, 27 Dec 2017 11:15:00 +0800
Message-ID: <CAGb2v66=N1Xn4EWQCHw7M08jCZ95u_qdTekp-Oo+vrBSqLrJcw@mail.gmail.com>
References: <20171226125914.10235-1-hdegoede@redhat.com> <20171226125914.10235-13-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.csie.ntu.edu.tw ([140.112.30.61]:39620 "EHLO
        smtp.csie.ntu.edu.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751225AbdL0DP0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Dec 2017 22:15:26 -0500
Received: from mail-wm0-f45.google.com (mail-wm0-f45.google.com [74.125.82.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: b93043)
        by smtp.csie.ntu.edu.tw (Postfix) with ESMTPSA id 36B8F27BE5
        for <linux-pm@vger.kernel.org>; Wed, 27 Dec 2017 11:15:24 +0800 (CST)
Received: by mail-wm0-f45.google.com with SMTP id 64so37243251wme.3
        for <linux-pm@vger.kernel.org>; Tue, 26 Dec 2017 19:15:24 -0800 (PST)
In-Reply-To: <20171226125914.10235-13-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Sebastian Reichel <sre@kernel.org>, Chen-Yu Tsai <wens@csie.org>, "open list:THERMAL" <linux-pm@vger.kernel.org>

On Tue, Dec 26, 2017 at 8:59 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> Relying on the (dis)charge current reporting for reporting FULL back to
> userspace does not work really well and often leads to the reported status
> getting stuck at e.g. 98/99% (the fuelgauge is not perfect) for hours.
>
> What happens is that when the battery is full the axp288 keeps charging it
> with a very low current. Until it is really really full and once really
> really full, some inaccuracies in the adc lead to it then sometimes
> reporting a small discharging rate, even though an external pwr source is
> used. So we end up with a status of "charging" for hours after the battery
> is actually already full and sometimes this then flip-flops to discharging.
>
> This commit fixes this by first checking if a valid Vbus is present and if
> it is present using the fuel-gauge's reported percentage to check for a
> full battery.
>
> This commit also changes how get_status() determines if the battery is
> charging or discharging when not reporting it as full. We still use the
> current direction for this, but instead of reading 4 extra registers for
> this (2 16 bit regs), simplify things by using the current-direction bit
> in the power-status register, which already gets read anyways.
>
> This also reduces the amount of i2c reads to 1 when on battery and 2
> when a valid Vbus is present.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

This looks better. Thanks.

Reviewed-by: Chen-Yu Tsai <wens@csie.org>

I do have one minor question though: What should the status be if there
was no battery connected? Or is that not an issue?

ChenYu
