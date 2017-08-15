From: Felipe Balbi <balbi@kernel.org>
Subject: Re: [PATCH v4 0/3] Introduce USB charger support in USB phy
Date: Tue, 15 Aug 2017 12:53:14 +0300
Message-ID: <87h8x96tth.fsf@linux.intel.com>
References: <cover.1501132171.git.baolin.wang@linaro.org> <CAMz4kuKYOjHgapntbuNB9b6qz35osKetwJ8jmxb=TnDKgLEuDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:64590 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753327AbdHOJx3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 15 Aug 2017 05:53:29 -0400
In-Reply-To: <CAMz4kuKYOjHgapntbuNB9b6qz35osKetwJ8jmxb=TnDKgLEuDg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: Jun Li <jun.li@nxp.com>, Peter Chen <peter.chen@freescale.com>, Mark Brown <broonie@kernel.org>, John Stultz <john.stultz@linaro.org>, NeilBrown <neilb@suse.com>, patches@opensource.wolfsonmicro.com, Baolin Wang <baolin.wang@linaro.org>, Linux PM list <linux-pm@vger.kernel.org>, USB <linux-usb@vger.kernel.org>, device-mainlining@lists.linuxfoundation.org, LKML <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Baolin Wang <baolin.wang@linaro.org> writes:
>> Currently the Linux kernel does not provide any standard integration of =
this
>> feature that integrates the USB subsystem with the system power regulati=
on
>> provided by PMICs meaning that either vendors must add this in their ker=
nels
>> or USB gadget devices based on Linux (such as mobile phones) may not beh=
ave
>> as they should. Thus provide a standard USB charger support in USB phy c=
ore
>> for doing this in kernel.
>>
>> Now introduce one user with wm831x_power to support and test the usb cha=
rger.
>> In future we will also cnvert below power drivers:
>> drivers/power/supply/axp288_charger.c
>> drivers/power/supply/bq24190_charger.c
>> drivers/power/supply/charger-manager.c
>> drivers/power/supply/qcom_smbb.c
>>
>> Changes since v3:
>>  - Bail out errors when failed to find usb phy for wm831x_power driver.
>> Changes since v2:
>>  - Add DT binding documentation for wm831x_power driver.
>>  - Change 'usb-phy' as one optional property for wm831x_power driver.
>> Changes since v1:
>>  - Fix building errors.
>
> Do you have any comments about usb charger support in usb phy core? Thank=
s.

No more comments from me

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlmSxIoACgkQzL64meEa
mQYZ6hAAvPsIcUnGXEPC0A7+wvubHiy9sJbZJYyZCTC7aQ7+I4u/EWFGHz4dTrwv
XXgj7ETal//D2vdZt751RVKQvoKd454bGiwUbEDGLIra1HLMRSKv3jziMuLAOYBT
FbJ7I1zTyQ7MYZBwbk2P+vvSzQh85H/oNJJGYkCpmrQc9vVhONKrAMwA6kD6Gt4A
K+nZSyvRbsUZqe65TUmeI9lMZ8oRwSjtTvd1JV3RIy0Xhs6lWLk5lr4cjvR7sXLG
X3MA1kqQZ5rnRNiEwqH/7gbdoWtiW93M1a3InkGLg3tuT3hbsmuLHCToEMogPFUY
NtkG46B4J9DwrTyz7rt0nzq8kzbU233g1WoTlwc/F6WvL0uUuYFekyQGURzZCVB9
C1p29fwSbXKojukBLLB/pVt7MtgHPdJJ8wWJnJwQC9o6AXXSHxI4nuRccb7BZN0H
889Kg8W5vMdICh0psCoO1rwoG7PFEtT3Q/miH6pAQOQ7fCSX9UaXLUCavTdTv6w9
hFCOWdnUKZ5uVpv0wra57vY9dl/0nWZQbOT/V9/D4wIERZvXe8gRgI/GCyOT0wAZ
CnyU7zX4+3+pUku7j90jLDkBBT4rlqVEQFbfEx0b95+C4Acal7bSGeEhFGpX2cgA
eabc85JFDfNM8YFJ2fMCwBzEj9byifcXOTe2OoPWMqnKs+9Qh6Y=
=1ozg
-----END PGP SIGNATURE-----
--=-=-=--
