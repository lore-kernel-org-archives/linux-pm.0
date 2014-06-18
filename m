From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [RFC PATCH 1/4] memory: tegra124-emc: Add EMC driver
Date: Wed, 18 Jun 2014 17:24:47 -0600
Message-ID: <53A21FBF.5090806@wwwdotorg.org>
References: <1402925713-25426-1-git-send-email-tomeu.vizoso@collabora.com>
 <1402925713-25426-2-git-send-email-tomeu.vizoso@collabora.com>
 <539F4D44.3070309@wwwdotorg.org> <53A03186.3040703@collabora.com>
 <53A069B6.6070902@wwwdotorg.org> <53A1CB23.5090307@collabora.com>
 <53A1D089.8010605@wwwdotorg.org> <20140618220343.GD26514@mithrandir>
 <53A20E02.5050900@wwwdotorg.org> <20140618231410.GG26514@mithrandir>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1293100697=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20140618231410.GG26514@mithrandir>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: devicetree@vger.kernel.org, Mike Turquette <mturquette@linaro.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, kyungmin.park@samsung.com, myungjoo.ham@samsung.com, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============1293100697==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="I2dPCOm6FCrSjaWnNTXfrE9fh6llVORAp"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--I2dPCOm6FCrSjaWnNTXfrE9fh6llVORAp
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 06/18/2014 05:14 PM, Thierry Reding wrote:
> On Wed, Jun 18, 2014 at 04:09:06PM -0600, Stephen Warren wrote:
>> On 06/18/2014 04:03 PM, Thierry Reding wrote:
=2E..
>>> From what I remember, Mike was fairly strongly opposing the idea of
>>> virtual clocks, but what you're proposing here sounds like it would
>>> assume the existence of virtual clocks. clk_set_rate() per client
>>> doesn't work with the current API as I understand it.
>>>
>>> Or perhaps what you're proposing isn't about the individual clocks at=

>>> all but rather about a mechanism to express constraints for a set of
>>> clocks?
>>
>> This doesn't have anything to do with virtual clocks. As you mention,
>> it's just about constraints.
>>
>> One user of clock "cpu" wants min rate 216MHz. Another wants max rate
>> 1GHz. cpufreq will request some rate between the 2, or be capped to
>> those limits. These set of imposed constraints would need to be stored=

>> per client of the clock, not per HW clock, since many clients could se=
t
>> different max rates (e.g. thermal throttle 1.5GHz due to temperature,
>> CPU policy 1GHz due to the user selecting low CPU power, etc.)
>>
>> Similarly for audio, of there are N clients of 1 clock/PLL, and they
>> each want the PLL to run at a different rate, something needs to detec=
t
>> that and deny it.
>=20
> I'm wondering how this should work with the current API. Could the cloc=
k
> core be modified to return a per-client struct clk * that references th=
e
> hardware clock internally? Or do we need to add a new API?

I would assume the we can just change struct clk and hide the details
from any driver. Hopefully only clock-core and clock-drivers would need
any changes.


--I2dPCOm6FCrSjaWnNTXfrE9fh6llVORAp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJToh+/AAoJEJuNpwkmVCGcEQQQAIzeqtCG/DISo4rxAND+3zpE
U7yQJPFAJ7TXQGPygiCSBUNCPEhN0uhX7yCh8t+BphJdN180YYvHs8S2pbxsxQgq
rtUZcAXmD6AVA/n42ptWR6R+Cg90axWhGRsVMYGQDuzmS+ibz1Ra3vAHe7jxOFPC
g8p3IaXCBB5l0vkRXBTd8KXsj5jtjP2qq0YYtMyGNoRiLgip0fOLX9qEsxMVdaEn
I5FCd4qObGu9FEb2h0T7P4dwPqVcP/5yxQB7gpWfZQsPZNLoEBRPQJmCkZJafBXB
lM8DZGjnwvqBLDKjQ9TTP2gOq5mNmKmoLWQTKRfGJe3j44ltVd6zyMKUfPXcSCT4
KLb/jyLPK6P1mTc1qGqKUT3x+hlAIN8f+pI+mGxurjVjzQG+Msilkt9kVLY4mjgA
f5p0bBlBi0fteh9hAuiJJq2Td/WLhMib2PtodlQrAVD8HD6STqg1o7uY5qghXCGD
EsVfNFfxPEl6caTE9dgFpTeQX/HyO8g+bJ6MCX0r/eSx0Vg2tRE/dcviLAnC4gI1
B4QXJgE3ySNjFCnYrv6bQrf0Nq5+0ZzD1WK33T2hYuLyyR8wGkny/lAzL20lqRmH
mr2RZQv/htsHZOMMEbqsKUgf3h3i7iL6XQQm3up8Juf72/RzjEb+WqnoXY0OXUGK
vvu0XmhibyGb1VZS290+
=VeD4
-----END PGP SIGNATURE-----

--I2dPCOm6FCrSjaWnNTXfrE9fh6llVORAp--

--===============1293100697==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
dri-devel mailing list
dri-devel@lists.freedesktop.org
http://lists.freedesktop.org/mailman/listinfo/dri-devel

--===============1293100697==--
