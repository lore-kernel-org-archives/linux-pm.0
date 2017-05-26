From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/4] Introduce regmap infrastructure over Maxim/Dalas
 OneWire (W1) bus
Date: Fri, 26 May 2017 11:21:49 +0100
Message-ID: <20170526102149.l26fzjwg5zxsqq5e@sirena.org.uk>
References: <20170525174639.3191-1-minimumlaw@rambler.ru>
 <20170525174639.3191-2-minimumlaw@rambler.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bomizzxukj2iqe64"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:35934 "EHLO
        mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1947655AbdEZKWE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 May 2017 06:22:04 -0400
Content-Disposition: inline
In-Reply-To: <20170525174639.3191-2-minimumlaw@rambler.ru>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Alex A. Mihaylov" <minimumlaw@rambler.ru>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Evgeniy Polyakov <zbr@ioremap.net>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org


--bomizzxukj2iqe64
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 25, 2017 at 08:46:36PM +0300, Alex A. Mihaylov wrote:

This looks mostly fine, a couple of small things and like I said in
reply to Greg please use subject lines matching the style for the
subsystem - this makes it a lot easier for people to identify relevant
patches.

> +	int ret = -ENODEV;
> +
> +
> +	if (reg > 255)
> +		return -EINVAL;
> +
> +	mutex_lock(&sl->master->bus_mutex);
> +	if (!w1_reset_select_slave(sl)) {
> +		w1_write_8(sl->master, W1_CMD_READ_DATA);
> +		w1_write_8(sl->master, reg);
> +		*val = w1_read_8(sl->master);
> +		ret = 0;
> +	}
> +	mutex_unlock(&sl->master->bus_mutex);

This is a bit confusing with how -ENODEV is generated - move the
assignment into the if statement so it doesn't look like we're silently
ignoring errors unless you look back to the top of the function.

> +static struct regmap_bus regmap_w1_bus_a8_v16 = {
> +	.reg_read = w1_reg_a8_v16_read,
> +	.reg_write = w1_reg_a8_v16_write,
> +};

It'd be clearer to just have all all these structs at the end of the set
of functions rather than scattered about randomly.

--bomizzxukj2iqe64
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlkoAbwACgkQJNaLcl1U
h9AofQf/aEue5DoS/zCaqT3tnf+HWPsJVrzAJ4UsGZK2x3Adq14Yn+bjPF4Cf0W9
RrWhm5XqG+JvXUqJMK1hvNkvH5sLoPzepLZnLcAw8jukIrJv/JiRALN36UMA4WKu
+1+2JJ+bMeqnnjWe2oyVmOeLf2CCutt1Xo0S2ve4YwldRbQAAQSUovYrTwPqe5mr
/6CkUHMOJcZKbSgOOTyn259TOY+pELdA7pvDjj5GPkU5wn6SXf+Tuvmmp1C4Az51
qtPWAbdHn/I3+zYIrTOzO8vMKfdd8cDZNpvOhflul3Of78xT1h9oNS34fQye9nVn
3b9d+5emL0lvAoZwxnJIvfPrhYt8ZA==
=EMbR
-----END PGP SIGNATURE-----

--bomizzxukj2iqe64--
