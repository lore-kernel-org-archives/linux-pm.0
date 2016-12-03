From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v5] PM/devfreq: add suspend frequency support
Date: Sat, 3 Dec 2016 21:15:10 +0100
Message-ID: <20161203201509.GB13417@amd>
References: <1478599598-26015-1-git-send-email-hl@rock-chips.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="IiVenqGWf+H9Y6IX"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1478599598-26015-1-git-send-email-hl@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lin Huang <hl@rock-chips.com>
Cc: myungjoo.ham@samsung.com, cw00.choi@samsung.com, dianders@chromium.org, linux-rockchip@lists.infradead.org, linux-pm@vger.kernel.org, dbasehore@chromium.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--IiVenqGWf+H9Y6IX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
> index 98c6993..8567153 100644
> --- a/include/linux/devfreq.h
> +++ b/include/linux/devfreq.h
> @@ -172,6 +172,7 @@ struct devfreq {
>  	struct delayed_work work;
> =20
>  	unsigned long previous_freq;
> +	unsigned long suspend_freq;
>  	struct devfreq_dev_status last_status;
> =20
>  	void *data; /* private data for governors */
> @@ -179,6 +180,7 @@ struct devfreq {
>  	unsigned long min_freq;
>  	unsigned long max_freq;
>  	bool stop_polling;
> +	bool suspend_flag;
> =20
>  	/* information for device frequency transition */
>  	unsigned int total_trans;

It would be nice to comment what "suspend_flag" is... plus... Would it
be possible to rename suspend_freq or suspend_flag? They are really
really similar visually...

Thanks.
								Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--IiVenqGWf+H9Y6IX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlhDJ80ACgkQMOfwapXb+vJGqwCglw8JFkNNBEqtkabvIs4+Yk1L
RuUAoJgsk989wRU5BBhNHpoDscyVv7xZ
=zWEe
-----END PGP SIGNATURE-----

--IiVenqGWf+H9Y6IX--
