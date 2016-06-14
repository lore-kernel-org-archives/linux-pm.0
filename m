From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 10/10] i2c: designware-platdrv: Rework system PM support
Date: Tue, 14 Jun 2016 18:35:16 +0300
Message-ID: <1465918516.30123.66.camel@linux.intel.com>
References: <1465916848-8207-1-git-send-email-ulf.hansson@linaro.org>
	 <1465916848-8207-11-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <1465916848-8207-11-git-send-email-ulf.hansson@linaro.org>
Sender: linux-i2c-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, John Stultz <john.stultz@linaro.org>, Guodong Xu <guodong.xu@linaro.org>, linux-arm-kernel@lists.infradead.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, 2016-06-14 at 17:07 +0200, Ulf Hansson wrote:
> The current code that deploys the system PM support relies on the
> "direct_complete" feature supported by the PM core. The goal is to
> avoid
> performing unnecessary operations during the system PM sequence.
>=20

>=20
> =C2=A0static const struct dev_pm_ops dw_i2c_dev_pm_ops =3D {
> -	.prepare =3D dw_i2c_plat_prepare,
> -	.complete =3D dw_i2c_plat_complete,
> -	SET_SYSTEM_SLEEP_PM_OPS(dw_i2c_plat_suspend,
> dw_i2c_plat_resume)
> -	SET_RUNTIME_PM_OPS(dw_i2c_plat_suspend, dw_i2c_plat_resume,
> NULL)
> +	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> +				pm_runtime_force_resume)
> +	SET_RUNTIME_PM_OPS(dw_i2c_plat_runtime_suspend,
> +			dw_i2c_plat_runtime_resume,
> +			NULL)
> =C2=A0};

UNIVERSAL_PM_OPS ?

--=20

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
