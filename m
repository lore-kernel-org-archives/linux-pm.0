From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v2 1/2] regmap: include <linux/ktime.h> from
 include/linux/regmap.h
Date: Mon, 23 Apr 2018 12:11:01 +0200
Message-ID: <d3e10dc5-55d3-40b8-a8de-d48aaaecf019@gmail.com>
References: <ccea364eeb830b2092987d271c8308b97fe59d8f.1524465345.git.sean.wang@mediatek.com>
 <20180423100318.GA19834@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180423100318.GA19834@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, sean.wang@mediatek.com
Cc: rjw@rjwysocki.net, khilman@baylibre.com, ulf.hansson@linaro.org, linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256



On 04/23/2018 12:03 PM, Mark Brown wrote:
> On Mon, Apr 23, 2018 at 02:42:44PM +0800, sean.wang@mediatek.com wrote:
>> From: Sean Wang <sean.wang@mediatek.com>
>> 
>> Similar to the readx_poll_timeout() macro calling ktime_* and using 
>> ktime_t type, which is declared in <linux/ktime.h>. So, make
> 
> I'm missing patch 2 here - what's the story, are there any dependencies?
> 

You can find the second patch here:
https://patchwork.kernel.org/patch/10356237/

Regards,
Matthias
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEiUuSfQSYnG8EMsBltDliWyzx00MFAlrdsS4ACgkQtDliWyzx
00PC6Q/9EqSQ24OeBB6lqD/V58ZEwRP/w6fE9viRP/T0xsa+7NAw3oT5W79ULFYT
TSjllZ3yytjRCx5UUnLlkNgEN5UPrUUxkmqJH/q2JMuMgmxn1uRWQuyuqWD78RDG
FQqchWWuOhAf8PNR9ZeHhyRrp2E2RQWzYQ4wj49ZPU/eDFP7IiE8O/wcQ9hU/zNe
O0r7lnCi7mHHkcns2biOl4WDlkuYVRAQkMYO2w632lO0EiNrKIwyULCzy1s3r21i
C/9AMi42hAqtGYtfIEPedNvGpJllyitRmZcK0DQCXQJ8z7UKlAHhvU2GRhkHdERR
bQr/cuFXdUMaiOG6yBYSLOYIsCcXqI1NOLK0j8e7IxN36Lq+3fcyp5O6uTheHBGF
N/6Kp/fmV+v1dPsWGPOOe5Zxa0yOUSiZglhtEV+YwDrOsUyANMeLkZIeKXERA1WX
FI6uPF3eJvThMy5uEmAkmfCSlVIGCqyITg6lIOKiC/dY23H4HFrUlzf3+I8Qmmuy
In4Hk61bS1jQWFU5sWMy6/ptG2TV30sf/PJtWjGYONS4DrN6vXwTE+Sdgz1793cO
jzo1KHuGjfN7efBwlFykJZ8NLU3EAyStini+uXS24W0Rv6M/wcfNpjELIEnEw9db
rNqkp/ySzkV+uJf/4Fvpt6ysQgofuJpkM6bWDfbrg8jKpYfwid0=
=mFXy
-----END PGP SIGNATURE-----
