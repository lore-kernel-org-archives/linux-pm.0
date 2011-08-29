From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/3] bq24022: Evaluate returns of
 gpio_direction_output-calls
Date: Mon, 29 Aug 2011 10:16:50 +0100
Message-ID: <20110829091649.GB9477@opensource.wolfsonmicro.com>
References: <201108281507.35105.heiko@sntech.de>
	<201108281508.31412.heiko@sntech.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201108281508.31412.heiko@sntech.de>
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
Cc: linux-pm@lists.linux-foundation.org, Liam Girdwood <lrg@ti.com>, Philipp Zabel <philipp.zabel@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Sun, Aug 28, 2011 at 03:08:30PM +0200, Heiko St=FCbner wrote:

>  	ret =3D gpio_direction_output(pdata->gpio_iset2, 0);
> +	if (ret) {
> +		dev_dbg(&pdev->dev, "couldn't set ISET2 GPIO: %d\n",
> +			pdata->gpio_iset2);
> +		goto err_reg;
> +	}
>  	ret =3D gpio_direction_output(pdata->gpio_nce, 1);
> +	if (ret) {
> +		dev_dbg(&pdev->dev, "couldn't set nCE GPIO: %d\n",
> +			pdata->gpio_nce);
> +		goto err_reg;
> +	}

If these are fatal errors the log messages shouldn't be dev_dbg() but
should instead be something that will be displayed by default.
