From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 08/15] ARM: ux500: cpuidle: use init/exit common routine
Date: Wed, 27 Mar 2013 15:47:06 +0100
Message-ID: <CACRpkdYCpS2WwfrS8yFXE=NWuBVJDk+sS6zCVTPD8uySit+PQQ@mail.gmail.com>
References: <1364234140-514-1-git-send-email-daniel.lezcano@linaro.org>
	<1364234140-514-9-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:60084 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753159Ab3C0OrH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 27 Mar 2013 10:47:07 -0400
Received: by mail-ie0-f173.google.com with SMTP id 9so10399495iec.18
        for <linux-pm@vger.kernel.org>; Wed, 27 Mar 2013 07:47:06 -0700 (PDT)
In-Reply-To: <1364234140-514-9-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rjw@sisk.pl, tglx@linutronix.de, patches@linaro.org, linaro-kernel@lists.linaro.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux@maxim.org.za, nicolas.ferre@atmel.com, plagnioj@jcrosoft.com, lenb@kernel.org, nsekhar@ti.com, kevin.hilman@linaro.org, horms@verge.net.au, magnus.damm@gmail.com, kernel@pengutronix.de, ben-linux@fluff.org, kgene.kim@samsung.com, rob.herring@calxeda.com, jason@lakedaemon.net, andrew@lunn.ch, linux@arm.linux.org.uk

On Mon, Mar 25, 2013 at 6:55 PM, Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:

> Remove the duplicate code and use the arm cpuidle driver's common code
> for initialization.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
