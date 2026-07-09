Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53D24E3783;
	Thu,  9 Jul 2026 18:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783621764; cv=none; b=kms6ZVnxuyFrgHQUKQqfUVpX+4yvGqPHfll29liGXywZN+6Q54/a3qJ+A7ctiOHD2ng+lxraBiqvgi8xfIkvqQORnpFTaSVREmgwVDGLxLsad1nkYKpdv/5J/+j+nemBq67pGZJb5vWJ2kiUJI4kcrCve/nP2kmk9XHzPleh1dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783621764; c=relaxed/simple;
	bh=gxwHzadL7UsOp1A4yt1lkHCLrDcNd4Psacp/We5Hu4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FXbvKKtc5jyZ4lIiPBkP1Li620cI01ENZa8BNH8bBdXxlLALga2qTfT6FgqYKxgPBw6d7tXFs8R02I41OCy5S/se/7OXtzpZbYupEhV1qQwCMqfiD7thOC53HAiZqC90GYI6k/9OZc8Xq6EE5DJ88Qm3U0hGtMYm3PjXZjIQ1wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xko9nxCY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xko9nxCY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8700C1F000E9;
	Thu,  9 Jul 2026 18:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783621753;
	bh=TabPWWStRvKtiXwg+LEf/C3NvzrtOeicayZoNxrbVxs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Xko9nxCY6y+tc1YLTScES8TazWsq5OpuZq8Y1rlxhvZBHHn6kVj3Dsy13ei3NP6Mr
	 pUOYjV70L7I0ngn2FNT2awsiYhvW8FiOImyUNVlTvWcoXbo8W6kGIXbaBgwsp4bC/F
	 huA7eXBETurT+hhsigrr+sfGJYpkgrbPPi9YTlZlvGe3uEoohjpwLXgyWV0krZ/SVT
	 TGoE3ofi5vn8NxPW2YTVyE/pfcEnXyWel27iPgVs0V+iuy/aDePrTqrgWOWGVPiBU4
	 RHv74CU4K1tagxXhy2isvsdZRCgAkMcLbNQQtpd3MrxtXuXkNdO1qPlhNZBhAp8S+q
	 3BiO9ujOijjSA==
Date: Thu, 9 Jul 2026 19:29:06 +0100
From: Mark Brown <broonie@kernel.org>
To: Praveen Talari <praveen.talari@oss.qualcomm.com>
Cc: Dilip Kota <dkota@codeaurora.org>, Stephen Boyd <swboyd@chromium.org>,
	Girish Mahadevan <girishm@codeaurora.org>,
	Alok Chauhan <alokc@codeaurora.org>,
	bjorn.andersson@oss.qualcomm.com,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Douglas Anderson <dianders@chromium.org>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
	aniket.randive@oss.qualcomm.com,
	chandana.chiluveru@oss.qualcomm.com,
	jyothi.seerapu@oss.qualcomm.com, linux-pm@vger.kernel.org,
	driver-core@lists.linux.dev
Subject: Re: [PATCH v3 2/2] spi: qcom-geni: Fix missing error check on
 pm_runtime_get_sync()
Message-ID: <2fe34b3c-11cf-417e-9440-75a5d6e3f4d7@sirena.org.uk>
References: <20260706-fix_sticky_-einval_after_pm_runtime_api_failure-v3-0-92feb5a7b926@oss.qualcomm.com>
 <20260706-fix_sticky_-einval_after_pm_runtime_api_failure-v3-2-92feb5a7b926@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="CeC8CvVPO3AHS8XP"
Content-Disposition: inline
In-Reply-To: <20260706-fix_sticky_-einval_after_pm_runtime_api_failure-v3-2-92feb5a7b926@oss.qualcomm.com>
X-Cookie: MS-DOS must die!


--CeC8CvVPO3AHS8XP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 06, 2026 at 02:23:10PM +0530, Praveen Talari wrote:
> spi_geni_init() calls pm_runtime_get_sync() to power up the device
> before accessing hardware registers, but never checks the return value.

> @@ -693,10 +698,7 @@ static int spi_geni_init(struct spi_geni_master *mas)
>  		writel(spi_tx_cfg, se->base + SE_SPI_TRANS_CFG);
>  	}
> =20
> -out_pm:
> -	pm_runtime_put(mas->dev);
>  	return ret;
> -}
> =20
>  static unsigned int geni_byte_per_fifo_word(struct spi_geni_master *mas)

The above breaks the build due to removing the closing brace for the
function:

/build/stage/linux/drivers/spi/spi-geni-qcom.c: In function =E2=80=98spi_ge=
ni_init=E2=80=99:
/build/stage/linux/drivers/spi/spi-geni-qcom.c:712:21: error: invalid stora=
ge class for function =E2=80=98geni_byte_per_fifo_word=E2=80=99
  712 | static unsigned int geni_byte_per_fifo_word(struct spi_geni_master =
*mas)
      |                     ^~~~~~~~~~~~~~~~~~~~~~~
/build/stage/linux/drivers/spi/spi-geni-qcom.c:726:13: error: invalid stora=
ge class for function =E2=80=98geni_spi_handle_tx=E2=80=99
  726 | static bool geni_spi_handle_tx(struct spi_geni_master *mas)
      |             ^~~~~~~~~~~~~~~~~~
/build/stage/linux/drivers/spi/spi-geni-qcom.c:764:13: error: invalid stora=
ge class for function =E2=80=98geni_spi_handle_rx=E2=80=99
  764 | static void geni_spi_handle_rx(struct spi_geni_master *mas)
      |             ^~~~~~~~~~~~~~~~~~
/build/stage/linux/drivers/spi/spi-geni-qcom.c:808:12: error: invalid stora=
ge class for function =E2=80=98setup_se_xfer=E2=80=99
  808 | static int setup_se_xfer(struct spi_transfer *xfer,

and so on.

--CeC8CvVPO3AHS8XP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmpP6HIACgkQJNaLcl1U
h9BSzAf/SeXNxRk0EmmkgXQsQkbxwTQzUT3bKaWL/CX0xxNnaoR+ZYpK15jNuVng
Yfnob+oGCKSZlpMlg89lOUMxWoWaZoXKHAF6ZATyxR3PWVR6yMMY0jicZZOQyBWW
6A0Eobhjh2jAG4nk93TFi66m4oV1FAZg963+5wjcYBAYAkVqg/a2nGi/2eltJq2b
tDBZ6jtcbdZke3STVUcQLpVOqGW84xFf9XY8krP8TZW9YoMByUKyzW7ZVQsST/3S
oa539uAhRQZGCIy4OxQ9uF/CjNI8aykNtkWvFoc+0yS0onYsevbiNAlmZduzEQqt
T4kDtaSZosyma7QWOe+uUhj8Pj0e1g==
=d8m7
-----END PGP SIGNATURE-----

--CeC8CvVPO3AHS8XP--
