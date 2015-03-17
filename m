From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 3/6] clocksource/sh_tmu.c: Fix !HAS_IOMEM build
Date: Tue, 17 Mar 2015 09:19:25 +0100
Message-ID: <CAMuHMdUbOya3D3K0i2kgv1-Eqj1JqKfL18ByRgemZuB1gTCP1w@mail.gmail.com>
References: <1426541230-928-1-git-send-email-richard@nod.at>
	<1426541230-928-3-git-send-email-richard@nod.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f169.google.com ([209.85.214.169]:34642 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752750AbbCQITZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 17 Mar 2015 04:19:25 -0400
In-Reply-To: <1426541230-928-3-git-send-email-richard@nod.at>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Richard Weinberger <richard@nod.at>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-iio@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>, David Woodhouse <dwmw2@infradead.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Sebastian Reichel <sre@kernel.org>, Jassi Brar <jassisinghbrar@gmail.com>, Peter Meerwald <pmeerw@pmeerw.net>, Lars-Peter Clausen <lars@metafoo.de>, Hartmut Knaack <knaack.h@gmx.de>, Jonathan Cameron <jic23@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>

On Mon, Mar 16, 2015 at 10:27 PM, Richard Weinberger <richard@nod.at> w=
rote:
> Fixes:
> drivers/clocksource/sh_tmu.c: In function =E2=80=98sh_tmu_map_memory=E2=
=80=99:
> drivers/clocksource/sh_tmu.c:506:2: error: implicit declaration of fu=
nction =E2=80=98ioremap_nocache=E2=80=99 [-Werror=3Dimplicit-function-d=
eclaration]
>   tmu->mapbase =3D ioremap_nocache(res->start, resource_size(res));
>   ^
> drivers/clocksource/sh_tmu.c:506:15: warning: assignment makes pointe=
r from integer without a cast [enabled by default]
>   tmu->mapbase =3D ioremap_nocache(res->start, resource_size(res));
>                ^
> drivers/clocksource/sh_tmu.c: In function =E2=80=98sh_tmu_setup=E2=80=
=99:
> drivers/clocksource/sh_tmu.c:598:2: error: implicit declaration of fu=
nction =E2=80=98iounmap=E2=80=99 [-Werror=3Dimplicit-function-declarati=
on]
>   iounmap(tmu->mapbase);
>
> Signed-off-by: Richard Weinberger <richard@nod.at>

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-=
m68k.org

In personal conversations with technical people, I call myself a hacker=
=2E But
when I'm talking to journalists I just say "programmer" or something li=
ke that.
                                -- Linus Torvalds
