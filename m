From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 0/6] ARM: shmobile: sh73a0: DT PM domain support
Date: Fri, 16 Jan 2015 10:51:29 +0100
Message-ID: <CAMuHMdU4hj2p-N8abT-BSadznqF7=0-08o9F4_7+qjdvv6Whmw@mail.gmail.com>
References: <1421237484-16847-1-git-send-email-geert+renesas@glider.be>
	<20150114235302.GC10479@verge.net.au>
	<CAMuHMdVANePZ-fLzaLCEOm0vHR735C=u5_fDa4Uywi_P5ggjBg@mail.gmail.com>
	<20150116011315.GA7830@verge.net.au>
	<20150116024724.GA31654@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-la0-f44.google.com ([209.85.215.44]:34407 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750965AbbAPJvb (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 16 Jan 2015 04:51:31 -0500
In-Reply-To: <20150116024724.GA31654@verge.net.au>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, Linux-sh list <linux-sh@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

Hi Simon,

On Fri, Jan 16, 2015 at 3:47 AM, Simon Horman <horms@verge.net.au> wrote:
> On Fri, Jan 16, 2015 at 10:13:15AM +0900, Simon Horman wrote:
>> On Thu, Jan 15, 2015 at 10:32:23AM +0100, Geert Uytterhoeven wrote:
>> > On Thu, Jan 15, 2015 at 12:53 AM, Simon Horman <horms@verge.net.au> wrote:
>> > > On Wed, Jan 14, 2015 at 01:11:18PM +0100, Geert Uytterhoeven wrote:
>> > >> This patch series enables DT support for PM domains on the Renesas
>> > >> SH-Mobile AG5 (sh73a0) SoC.
>> > >>
>> > >> This series builds further on the DT PM Domain support for R-Mobile A1
>> > >> (r8a7740).  Due to the similarity of the SYSC System-Controller on the
>> > >> various SH-Mobile/R-Mobile SoCs, and the abstraction of PM domains in
>> > >> DT, the same driver can handle sh73a0 after some small modifications,
>> > >> without changing the DT bindings.
>> > >>
>> > >> Compared to r8a7740, the only significant change is the move of the
>> > >> memory-controller(s) to separate PM domains on sh73a0 (and also on
>> > >> R-Mobile APE6 (r8a73a4)). Hence a provision must be made to not turn off
>> > >> these PM domains inadvertently, cfr. the series "[PATCH 0/4] ARM:
>> > >> shmobile: Add DT support for memory controllers" I've just sent.
>> > >>
>> > >> This series has been sent before, as part of the series "[PATCH RFC
>> > >> 0/7] ARM: shmobile: sh73a0: DT PM domain support"
>> > >> (https://lkml.org/lkml/2014/11/19/404).
>> > >> Changes since v1 (more detailed changelogs in the individual patches):
>> > >>   - Factored out addition of the memory-controller in a separate
>> > >>     series.
>> > >>
>> > >> Dependencies:
>> > >>   1. Patches 1-4 (DT binding doc, C code) depend on:
>> > >>        a. The R-Mobile DT PM Domain work for r8a7740, queued in tag
>> > >>           renesas-dt-pm-for-v3.20 of Simon's repository,
>> > >
>> > > In response to a request from Olof renesas-dt-pm-for-v3.20 has been
>> > > withdrawn and the patches split between the soc-for-v3.20 and dt-for-v3.20
>> > > branches. I am assuming that the patches that 1-4 depend on are
>> > > now all in the soc-for-v3.20 branch. Could you check?
>> >
>> > OK, soc-for-v3.20 now.
>> >
>> > >>        b. "ARM: shmobile: R-Mobile: Fix DT refcount bugs in PM domain
>> > >>          code"
>> > >>          (http://www.spinics.net/lists/arm-kernel/msg391084.html),
>> > >
>> > > FWIW, I have squashed that patch into the patch that adds the problem
>> > > and the result is in the soc-for-v3.20. I will to push that result
>> > > a little later today.
>> >
>> > Thanks!
>> >
>> > >>   2. Patch 5 (dtsi) depends on:
>> > >>        a. The multiplatform work for sh73a0, queued in branch
>> > >>           sh73a0-multiplatform-for-v3.20 of Simon's repository,
>> > >>        b. Series "[PATCH 0/4] ARM: shmobile: Add DT support for memory
>> > >>           controllers"
>> > >>         (http://marc.info/?l=linux-sh&m=142123399414888).
>> > >
>> > > This may be awkward to get into v3.20 unless we can adopt a looser approach
>> > > to the dependencies.

> Please take a look at renesas-next-20150115-v3.19-rc1.

s/20150115/20150116/?

> This series should be queued-up there.

If you add patch 6 to sh-drivers-for-v3.20 and merge it in -next,
everything is fine!

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
