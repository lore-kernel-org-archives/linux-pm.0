From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] Add regulator driver for the bq2407x family
 of charger ICs
Date: Tue, 23 Aug 2011 12:50:24 +0100
Message-ID: <20110823115024.GL9232@opensource.wolfsonmicro.com>
References: <201108202224.52250.heiko@sntech.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201108202224.52250.heiko@sntech.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Cc: linux-pm@lists.linux-foundation.org, Liam Girdwood <lrg@ti.com>
List-Id: linux-pm@vger.kernel.org

On Sat, Aug 20, 2011 at 10:24:51PM +0200, Heiko St=FCbner wrote:

Mostly looks good, just a few fairly small comments below.

> +	if (pdata->max_uA && pdata->max_uA > 500000
> +			      && max_uA >=3D pdata->max_uA) {
> +		dev_dbg(rdev_get_dev(rdev),
> +			"setting current limit to %d mA\n",
> +			pdata->max_uA / 1000);
> +		gpio_set_value(pdata->gpio_en2, 1);
> +		gpio_set_value(pdata->gpio_en1, 0);
> +	} else if (max_uA >=3D 500000) {
> +		dev_dbg(rdev_get_dev(rdev),
> +			"setting current limit to 500 mA\n");
> +		gpio_set_value(pdata->gpio_en2, 0);
> +		gpio_set_value(pdata->gpio_en1, 1);
> +	} else if (max_uA >=3D 100000) {
> +		dev_dbg(rdev_get_dev(rdev),
> +			"setting current limit to 100 mA\n");
> +		gpio_set_value(pdata->gpio_en2, 0);
> +		gpio_set_value(pdata->gpio_en1, 0);
> +	} else {
> +		dev_dbg(rdev_get_dev(rdev),
> +			"setting current limit to 0 mA\n");
> +		gpio_set_value(pdata->gpio_en2, 1);
> +		gpio_set_value(pdata->gpio_en1, 1);
> +	}

I'd rather expect this to return an error sometimes.

> +static int bq2407x_get_current_limit(struct regulator_dev *rdev)
> +{
> +	struct bq2407x_mach_info *pdata =3D rdev_get_drvdata(rdev);
> +
> +	int en2 =3D gpio_get_value(pdata->gpio_en2);
> +	int en1 =3D gpio_get_value(pdata->gpio_en1);

Calling gpio_get_value() on an output GPIO is undefined, you need to
remember what values you set.

> +static int bq2407x_enable(struct regulator_dev *rdev)
> +{
> +	struct bq2407x_mach_info *pdata =3D rdev_get_drvdata(rdev);
> +
> +	dev_dbg(rdev_get_dev(rdev), "enabling charger\n");
> +
> +	gpio_set_value(pdata->gpio_nce, 0);
> +	return 0;

Blank line here.
