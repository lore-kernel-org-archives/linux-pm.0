Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA3118DB1A;
	Sun, 29 Mar 2026 02:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774750168; cv=none; b=r4ZIsJmq72QNTP8k4a8TERFYE2CxMJnkz4RTImF/4LFDuwyF9VPFANrY18cjCF1N+0LDtJqAmmNOA8fCKn3LJTBlYSdnSWVu3QjoMpXEOnMfgi2ZfiVo8Lt+vipqXZcnkZVxhqaO7+iQjfZea8Txn2L7PyEXio0g7AiJmW2iXl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774750168; c=relaxed/simple;
	bh=N0Ctz2J8oPvKls81ucEZB5qGoRQfvViEmfax2GeVhNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jwBYVSoygFRnatbdMk8U9MGKAKCq/MtoEdPiWJRak8jJh5miKP0XHOS1+k29iva4AOKPus1o5oaX7NC4w2wG9JQlIYbXoEKLOGjYac4mssz1HvkM0Ch8v0kvqtted4uM75nOqm8pq4pUYSaBFjK2TmmoalwFCZg9YCN4xMQYJ2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h2P6V5Tc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h2P6V5Tc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0737FC4CEF7;
	Sun, 29 Mar 2026 02:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774750168;
	bh=N0Ctz2J8oPvKls81ucEZB5qGoRQfvViEmfax2GeVhNw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h2P6V5Tc0PYTUED1/KmH0DY8uN8EtK4d5oSvm4YwJZyFqWE6ocbcCiw2bHA65ILKf
	 crrjMN/09y7rmZz/59IuERQ8nH7cLByyVoRzW6m69yA4Ypi0QphB6uNo7lPdYSfShr
	 rR6NVnoGxccwPyB8MX3oKuo+abnb3gA5ybZPle9MU3EhY3QHRyvt+AnQFB4+YqMFjc
	 T+prbf6b/prfqVcPpt4lkSXmazWlr77R8y8ypMtei7gZCiNpHGv1ugclqkDLmyWTqS
	 WVNGKVPBcZFvACOvyLMYO+CMEXjS/3F4KmVAndBiM4BtPiFLJv6P+N5knmgujCuY2B
	 UNcB77KVP+nGg==
Received: by venus (Postfix, from userid 1000)
	id E9CFC182F82; Sun, 29 Mar 2026 04:09:25 +0200 (CEST)
Date: Sun, 29 Mar 2026 04:09:25 +0200
From: Sebastian Reichel <sre@kernel.org>
To: Linus Walleij <linusw@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, 
	"Rob Herring (Arm)" <robh@kernel.org>, Khushal Chitturi <khushalchitturi@gmail.com>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH] dt-bindings: power: reset:
 cortina,gemini-power-controller: convert to DT schema
Message-ID: <aciItMCdBbrVvMKB@venus>
References: <20260328124707.141209-1-khushalchitturi@gmail.com>
 <177470797266.1536342.6967120656934552033.robh@kernel.org>
 <CAD++jL=_rCmW=eSV0kvck50sC2xaQnGQoEOy=DNcwkFvvWYUUw@mail.gmail.com>
 <3fa4fad0-d918-4de0-ad80-dad2141d2617@kernel.org>
 <CAD++jLnxoS-OGBSAXxgGPaME7eMTwCQ-C+uzub6m0o9ZgXL_aA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3ymhluvcv553maph"
Content-Disposition: inline
In-Reply-To: <CAD++jLnxoS-OGBSAXxgGPaME7eMTwCQ-C+uzub6m0o9ZgXL_aA@mail.gmail.com>


--3ymhluvcv553maph
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] dt-bindings: power: reset:
 cortina,gemini-power-controller: convert to DT schema
MIME-Version: 1.0

Hi,

On Sat, Mar 28, 2026 at 10:28:39PM +0100, Linus Walleij wrote:
> On Sat, Mar 28, 2026 at 6:31=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.=
org> wrote:
> > On 28/03/2026 17:12, Linus Walleij wrote:
> > > On Sat, Mar 28, 2026 at 3:26=E2=80=AFPM Rob Herring (Arm) <robh@kerne=
l.org> wrote:
> > >
> > >> dtschema/dtc warnings/errors:
> > >> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindi=
ngs/power/reset/cortina,gemini-power-controller.example.dtb: power-controll=
er@4b000000 (cortina,gemini-power-controller): '#power-domain-cells' is a r=
equired property
> > >>         from schema $id: http://devicetree.org/schemas/power/power-d=
omain.yaml
> > >
> > > Weird, this power controller does not handle power domains whatsoever,
> > > it handles the mains power. So it should not have any power domain
> > > cells.
> > >
> > > Is this the result of some regexp gone stray?
> >
> > The name "power controller" is used for power domain controller, so
> > that's why this name must not be used for other use cases. Usual
> > replacement is power-management, reboot, restart or poweroff, depending
> > on what is the purpose of this device.
>=20
> So in this case this is just a conversion of the 9 years old text document
> which is an as valid binding as any:
>=20
> commit ba443b5ab454a9b5f49229a94b2dadf06ac8b79e
> Author: Linus Walleij <linusw@kernel.org>
> Date:   Sun Mar 12 23:36:01 2017 +0100
>=20
>     power: reset: Add Gemini poweroff DT bindings
>=20
>     This adds device tree bindings to the power management controller
>     in the Gemini SoC.
>=20
>     Cc: devicetree@vger.kernel.org
>     Cc: Janos Laube <janos.dev@gmail.com>
>     Cc: Paulius Zaleckas <paulius.zaleckas@gmail.com>
>     Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>
>     Cc: Florian Fainelli <f.fainelli@gmail.com>
>     Acked-by: Rob Herring <robh@kernel.org>
>     Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>     Signed-off-by: Sebastian Reichel <sre@kernel.org>
>=20
> The text document was conspiciously named "gemini-poweroff.txt" while the
> compatible is ""cortina,gemini-power-controller".
>=20
> I don't know what came first, this binding or the convention of
> *-power-controller, but it's solidly there for a while so we need
> to accomodate this, I guess worst case simply special-casing it?

The problem is the node name (power-controller@4b000000), which is
reserved for power domains. You can keep the compatible.

Greetings,

-- Sebastian

--3ymhluvcv553maph
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmnIickACgkQ2O7X88g7
+prjpQ//bcgyFf6rWXsP0eTn33ApGxRHQt+k48z+5yHgyrWGiEsof+GvGhuWihRr
RAwhrhKYJv9Klz7RbQXnKzyObtWNXi3D8hjuHnZiAv/ZZaogof5hFw8Hy8hFBGB3
QBmhabdsE5rkEZCmPwvOCw5JvOgiPL5k42weR5hh5RcYOeYHHmi5FoFTOyidXfpB
JuOR9l4Gg5LToBzl7hVldQvwGy5tkaPjZav6uNyRd3Zi/Zua7brsK6iOuOprZEeD
LxgWTqW4c6HJ9uWxKr9KV/ad89icUswYqWTAuMZQ9a5LP8NkZnezg6Fp0rtHoju7
lzDB6LNaGoAQqRD8m1KzIBt2xcXZC8hT2W60ZPe2k1YB4V/70peOg8oChRslr1ew
QTdSvC/gZVXS7g87GNdjUIn04WA8iW/IsaF+I2uupOsjGg5RVuk2F2v2rMNTUV2E
Bg5+OLEwSZTS13ysRcX5U+exM/Pk2Y6sOTdhmXnVikgwQEez7LEM+/551K5nR04M
eDbspHMwCBw5C2WtZLmKy58RKRbYlQQbOpjhh0NqtgbXVXrM1FUA9/3uI1RgK/VM
6biWh/IClVnxQVITtNTxE6Im1p7PU2OutdQiGDHZiF6FvYsddpD96QIVNgJ5S52n
Ith3J9MIt7PjH16QMBEcoW6DQ76H7UNLAl3hkkMArmJjakGgXrI=
=b1TC
-----END PGP SIGNATURE-----

--3ymhluvcv553maph--
