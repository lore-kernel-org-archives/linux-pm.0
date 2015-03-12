From: Eric Anholt <eric@anholt.net>
Subject: Re: [PATCH] PM / Domains: If an OF node is found but no device probed yet, defer.
Date: Thu, 12 Mar 2015 12:31:54 -0700
Message-ID: <877fumvwph.fsf@eliezer.anholt.net>
References: <1426087648-3862-1-git-send-email-eric@anholt.net> <6516096.HanqZ05BXy@vostro.rjw.lan> <CAMuHMdW0_9HNpqYJhJHpDvFcObYZx0MfKT6hmgqjZmwrtpTSzQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdW0_9HNpqYJhJHpDvFcObYZx0MfKT6hmgqjZmwrtpTSzQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Tomasz Figa <tomasz.figa@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

--=-=-=
Content-Type: text/plain

Geert Uytterhoeven <geert@linux-m68k.org> writes:

> On Wed, Mar 11, 2015 at 11:08 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> More CCes.
>>
>> On Wednesday, March 11, 2015 08:27:28 AM Eric Anholt wrote:
>>> If we've declared a power domain in the OF, and the OF node is found
>>> but the requested domain hasn't been registered on it yet, then we
>>> probably have just tried to probe before the power domain driver has.
>>> Defer our device's probe until it shows up.
>>>
>>> Signed-off-by: Eric Anholt <eric@anholt.net>
>>
>> Kevin, Ulf, any chance to have a look at this, please?
>>
>>> ---
>>>
>>> I ran into this when turning my ad-hoc code for BCM2835 (Raspberry Pi)
>>> USB poweron support in the DWC2 controller to an OF-based power domain
>>> declaration.
>
> I guess you are initializing the PM domains from module_init()?
>
> I use core_initcall() in arch/arm/mach-shmobile/pm-rmobile.c to make sure it's
> initialized earlier, as e.g. the interrupt controller uses postcore_initcall().

Yeah, it's just going through normal DT-based module initialization as a
module_platform_driver().  And it depends on another platform driver
(the mailbox to talk to the firmware in the first place), so it's
unlikely to show up early.

The BCM2835 architecture maintainers don't appear to be fans of fixed
init sequence stuff (our sequence is just bcm2835_setup_restart(),
bcm2835_init_clocks(), of_platform_populate()), and I figured
dependencies expressed in DT were supposed to be the ideal way for
things these days.  I can try turning my drivers into fixed init
sequence code, but I don't expect this to go over well.

>>> drivers/base/power/domain.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
>>> index ba4abbe..2b93c98 100644
>>> --- a/drivers/base/power/domain.c
>>> +++ b/drivers/base/power/domain.c
>>> @@ -2064,7 +2064,7 @@ EXPORT_SYMBOL_GPL(of_genpd_del_provider);
>>>  struct generic_pm_domain *of_genpd_get_from_provider(
>>>                                       struct of_phandle_args *genpdspec)
>>>  {
>>> -     struct generic_pm_domain *genpd = ERR_PTR(-ENOENT);
>>> +     struct generic_pm_domain *genpd = ERR_PTR(-EPROBE_DEFER);
>
> Currently platform_drv_probe() just continues if dev_pm_domain_attach() returns
> a different error than -EPROBE_DEFER, which is what you are seeing.
>
> Your change does have the side effect that a new DT with PM domains won't
> work on an older kernel that doesn't have the PM domain driver yet.
>
> Whether this is a good or a bad thing depends on your bootloader. If all PM
> domains are powered when Linux boots, it can work without PM domain driver.
> Since DT PM domains are quite recent, I guess this is the case for most
> existing SoCs.

The main bootloader doesn't turn on these domains, thus why I wrote a
driver for it (so I could get USB and thus netowrking).  You can
chainload U-Boot and it'll turn it on USB for you, though.

Is there a way we could maybe tell if there's a driver due to try
probing on the node but that hasn't had a chance yet?  That could
mitigate the backwards kernel compat for new DT problem.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVAemrAAoJELXWKTbR/J7oK8wQAKzA2KH69VuNkrkSzxSlcdPP
EWhJuo4qjFmX/VxFnZcotW6DAVmBv7ykBUMWyhRWZhW0oa1q3SDXbhIQouNsAayZ
DT3aF8CCE6dnTJRosxF0uURzpIlJ/naaKlWY7hNvhXzlL58LVzzJ3VRPcl7c38D0
6Rps0G3LPU7yWVvcoK0teaJ3F9qDG7XmAca6fCbIkWiqW2aaVfHbUtsQoJT7j2fR
dU89cFNCQjGMlVSTGj5qQ79F0MpBCqCuwBns2YQxfjAjd4rlqTqQJLrvK8T/cDXH
CGxC+DcviL02AOHZbddClpbTVN/RMgI+NaDLNBXiAz/e3HoC7njlanFteThPi441
ZyOIjtIGSLFBeqTVzP4phTFrbPqyGTFl38xb3xE/h5xyWrXtLz5s6XGBTtM3gxLE
IOp2MLP8pvpBDZdK1c1ppqhZ2A8Wc1+oXIycQGOUQLhjBpeF1oNoEX0hQR6AuWNa
fVpowTI9pFv2YD9l1blaa6HNdFp097B4uwwEdEMikqdyN229Q4B1AjeyM0hWhYdB
15B3ykbJEBFFpMomkzQakr6BUx3wHEO2/F6z7w1FDQBFutBmQ4oeS1ADfRWuipeu
wdiTzcnbUS2I+/E6l5LQC32enyxgimEUn//ORJEcOyshQghj9JnLSeG2iLz/iAib
dQPCW8XC6/+zOmZFYADQ
=wCzf
-----END PGP SIGNATURE-----
--=-=-=--
