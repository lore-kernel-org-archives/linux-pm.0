From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH trivial] PM / devfreq: Spelling s/frequnecy/frequency/
Date: Tue, 15 Mar 2016 17:14:22 +0900
Message-ID: <56E7C45E.8080306@samsung.com>
References: <1457969342-23672-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:41026 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934259AbcCOIOm (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 15 Mar 2016 04:14:42 -0400
In-reply-to: <1457969342-23672-1-git-send-email-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Jiri Kosina <trivial@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 2016=EB=85=84 03=EC=9B=94 15=EC=9D=BC 00:29, Geert Uytterhoeven wrot=
e:
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/devfreq/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
> index 64281bb2f6503c5a..4de78c552251a5a5 100644
> --- a/drivers/devfreq/Kconfig
> +++ b/drivers/devfreq/Kconfig
> @@ -61,7 +61,7 @@ config DEVFREQ_GOV_USERSPACE
>  	  Sets the frequency at the user specified one.
>  	  This governor returns the user configured frequency if there
>  	  has been an input to /sys/devices/.../power/devfreq_set_freq.
> -	  Otherwise, the governor does not change the frequnecy
> +	  Otherwise, the governor does not change the frequency
>  	  given at the initialization.
> =20
>  comment "DEVFREQ Drivers"
>=20

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

Thanks,
Chanwoo Choi
