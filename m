From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: Re: [PATCH v6 8/8] mfd: axp20x: Add supported cells for AXP803
Date: Fri, 7 Dec 2018 10:58:22 -0800
Message-ID: <CA+E=qVe5gau_9A6WsdqDaEJwdJ7EyQ=UcNu0JJV3v=hKAFU7GQ@mail.gmail.com>
References: <20181120175211.3913-1-oskari@lemmela.net> <20181120175211.3913-9-oskari@lemmela.net>
 <20181207164011.GI26661@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181207164011.GI26661@dell>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Oskari Lemmela <oskari@lemmela.net>, Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <maxime.ripard@bootlin.com>, quentin.schulz@bootlin.com, linux-pm@vger.kernel.org, devicetree <devicetree@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, arm-linux <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Dec 7, 2018 at 8:40 AM Lee Jones <lee.jones@linaro.org> wrote:

> My OCD-dar is going crazy.
>
> Why haven't you used the same alignment as is already there?
>
> If it starts to run over 80-chars then bring the others back.
>
> Also why is there a single liner shoved in the middle of the
> multi-line entries?  Please move the singles to the top or the
> bottom.

Hi Lee,

Could you please reformat it in the way that makes your OCD-dar happy?
It would be really nice to get
AC and battery support for APX8x3 merged -- it'll make Pinebook and
Teres-I pretty well supported by mainline kernel.

Thanks,
Vasily

>
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
> Linaro Services Technical Lead
> Linaro.org =E2=94=82 Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
