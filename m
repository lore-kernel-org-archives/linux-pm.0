From: Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>
Subject: Re: [PATCH V8 2/6] thermal: bcm2835: add thermal driver for bcm2835 soc
Date: Mon, 28 Nov 2016 12:30:38 -0800
Message-ID: <87twarz6s1.fsf@eliezer.anholt.net>
References: <1478081906-12009-1-git-send-email-kernel@martin.sperl.org> <1478081906-12009-3-git-send-email-kernel@martin.sperl.org> <20161117021107.GA2647@localhost.localdomain> <766e1b70-d83a-eb52-fa2b-aec435e85673@martin.sperl.org> <20161117151019.GA3115@localhost.localdomain> <7957B3CC-0E18-4B27-82EB-EF88B7695E28@martin.sperl.org> <20161119042224.GA25063@localhost.localdomain> <28F93ABE-8210-4389-AE77-4D5E830E669B@martin.sperl.org> <20161125052008.GA8342@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161125052008.GA8342-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Cc: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pm@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> writes:

> Hello,
>
> On Tue, Nov 22, 2016 at 03:28:04PM +0100, Martin Sperl wrote:
>> Hi Eduardo!
>>=20
>> On 19.11.2016 05:22, Eduardo Valentin wrote:
>> > Hello Martin,
>
> <cut>
>
>>=20
>> I was asked to implement the "initialize" case just in case FW ever
>> stopped setting up the device itself, so that is why this code is
>> included.
>
> OK. Looks like we (like, we in the Linux side) do not understand the
> conditions that firmware fails to initialize the thermal device, but we
> still want to force an initialization, hoping to get the device in a sane
> state, even if we do not know if the firmware is correctly booted or
> not. And that is done silently, with no notification to user. I see.

The firmware today always initializes thermal.  I suggested adding the
init code because we (myself and the Pi Foundation) would like to reduce
how much closed firmware code is required in the platform, and the Linux
driver doing this would help make that possible in the future.

>> > Who has the ownership of this device?
>>=20
>> Joined ownership I suppose...
>>=20
>
> with no synchronization mechanism?

Correct, because none is necessary.

>> >> The above mentioned =E2=80=9Cconfiguration if not running=E2=80=9D re=
flect the values that
>> >> the FW is currently setting. We should not change those values as lon=
g as the
>> >> Firmware is also reading the temperature on its own.
>> >=20
>> > hmm.. that looks like racy to me. Again, How do you synchronize access=
es to
>> > this device? What if you configure the device and right after the
>> > firmware updates the configs? How do you make sure the configs you are
>> > writing here are the same used by the firmware? What if the firmware
>> > version changes? What versions of the firmware does this driver suppor=
t?
>> >=20
>> > Would it make sense to simply always initialize the device? Do you have
>> > a way to tell the firmware that it should not use the device?
>> >=20
>> > Or, if you want to keep the device driver simply being a dummy reader,
>> > would it make sense to simply avoid writing configurations to the
>> > device, and simply retry to check if the firmware gets the device
>> > initialized?
>>=20
>> Again: the device registers are only ever written if the device is not s=
tarted
>> already. Otherwise the driver only reads for the ADC register, so there
>> is no real race here.
>>=20
>
> and no race?
>
> To me, there is a race when you write to the config of this device,
> given that there is no sync between the two. We do not know if the
> firmware would be still attempting to initialize the device or not, do
> we?=20

Either the device was initialized by the firmware before handing off to
ARM (today's firmware) or it never will be (potential future firmware).

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlg8k+4ACgkQtdYpNtH8
nujz2Q//XcVXKAYKDYEQZy8L/XRhIeXFkIrGZo5D5RG5+jRGEY5Ia+F9v4r/VY1Q
0Mao1R9pbl5cOCjwmVes3GHMq7B3UCT9/ZJCcFQVw2ZLdbl2wrVJ38+mLa8YsSA4
NTWtHLvY+UuAxFL68A/oPj2gQZuOeiaRpZ8aaOJVwctkWeLi5Ok6rQ1ja22mXY6T
HYfynqFaNvREff5EfItjjX7DHGvgHyiN9F/hFfOU/2CS+/Bm5rS0rWdg0r77Aw7T
JYZlEGIkoa49n6XpPn1xK4JjwMNFfAikFVE0pT71h3lz4cZZGzZCN/bH9NslSAAC
wN1pOvFt3g4rRkGuGfmHCVwrYztmIy7bLM+waBHKKhBhc5K4HiR72PfHg1Mp7Cfx
HGdhYka8ex5t+a10Q7r5IRkMwgqS8Y+Qc3cSFdNUwzjYnaaKEljKhB5kJUDdS40M
zMe+n+r93COfB2pgN09bMA99bEL8w1aIoqD5eMbjlS0iOZbKLZdWVlNgFl/wSHm6
tYKz5b1maS+dX2DsUUw7QTptXFxGTy6+ZuOHsljA17jkvfXC3E7GlAB44XRvmk+k
GtDMuSJxlCFn+IK1m1d0oRz+mCj52edVmGMhTYJ53CGvwHU3od8hAHbyiv6p2Xwl
y7e8neQTfNcrHCwVYNmfWJGzfvs+oEic/Sl3zO/jTPU/n5on1Ow=
=NzcU
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
