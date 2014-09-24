From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH on mfd-regulator-power-v3.17] charger: max14577: Fix
 build breakage when compiled as module
Date: Wed, 24 Sep 2014 15:35:19 +0100
Message-ID: <20140924143519.GJ32069@lee--X1>
References: <1411560006-16471-1-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1411560006-16471-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 24 Sep 2014, Krzysztof Kozlowski wrote:

> The charger's module device table used the same name as regulator dri=
ver
> causing a build break when charger was compiled as a module:
>=20
> drivers/power/max14577_charger.c:598:1: error: =E2=80=98__mod_platfor=
m__max14577_regulator_id_device_table=E2=80=99 aliased to undefined sym=
bol =E2=80=98max14577_regulator_id=E2=80=99
> make[2]: *** [drivers/power/max14577_charger.o] Error 1
>=20
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Reported-by: kbuild test robot <fengguang.wu@intel.com>
> ---
>  drivers/power/max14577_charger.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I have fixed this up into the original set and re-sent the
pull-request.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
