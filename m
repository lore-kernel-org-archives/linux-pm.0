From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v2] ACPI: surface3_power: MSHW0011 rev-eng implementation
Date: Sat, 1 Jul 2017 02:47:32 +0200
Message-ID: <20170701004731.e55fbqh76bkmy7hr@earth>
References: <20170629121009.30234-1-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="k6at4n5jimjo5jai"
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170629121009.30234-1-benjamin.tissoires@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Julia Lawall <julia.lawall@lip6.fr>
Cc: Bastien Nocera <hadess@hadess.net>, Stephen Just <stephenjust@gmail.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, linux-acpi@vger.kernel.org, devel@acpica.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--k6at4n5jimjo5jai
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Thu, Jun 29, 2017 at 02:10:09PM +0200, Benjamin Tissoires wrote:
> [...]
>
> +	/* get design capacity */
> +	ret = i2c_smbus_read_word_data(client,
> +				       MSHW0011_BAT0_REG_DESIGN_CAPACITY);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "Error reading design capacity: %d\n",
> +			ret);
> +		return ret;
> +	}
> +	bix->design_capacity = le16_to_cpu(ret);

i2c_smbus_read_word_data() returns native endianess for
little-endian bus (it basically has builtin le16_to_cpu).
Your conversion actually _breaks_ support on big endian
machines by converting it back.

That seems to be a common mistake in the kernel and it
might be a good idea to add some Coccinelle script for
it?

-- Sebastian

--k6at4n5jimjo5jai
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAllW8RsACgkQ2O7X88g7
+poCsg/8CD6lUQ0aAu3uMSexrU66F7O9HfmK4XG3FcBGjMG/PMknG7TzQiRDASza
xhAcP1noFqv9HCb83iV3dj0/0GuiITmjV7Wp0NZlaGXgsGHnDmXWSCAIIyxB8LbV
UYUGPUHXzv/wwSSUcq2XHCp/A5jw+l1T1mOBcCUMuHAFwhMlJ2HrPXu5K8PsKFfP
TPRulUrc88EIMmjfRmURkGkdMelp0DTUuW47He6UVNImPel7po+GjDVYF9Z2p/Sc
cS6UolaE+2how35a20jyXIAB905Ysu+cKGCEtekdgaLLE3IaDMjVyQWaKB070Fao
mz4eCxa1QucrXzC0E7XGnv9e8dPasOQzMZppKKel5qVsjyQSKHQc+aPlEERtb0l2
4pvpAmmeOGHFBOl32390xppPb9whgBKTOr3+2eYQKIn9+KZ3Jry/Y5U1Favqtw46
WmNCQGlLJOXcSfsNHOrOHro8NEqpMWctOp3xMEl6keUW+aj7i1lGAa3nErKdh5wx
Yclmuk+AypF39M/pY5cxqZMhOTViYQgtCTxY3RlfPAGdx/kLh+boYhWNn/wh5/6e
x6FEIZaJCXdQtd2HBx7WntGDybntyupZSBkP2dQTxrLO8DYouajPZXZJjljrYyFe
1s8MuX4z/IQvjftvqMEChvRXTQcRrzY/3BKkSDOsEYSvUjm8MwY=
=yunr
-----END PGP SIGNATURE-----

--k6at4n5jimjo5jai--
