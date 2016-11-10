From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v5 2/5] driver core: Functional dependencies tracking support
Date: Thu, 10 Nov 2016 09:46:42 +0100
Message-ID: <CAMuHMdVDUE3=0e580JMorae3-vXxL2m7k28CHQZQuXe13OzZNw@mail.gmail.com>
References: <27296716.H9VWo8ShOm@vostro.rjw.lan> <13957403.ZrB4mMbICz@vostro.rjw.lan>
 <2715729.9U1nlcpFb3@vostro.rjw.lan> <20161026111902.GA6447@wunner.de>
 <20161027152551.GA15718@kroah.com> <20161107212250.GH1764@wotan.suse.de>
 <CAJZ5v0goccDKSkSAj8+v+PG2gt7ESJuUSbyY8YuW7OwCS_KHXg@mail.gmail.com> <CAB=NE6Xdu5AniWsaJGf3pbYCydahwkStqBV+2xbc8S-Zw+2qiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:33320 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751582AbcKJIqo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Nov 2016 03:46:44 -0500
In-Reply-To: <CAB=NE6Xdu5AniWsaJGf3pbYCydahwkStqBV+2xbc8S-Zw+2qiA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Lukas Wunner <lukas@wunner.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Mark Brown <broonie@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Lars-Peter Clausen <lars@metafoo.de>, Grant Likely <grant.likely@secretlab.ca>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrzej Hajda <a.hajda@samsung.com>

On Thu, Nov 10, 2016 at 1:59 AM, Luis R. Rodriguez <mcgrof@kernel.org> wrot=
e:
> On Wed, Nov 9, 2016 at 4:43 PM, Rafael J. Wysocki <rafael@kernel.org> wro=
te:
>> On Mon, Nov 7, 2016 at 10:22 PM, Luis R. Rodriguez <mcgrof@kernel.org> w=
rote:
>>> As clarified by Rafael at Plumbers, this functional dependencies
>>> framework assumes your driver / subsystem supports deferred probe,
>>
>> It isn't particularly clear what you mean by "support" here.
>
> I noted some folks had reported issues, and you acknowledged that if
> deferred probe was used in some drivers and if this created an issue
> the same issue would be seen with this framework. AFAICT there are two
> possible issues to consider:
>
> 1) the one Geert Uytterhoeven noted. Again I'll note what he had mentione=
d [0].
>
>   "Some drivers / subsystems don=E2=80=99t support deferred probe yet, su=
ch failures
>    usually don=E2=80=99t blow up, but cause subtle malfunctioning. Exampl=
e, an Ethernet
>    phy could not get its interrupt as the primary IRQ chip had not been p=
robed
>    yet, it reverted to polling though. Sub-optimal." [0]
>
> [0] https://lists.linuxfoundation.org/pipermail/ksummit-discuss/2016-Augu=
st/003425.html
>
> Geert can you provide more details?

Issue reported in "of_mdiobus_register_phy() and deferred probe"
(http://lkml.iu.edu/hypermail/linux/kernel/1510.2/05770.html)

Key point is:
"However, of_mdiobus_register_phy() uses irq_of_parse_and_map(), which plai=
nly
 ignores EPROBE_DEFER, and it just continues."

At that time, the PHY driver fell back to polling, but as of commit d5c3d84=
65
("net: phy: Avoid polling PHY with PHY_IGNORE_INTERRUPTS") that's no longer=
 the
case, and now the PHY fails to work completely.

Workaround is "[PATCH v2] irqchip/renesas-irqc: Postpone driver initializat=
ion"
(https://www.spinics.net/lists/netdev/msg403325.html), which seems to have
sparked some interest in fixing the issue for good ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
