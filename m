From: Eric Anholt <eric@anholt.net>
Subject: Re: [PATCH] PM / Domains: If an OF node is found but no device probed yet, defer.
Date: Wed, 18 Mar 2015 15:55:43 -0700
Message-ID: <878uetq5jk.fsf@eliezer.anholt.net>
References: <1426087648-3862-1-git-send-email-eric@anholt.net> <6516096.HanqZ05BXy@vostro.rjw.lan> <CAMuHMdW0_9HNpqYJhJHpDvFcObYZx0MfKT6hmgqjZmwrtpTSzQ@mail.gmail.com> <7hr3sspyj3.fsf@deeprootsystems.com> <CAPDyKFqVwSo=CoppkXTyTOY-wmNsefLq5vSw+CzUCkZ7XDLvsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from gabe.freedesktop.org ([131.252.210.177]:51217 "EHLO
	gabe.freedesktop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751475AbbCRWzr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 18 Mar 2015 18:55:47 -0400
In-Reply-To: <CAPDyKFqVwSo=CoppkXTyTOY-wmNsefLq5vSw+CzUCkZ7XDLvsQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Tomasz Figa <tomasz.figa@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux PM list <linux-pm@vger.kernel.org>

--==-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Ulf Hansson <ulf.hansson@linaro.org> writes:

> On 13 March 2015 at 19:01, Kevin Hilman <khilman@kernel.org> wrote:
>> Geert Uytterhoeven <geert@linux-m68k.org> writes:
>>
>>> On Wed, Mar 11, 2015 at 11:08 PM, Rafael J. Wysocki <rjw@rjwysocki.net>=
 wrote:
>>>> More CCes.
>>>>
>>>> On Wednesday, March 11, 2015 08:27:28 AM Eric Anholt wrote:
>>>>> If we've declared a power domain in the OF, and the OF node is found
>>>>> but the requested domain hasn't been registered on it yet, then we
>>>>> probably have just tried to probe before the power domain driver has.
>>>>> Defer our device's probe until it shows up.
>>>>>
>>>>> Signed-off-by: Eric Anholt <eric@anholt.net>
>>>>
>>>> Kevin, Ulf, any chance to have a look at this, please?
>>>>
>>>>> ---
>>>>>
>>>>> I ran into this when turning my ad-hoc code for BCM2835 (Raspberry Pi)
>>>>> USB poweron support in the DWC2 controller to an OF-based power domain
>>>>> declaration.
>>>
>>> I guess you are initializing the PM domains from module_init()?
>>>
>>> I use core_initcall() in arch/arm/mach-shmobile/pm-rmobile.c to make su=
re it's
>>> initialized earlier, as e.g. the interrupt controller uses postcore_ini=
tcall().
>>
>> Yeah, I think most existing users are initizling PM domains early, but I=
MO
>> we should be working towards supporting PM domains that are created
>> later as well (as this patch does.)
>
> I do agree, that we _should_ allow PM domains to be created later/any
> time. Unfortunate, that's not going to be a simple one-liner patch.
> :-)
>
> To have genpd_dev_pm_attach() return -EPROBE_DEFER, due to that the PM
> domain hasn=E2=80=99t been _initialized_ yet, we need to know whether a PM
> domain exists at all for the device. In principle we need to split the
> work done by genpd_dev_pm_attach() into the two parts described below.
>
> 1.
> At struct device creation time, done from the "OF core", we also need
> to parse for a PM domain node. If such is found, we somehow needs to
> assigned it to the device.
>
> Normally we would have assigned the struct dev_pm_domain in the struct
> device to deal with this, but that has some implications. Currently
> the struct dev_pm_domain is created from SoC specific code and it's
> also done at different init levels.

I haven't made sense of what's actually proposed here, so I'm not
stepping forward to write this.  I think I'd be less confused if the
"struct device" references in the explanation made it clear which ones
were the pm domain controller and which were the pm domain consumer.

--==-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVCgJvAAoJELXWKTbR/J7o6DwP/A4YtoJoQC3iPj0NktA7LDRd
GDnSvZFffxhyUZ7nZzxJ1ZJYJ0/VRLE0BfsqlmxFyoUTCk0M7edXWFZBA8L9cdz6
knqL4fjBQPjL7JrTABsfnYZd0y5sEZyexlGjIKWpTq9xdltZBSCbNhertFhy7/Kk
0/Okz8NJxWpBAPvCKpyvNPRttr9pRqk/jVvWJePuShud5ZE9ZVbQYLk+GTJb3kdz
T59Wud1a3rUEDSAd2ojvzen3pwnixwHH7YhRDjl1vwblBy03Vm3QmyBpQkj3KaNE
FGyC7p3HQnMHDwDLDUM1ZdHR3BBiXRciXSuahVTy6zlQFgy1y4ysuVmPmaEIKS84
u0MHjadzGajipnZMS15NvyNBRBwG/nHPRxQ2qV/1YrDR4Dm6cxbiyrl87tRC66Qy
bDSAbybCmMI6ZEndtG7/dzK/tIExpAzDYwLnjKNB8zEkZdoKQGU4xxZm2WajJcZM
hjrFMmxJlTEPvD8C7aN6r9zbbP5UaOhSkUvZGanXjoVoveDP/iH/pfWzPlJJ/Ylh
GgB6FW6Am79UYLgQf1l3tERfcwO50YOQ/02zhg6aYhltmjca4dRAPhFE4PgWrTl4
U/HDBV4vZDupD6pNIeEQy0sBGTJF5bxFMTeap4r0gkRE5/K+WmBGgnPqKFge/XlS
AsA+m6wFWDblCpun1pF9
=Tmq4
-----END PGP SIGNATURE-----
--==-=-=--
