From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: libbattery was Re: [RFC PATCH 5/5] power: generic-adc-battery: Add capacity handling
Date: Fri, 8 Sep 2017 15:15:32 +0200
Message-ID: <F8C402D4-06D1-44A5-B607-DBC88C873EBF@goldelico.com>
References: <1501620926-22669-1-git-send-email-marek.belisko@open-nandra.com> <1501620926-22669-6-git-send-email-marek.belisko@open-nandra.com> <20170829101147.debhadzyfrxhkrvt@earth> <20170908113231.GJ18365@amd>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: multipart/signed; boundary="Apple-Mail=_341EBE78-7005-4043-8690-21A1B993D1B3"; protocol="application/pgp-signature"; micalg=pgp-sha256
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170908113231.GJ18365@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Marek Belisko <marek.belisko@open-nandra.com>, Rob Herring <robh+dt@kernel.org>, Linux PM mailing list <linux-pm@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Marek Belisko <marek.belisko@gmail.com>, Pavel Machek <pavel@ucw.cz>, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>
List-Id: linux-pm@vger.kernel.org


--Apple-Mail=_341EBE78-7005-4043-8690-21A1B993D1B3
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

Hi,

> Am 08.09.2017 um 13:32 schrieb Pavel Machek <pavel@ucw.cz>:
> 
> Hi!
> 
>>> +	case POWER_SUPPLY_PROP_CAPACITY:
>>> +		{
>>> +		int ret, curr, voltage;
>>> +
>>> +		ret = read_channel(adc_bat, POWER_SUPPLY_PROP_CURRENT_NOW, &curr);
>>> +		ret |= read_channel(adc_bat, POWER_SUPPLY_PROP_VOLTAGE_NOW, &voltage);
>>> +		if (ret < 0)
>>> +			goto err;
>>> +
>>> +		val->intval = fuel_level_LiIon(voltage, curr, 10);
>>> +		}
>>> +		break;
>>> 	default:
>>> 		return -EINVAL;
>>> 	}
>> 
>> Without patch description: See Last Question in
>> 
>> Documentation/power/power_supply_class.txt

The main argument to answer with "Most likely, no" seems to be:

"  as it would require floating point calculation to deal
   with things like differential equations and Kalman filters."

The code shown above uses none of such things, hence the answer
could as well be "Yes, if it is simple enough to be handled by
the kernel with some lines of code and integer arithmetic".

> 
> ...should be done in libbattery, yet to be written. :-).

For 10 years... Doesn't seem like anyone is waiting for it.

> 
> Do you have specific guidance what you'd like to see in libbattery?

As a poor user I'd expect it to be available and widely accepted by
major distributions and battery monitoring applications in max. 3 months.

If that is not possible, I'd recommend to toss overboard a 10 years old
"maybe" rule and just fix the single problem once and for all in the
generic-adc-battery driver instead of dreaming of user space magically
solving problems where we already have a proposal for a kernel solution.

We should not forget that all this work is just to replace the pdata
based drivers/power/supply/twl4030_madc_battery.c with a proper and
more general DT based solution.

Nothing new, no rocket science (differential equations and Kalman filters)
expected.

BR,
Nikolaus


--Apple-Mail=_341EBE78-7005-4043-8690-21A1B993D1B3
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJZspf1AAoJEIl79TGLgAm6uJQP/2bV63E7DPbSijMbmjvHd+5D
eOoIjBYf405NxA8KMBI8aKzcAmh/DcRzRkWlNMGFUZ3sHl+/f2n8BVr1tCTMfOaP
T9fteDZgBTwbvd/WwAk+NKG9eKXLhqFblKj+UnQwJCCtrEazvDkulCNIqY/QYTEW
8StZkETmtg6n9xa3kmEwaxsPL4Qp4TBuU0kOKVWnkdZF0gmgNf2AlgZEuenY5iyk
6yL65Ielobc2XFM7UvD6ptT+NJ27GjwSuvc+4vhe9xnnVbZNhXcP3gtlm/CN4pQm
U301zM5nrBxjPdDLNS3UklcbCiFjLEEdbSsbaVPh4pktoHct+25vsCWeqxmZOCmV
5K8FW4njphQTKIWOq31r5YSupUM5GlBU1Zv40GKCKbsMVrnbVd0PukESXyROQdRk
MPCcxDST5dYYV2mda0w8jRUZ9O+vAb9AL4310k1n5uZH5jPiBsveGqlkgsHf+FMG
WosyneH9MNtBxL4lR+IxWzab47vLn+J/PWNHWQX3RDGjddC9Mp+3e5fXd2LNE4FR
rrUjj3kvTu8Dnu+PtibmlceXF8ZgZCYFIoLlpKXgDI81qUCGe/GtPypCnoocoZmN
W/gwJvUT3W60+YrrhBJ8ksafCLScf3d1wJP0+t6Hw4xw2Wn0xL+a4X7Hjm5DAk3O
OdXkn9glsZ3e360Xm4D9
=IOGs
-----END PGP SIGNATURE-----

--Apple-Mail=_341EBE78-7005-4043-8690-21A1B993D1B3--
