From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [1/2] arm64: dts: r8a7795: add thermal cooling management
Date: Wed, 3 Jan 2018 11:25:37 +0100
Message-ID: <CAMuHMdWf76hNbQva_z9-2bCbBiGfA-veK9GdCqTyThaiBsNpMQ@mail.gmail.com>
References: <20170913105909.13230-2-niklas.soderlund+renesas@ragnatech.se>
 <20180101181333.GA3631@localhost.localdomain> <20180102091944.py647jheghud7sl2@verge.net.au>
 <20180103000352.GB22490@bigcity.dyn.berto.se> <20180103101438.il5grrfihewiduqe@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qt0-f196.google.com ([209.85.216.196]:45749 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752193AbeACKZi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 3 Jan 2018 05:25:38 -0500
In-Reply-To: <20180103101438.il5grrfihewiduqe@verge.net.au>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>, Eduardo Valentin <edubezval@gmail.com>, Linux PM list <linux-pm@vger.kernel.org>, devicetree@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>

Hi Simon,

On Wed, Jan 3, 2018 at 11:14 AM, Simon Horman <horms@verge.net.au> wrote:
> On Wed, Jan 03, 2018 at 01:03:52AM +0100, Niklas S=C3=B6derlund wrote:
>> On 2018-01-02 10:19:44 +0100, Simon Horman wrote:
>> > On Mon, Jan 01, 2018 at 10:13:35AM -0800, Eduardo Valentin wrote:
>> > > On Wed, Sep 13, 2017 at 12:59:08PM +0200, Niklas S=C3=B6derlund wrot=
e:
>> > > > Add nodes and properties for thermal cooling management support.
>> > > >
>> > > > Signed-off-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@rag=
natech.se>
>> > > > ---
>> > >
>> > > Just a reminder, this series should go via your arch tree. You may a=
dd
>> > > my acks.
>> >
>> > Ack.
>> >
>> > Niklas, could you comment on the readiness of these patches
>> > for the renesas tree?
>>
>> I think maybe the patches might have became a bit outdated since they
>> where posted due to all reg property fixup patches. The blocker for me
>> reposting this series is that the patches this depends
>> 'topic/rcar-gen3-cpufreq' on are not yet in the renesas tree next or
>> devel branches. Do you think it would be valuable for me to refresh
>> these patches before the dependencies are picked up?
>
> Probably not. I'll try to work on getting cpufreq upstream :)

I think it's working fine in renesas-drivers, isn't it?

As in the mean time the R-Car Gen3 CPG/MSSR drivers gained suspend/resume
support, the only missing part is support for restoring the Z* clocks durin=
g
system resume.  Unless that is handled automatically by the cpufreq core.
For secondary CPU cores, this may be handled by the CPU hotplug code.
For the primary CPU core, I don't know.

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
