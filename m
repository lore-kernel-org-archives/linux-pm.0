From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] cpuidle: add maintainer entry
Date: Thu, 25 Apr 2013 18:32:08 +0200
Message-ID: <51795A88.6020608@linaro.org>
References: <1366810463-17495-1-git-send-email-daniel.lezcano@linaro.org> <51781B48.30208@gmail.com> <5178D0EF.3090004@linaro.org> <CAKohpo=Ct7WCBSOqmgk8asVyXWa5o+jqpTwaQgxKVm_XNLfnMA@mail.gmail.com> <5178D5EF.9090102@linaro.org> <CAL_Jsq+o1kF2GJNX5a01B9nPcq6uVLbpC-3RirU2uJAZ8C-jUg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f48.google.com ([74.125.82.48]:47541 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755786Ab3DYQcN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 25 Apr 2013 12:32:13 -0400
Received: by mail-wg0-f48.google.com with SMTP id f11so1561486wgh.15
        for <linux-pm@vger.kernel.org>; Thu, 25 Apr 2013 09:32:11 -0700 (PDT)
In-Reply-To: <CAL_Jsq+o1kF2GJNX5a01B9nPcq6uVLbpC-3RirU2uJAZ8C-jUg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, rjw@sisk.pl, Andrew Lunn <andrew@lunn.ch>, khilman@deeprootsystems.com, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linus Walleij <linus.walleij@linaro.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Paul Mackerras <paulus@samba.org>, josephl@nvidia.com, Kukjin Kim <kgene.kim@samsung.com>, Stephen Warren <swarren@wwwdotorg.org>, magnus.damm@gmail.com, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, lenb@kernel.org, linaro-kernel@lists.linaro.org, Jason Cooper <jason@lakedaemon.net>, Arnd Bergmann <arnd@arndb.de>, linux-pm@vger.kernel.org, nsekhar@ti.com, Rob Herring <rob.herring@calxeda.com>, horms@verge.net.au, ben-linux@fluff.org, horms+renesas@verge.net.au, linux@maxim.org.za, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, kernel@pengutronix.de

On 04/25/2013 05:50 PM, Rob Herring wrote:
> On Thu, Apr 25, 2013 at 2:06 AM, Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>> On 04/25/2013 08:49 AM, Viresh Kumar wrote:
>>> On 25 April 2013 12:15, Daniel Lezcano <daniel.lezcano@linaro.org> =
wrote:
>>>> On 04/24/2013 07:50 PM, Rob Herring wrote:
>>>
>>>>> Shouldn't MAINTAINERS contain the driver maintainers too?
>>>>
>>>> It should contains the upstream maintainer for the subsystem, and
>>>> optionally a co-maintainer.
>>>>
>>>> The MAINTAINERS file gives informations about the patch submission=
 path.
>>>>
>>>> The file's header should contain the maintainer of the driver, so =
the
>>>> submitted patches will go to the subsystem maintainer for upstream=
ing
>>>> and to the driver maintainer for acked-by.
>>>>
>>>> If you add an entry in MAINTAINERS like:
>>>>
>>>> ARM/CALXEDA HIGHBANK ARCHITECTURE
>>>> M:      Rob Herring <rob.herring@calxeda.com>
>>>> L:      linux-arm-kernel@lists.infradead.org (moderated for non-su=
bscribers)
>>>> S:      Maintained
>>>> F:      arch/arm/mach-highbank/
>>>> +F:     drivers/cpuidle/cpuidle-calxeda.c
>>>>
>>>> That will add confusion while we are trying to clarify the situati=
on
>>>> with a single entry point for the patches submission. If someone w=
ants
>>>> to submit a patch for this driver, it will look at the MAINTAINERS=
 file
>>>> and won't know if it should send the patch against arm-soc or linu=
x-pm.
>>>
>>> I though otherwise. We can add entry in MAINTAINERS for any module.
>>> Module can be a framework/architecture or a single driver.
>>
>> IMO, there are too much drivers for that. It is simpler for someone =
to
>> read the MAINTAINERS file to find the cpuidle drivers goes through
>> linux-pm. I think we can trust Rafael to ask for the acked-by from t=
he
>> maintainer of the driver before taking the patches.
>=20
> It not a maintainer's job to solicit acks. It is the submitter's job
> to Cc the correct people. The maintainer should only check for
> necessary CC/acks and bitch at the submitter if they did not use
> get_maintainers.pl.

Ok, I was saying exactly the same, but it was misphrased.
I meant, we can be confident Rafael won't accept patches if they are no=
t
acked by the correct people.

> Perhaps the MAINTAINERS file needs to be distributed to scale better
> or we need a way to put the maintainer data into the source and be
> usable by get_maintainers.pl.

Yep, the latter could be a good idea.

>>> Adding entry for cpuidle driver of a architecture as you wrote for =
calxeda is
>>> wrong as it adds to confusion and so there should be a separate ent=
ry for
>>> this driver rather than merging it with arch/ entries.
>>
>> Yes, actually it was an example to show the confusion we could be fa=
cing.
>=20
> I'm confused about what is the confusion...



--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

