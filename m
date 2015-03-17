From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH 1/6] clocksource/sh_cmt.c: Fix !HAS_IOMEM build
Date: Tue, 17 Mar 2015 09:18:49 +0100
Message-ID: <CAMuHMdWrgKZgz+nd9buJRD_76rSv6GO3VCQfV21OV=5kFRNFgQ@mail.gmail.com>
References: <1426541230-928-1-git-send-email-richard@nod.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1426541230-928-1-git-send-email-richard-/L3Ra7n9ekc@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Richard Weinberger <richard-/L3Ra7n9ekc@public.gmane.org>
Cc: "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux PM list <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jassi Brar <jassisinghbrar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Peter Meerwald <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Mar 16, 2015 at 10:27 PM, Richard Weinberger <richard-/L3Ra7n9ekc@public.gmane.org> w=
rote:
> Fixes:
> drivers/clocksource/sh_cmt.c: In function =E2=80=98sh_cmt_map_memory=E2=
=80=99:
> drivers/clocksource/sh_cmt.c:920:2: error: implicit declaration of fu=
nction =E2=80=98ioremap_nocache=E2=80=99 [-Werror=3Dimplicit-function-d=
eclaration]
>   cmt->mapbase =3D ioremap_nocache(mem->start, resource_size(mem));
>   ^
> drivers/clocksource/sh_cmt.c:920:15: warning: assignment makes pointe=
r from integer without a cast [enabled by default]
>   cmt->mapbase =3D ioremap_nocache(mem->start, resource_size(mem));
>                ^
> drivers/clocksource/sh_cmt.c: In function =E2=80=98sh_cmt_setup=E2=80=
=99:
> drivers/clocksource/sh_cmt.c:1034:2: error: implicit declaration of f=
unction =E2=80=98iounmap=E2=80=99 [-Werror=3Dimplicit-function-declarat=
ion]
>   iounmap(cmt->mapbase);
>
> Signed-off-by: Richard Weinberger <richard-/L3Ra7n9ekc@public.gmane.org>

Acked-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>

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
