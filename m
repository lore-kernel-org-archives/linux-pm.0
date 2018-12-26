From: Jun Nie <jun.nie@linaro.org>
Subject: Re: [PATCH v2 5/9] i2c: zx2967: don't open code to reject transfers
 when suspended
Date: Wed, 26 Dec 2018 09:06:52 +0800
Message-ID: <CABymUCMpU+xwb8aaEgfyMWwyYSR5a33ZXuLseZiiDM7oXyRH5Q@mail.gmail.com>
References: <20181222202623.4521-1-wsa+renesas@sang-engineering.com> <20181222202623.4521-6-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181222202623.4521-6-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, linux-arm-kernel@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Shawn Guo <shawnguo@kernel.org>
List-Id: linux-pm@vger.kernel.org

Wolfram Sang <wsa+renesas@sang-engineering.com> =E4=BA=8E2018=E5=B9=B412=E6=
=9C=8823=E6=97=A5=E5=91=A8=E6=97=A5 =E4=B8=8A=E5=8D=884:26=E5=86=99=E9=81=
=93=EF=BC=9A
>
> This is handled by the I2C core meanwhile.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  drivers/i2c/busses/i2c-zx2967.c | 8 --------
>  1 file changed, 8 deletions(-)
>
    Reviewed-by: Jun Nie <jun.nie@linaro.org>
