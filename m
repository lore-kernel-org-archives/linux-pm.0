Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795437052;
	b=bGiSubVp8XLPWpZNOoSZ6QOWkwb4+qiE+mBzVXM74tqofeQ/7N3d5z5RQ0JR9yNWMhO+
	 ySgfjGg70Q5WOiQ6yZ9zlaEwxinJz+dyucIwBXadILeMzbe38M+pjbXF478YtVwsyk9/+
	 0+kCJOBMNgWrf+TyHAZ/qmzmDY546tfBUoDuHNzIpASaBsilz/sYaHK8JIB7sIems+c5y
	 jav/4aHENCmKyvFG6F3+oDERm31mi6C5+eRjEVwXxT+HZZs5KATVeUgubEmAGDo1Ayj9v
	 29lxxRdLtCdpDSZ+TnRQlXPNOhLzlZjCz6EOYWGvqcpO7SwwCypF7FghTiSwY++6lOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795437052;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=IvwQY8SLzqMXTEsIq2u8alrkPfd4VmYg0fzyhZJHZhk=;
	b=MlZvPrTO/CDBktvUvtFYrD2f8SnQ2wEGdAyFoYQKXhbkJgXkGxxmxHsy1XJ4oLp+KBh1
	 lJqyrL5lYIAH+rBMMwTAy/CciR1nsP6GcazMHlHZrOr3V3umO1gsx3OCgR95DnyjCninT
	 3HpXiykawnIbbBVx1j7+oCcOfLghjgV51tj48FgsMRJK7I7P3fqEU2bTaZ7YsUL931hkV
	 eYs4WwNylMWcVzxQX9hAH85RdKo6IJlEM89M83oWCQRuSKgDX6KBDUUkfmfwpcLE1Ylar
	 Ksdc8aWxdox+L/mVvfEvs/sbfVPvROErezSjRG1xaEfofkbJveQfkWcvIsDe9nJDVig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="F9dWfn/B";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762F1606A31E;
	Mon, 23 Nov 2026 12:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F9dWfn/B
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 640461F000C0;
	Mon, 23 Nov 2026 12:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795437052;
	bh=IvwQY8SLzqMXTEsIq2u8alrkPfd4VmYg0fzyhZJHZhk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=F9dWfn/Bsx6nfEV69VN+Bwli+1liqO3hOgQUdVvcSXmY0nSkI2QVYa70rIcuYv4VJ
	 B+mxuwvssGDfjZekuOzOCxYPdemUAub4iwxFmH8HAajGAH4ky1msGLY9UP/u6jWr4h
	 2P+YzisJtKp+yci0TRUd34CtVSaRm6rE+hqFKE4QuBVayzMpWH7Z8twUDqUrB6fQdr
	 f0AP9wJ+FOOhOmgyaeR7KHI5E3v+y2CQvyFf6aWbjUdt7OFU3h4s2lKwYNbTnp9ZGA
	 Jhb6koXcD4nyp0NNFuKUdAf0c4bmaqthmKivwhmHzx0tPrRBK+JArvnmRrHVntdJMJ
	 ZUDfYO0oMitxA==
Date: Mon, 23 Nov 2026 13:30:48 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Adil =?utf-8?Q?H=C3=BCsrev?= Tepe <tadilhusrev@gmail.com>
Cc: sre@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] power: supply: s2mu106-fuelgauge: add standalone
 driver
Message-ID: <20261123-tasteful-famous-dragon-00ee8d@quoll>
References: <20261117104328.1176951-1-tadilhusrev@gmail.com>
 <20261117104328.1176951-3-tadilhusrev@gmail.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20261117104328.1176951-3-tadilhusrev@gmail.com>

On Tue, Nov 17, 2026 at 01:43:28PM +0300, Adil H=C3=BCsrev Tepe wrote:
> Add a standalone driver for the fuel gauge in the Samsung S2MU106
> PMIC, as fitted on the Samsung Galaxy XCover5 (own I2C address, 0x3b).
> It shares the S2MU005 fuel gauge's STATUS/RVBAT/RCURCC/RSOC register
> layout and scaling, which this driver reads directly with the stock
> fixed-point formulas; it has no MONOUT average-monitoring registers,
> so unlike s2mu005-battery.c it never reads VOLTAGE_AVG/CURRENT_AVG or
> uses current_avg to decide POWER_SUPPLY_STATUS.
>=20
> This replaces a previous version of this series
> (https://lore.kernel.org/all/20261116074000.355176-1-tadilhusrev@gmail.co=
m/)
> that instead extended s2mu005-battery.c with a samsung,s2mu106-fuel-gauge
> fallback compatible; see "dt-bindings: power: supply: add
> samsung,s2mu106-fuelgauge" in this series for why that shape was
> dropped.

No relevant

>=20
> The driver was drafted with an AI coding assistant (Claude Code,
> Anthropic) from this register map; I reviewed every line, built it

Not relevant!

> (arm64, 0 warnings), ran checkpatch --strict (clean), and tested it on
> a Samsung Galaxy XCover5 (re-confirmed 2026-11-17, kernel
> 7.4.0-rc1-00023-gdcb8b91fb779+ #30): it probes, and
> /sys/class/power_supply/s2mu106-battery/ reports plausible voltage,
> capacity and charging-status values that track the device's actual
> state (confirmed live, including across a flash/reboot cycle).

Even less relevant, drop. AI usage goes to changelog.


> +static int s2mu106_fg_probe(struct i2c_client *client)
> +{
> +	struct s2mu106_fg *fg;
> +	struct power_supply_config cfg =3D {};
> +
> +	fg =3D devm_kzalloc(&client->dev, sizeof(*fg), GFP_KERNEL);
> +	if (!fg)
> +		return -ENOMEM;
> +
> +	fg->dev =3D &client->dev;
> +	mutex_init(&fg->lock);
> +
> +	fg->regmap =3D devm_regmap_init_i2c(client, &s2mu106_fg_regmap_config);
> +	if (IS_ERR(fg->regmap))
> +		return PTR_ERR(fg->regmap);
> +
> +	i2c_set_clientdata(client, fg);
> +
> +	cfg.drv_data =3D fg;
> +	fg->psy =3D devm_power_supply_register(&client->dev, &s2mu106_fg_desc, =
&cfg);
> +	if (IS_ERR(fg->psy))
> +		return PTR_ERR(fg->psy);
> +
> +	dev_info(&client->dev, "S2MU106 fuel gauge registered (addr 0x%02x)\n",
> +		 client->addr);

Drop, drivers should be silent on success.

> +	return 0;

Why do you need a new driver instead of integrating it into existing
s2mu005?


Best regards,
Krzysztof

