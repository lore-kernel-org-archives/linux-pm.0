From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 15/17] thermal: st: allow compile test
Date: Fri, 11 Sep 2015 10:23:35 +0100
Message-ID: <20150911092335.GK3260@x1>
References: <1441858273-4017-1-git-send-email-edubezval@gmail.com>
 <1441858273-4017-16-git-send-email-edubezval@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1441858273-4017-16-git-send-email-edubezval@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Rui Zhang <rui.zhang@intel.com>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Nicolas Boichat <drinkcat@chromium.org>, Mark Brown <broonie@kernel.org>, Fabian Frederick <fabf@skynet.be>, Wolfram Sang <wsa@the-dreams.de>
List-Id: linux-pm@vger.kernel.org

On Wed, 09 Sep 2015, Eduardo Valentin wrote:

> Adding COMPILE_TEST flag to st driver to facilitate
> maintenance.
>=20
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Nicolas Boichat <drinkcat@chromium.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Fabian Frederick <fabf@skynet.be>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: linux-pm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
> ---
>  drivers/thermal/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Sounds reasonable.

So long as it's been tested and nothing breaks:

Acked-by: Lee Jones <lee.jones@linaro.org>

> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index 9069cc7..d94b4e9 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -350,7 +350,7 @@ source "drivers/thermal/samsung/Kconfig"
>  endmenu
> =20
>  menu "STMicroelectronics thermal drivers"
> -depends on ARCH_STI && OF
> +depends on (ARCH_STI || COMPILE_TEST) && OF
>  source "drivers/thermal/st/Kconfig"
>  endmenu
> =20

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
