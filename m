From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] PM / Domains: If an OF node is found but no device probed
 yet, defer.
Date: Mon, 16 Mar 2015 11:12:25 +0100
Message-ID: <CAPDyKFqVwSo=CoppkXTyTOY-wmNsefLq5vSw+CzUCkZ7XDLvsQ@mail.gmail.com>
References: <1426087648-3862-1-git-send-email-eric@anholt.net>
	<6516096.HanqZ05BXy@vostro.rjw.lan>
	<CAMuHMdW0_9HNpqYJhJHpDvFcObYZx0MfKT6hmgqjZmwrtpTSzQ@mail.gmail.com>
	<7hr3sspyj3.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qc0-f178.google.com ([209.85.216.178]:34386 "EHLO
	mail-qc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751430AbbCPKM0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 16 Mar 2015 06:12:26 -0400
Received: by qcaz10 with SMTP id z10so38837010qca.1
        for <linux-pm@vger.kernel.org>; Mon, 16 Mar 2015 03:12:25 -0700 (PDT)
In-Reply-To: <7hr3sspyj3.fsf@deeprootsystems.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kevin Hilman <khilman@kernel.org>, Eric Anholt <eric@anholt.net>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Tomasz Figa <tomasz.figa@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux PM list <linux-pm@vger.kernel.org>

On 13 March 2015 at 19:01, Kevin Hilman <khilman@kernel.org> wrote:
> Geert Uytterhoeven <geert@linux-m68k.org> writes:
>
>> On Wed, Mar 11, 2015 at 11:08 PM, Rafael J. Wysocki <rjw@rjwysocki.n=
et> wrote:
>>> More CCes.
>>>
>>> On Wednesday, March 11, 2015 08:27:28 AM Eric Anholt wrote:
>>>> If we've declared a power domain in the OF, and the OF node is fou=
nd
>>>> but the requested domain hasn't been registered on it yet, then we
>>>> probably have just tried to probe before the power domain driver h=
as.
>>>> Defer our device's probe until it shows up.
>>>>
>>>> Signed-off-by: Eric Anholt <eric@anholt.net>
>>>
>>> Kevin, Ulf, any chance to have a look at this, please?
>>>
>>>> ---
>>>>
>>>> I ran into this when turning my ad-hoc code for BCM2835 (Raspberry=
 Pi)
>>>> USB poweron support in the DWC2 controller to an OF-based power do=
main
>>>> declaration.
>>
>> I guess you are initializing the PM domains from module_init()?
>>
>> I use core_initcall() in arch/arm/mach-shmobile/pm-rmobile.c to make=
 sure it's
>> initialized earlier, as e.g. the interrupt controller uses postcore_=
initcall().
>
> Yeah, I think most existing users are initizling PM domains early, bu=
t IMO
> we should be working towards supporting PM domains that are created
> later as well (as this patch does.)

I do agree, that we _should_ allow PM domains to be created later/any
time. Unfortunate, that's not going to be a simple one-liner patch.
:-)

To have genpd_dev_pm_attach() return -EPROBE_DEFER, due to that the PM
domain hasn=E2=80=99t been _initialized_ yet, we need to know whether a=
 PM
domain exists at all for the device. In principle we need to split the
work done by genpd_dev_pm_attach() into the two parts described below.

1.
At struct device creation time, done from the "OF core", we also need
to parse for a PM domain node. If such is found, we somehow needs to
assigned it to the device.

Normally we would have assigned the struct dev_pm_domain in the struct
device to deal with this, but that has some implications. Currently
the struct dev_pm_domain is created from SoC specific code and it's
also done at different init levels.

2. At ->probe(), genpd shall return -EPROBE_DEFER, if the device's
assigned PM domain hasn=E2=80=99t been initialized yet.

Implementing 2) should be trivial, but 1) could be a bit harder.
Anyway, if anyone want to have a stab on it, I will gladly review such
patches.

Kind regards
Uffe

>
>>>> drivers/base/power/domain.c | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/base/power/domain.c b/drivers/base/power/doma=
in.c
>>>> index ba4abbe..2b93c98 100644
>>>> --- a/drivers/base/power/domain.c
>>>> +++ b/drivers/base/power/domain.c
>>>> @@ -2064,7 +2064,7 @@ EXPORT_SYMBOL_GPL(of_genpd_del_provider);
>>>>  struct generic_pm_domain *of_genpd_get_from_provider(
>>>>                                       struct of_phandle_args *genp=
dspec)
>>>>  {
>>>> -     struct generic_pm_domain *genpd =3D ERR_PTR(-ENOENT);
>>>> +     struct generic_pm_domain *genpd =3D ERR_PTR(-EPROBE_DEFER);
>>
>> Currently platform_drv_probe() just continues if dev_pm_domain_attac=
h() returns
>> a different error than -EPROBE_DEFER, which is what you are seeing.
>>
>> Your change does have the side effect that a new DT with PM domains =
won't
>> work on an older kernel that doesn't have the PM domain driver yet.
>
> Is that a real problem though?  Using newer DTs on older kernels can
> cause many types of problems.
>
> Kevin
