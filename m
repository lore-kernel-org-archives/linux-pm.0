From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 6/6] arm64: renesas: r8a7795: Add L2 cache-controller nodes
Date: Tue, 15 Dec 2015 09:45:06 +0100
Message-ID: <CAMuHMdWELqMQ+CCENsGtdBx7n_YV=D6pJpo02jeQRe67jEehyQ@mail.gmail.com>
References: <1449512659-16688-1-git-send-email-geert+renesas@glider.be>
	<1449512659-16688-7-git-send-email-geert+renesas@glider.be>
	<5665D4C7.1050705@arm.com>
	<20151207190355.GE28024@leverpostej>
	<CAMuHMdWrXiYkcFwSkgbEfQRXvT2FsSTbqD72vtiedmeEZZKxLg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdWrXiYkcFwSkgbEfQRXvT2FsSTbqD72vtiedmeEZZKxLg@mail.gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Lina Iyer <lina.iyer@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Mark,

On Mon, Dec 7, 2015 at 9:18 PM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Mon, Dec 7, 2015 at 8:03 PM, Mark Rutland <mark.rutland@arm.com> wrote:
>> On Mon, Dec 07, 2015 at 06:49:43PM +0000, Sudeep Holla wrote:
>>> On 07/12/15 18:24, Geert Uytterhoeven wrote:
>>> >+    L2_CA57: cache-controller@0 {
>>> >+            compatible = "cache";
>>> >+            arm,data-latency = <4 4 1>;
>>> >+            arm,tag-latency = <3 3 3>;
>>>
>>> Interesting, only PL2xx/3xx cache controller driver reads this from the
>>> DT and configures the controller. The integrated L2 found in
>>> A15/A7/A57/A53 needs doesn't make use of these values from the DT.
>>
>> These properties seem to be from l2cc.txt, which really only corresponds
>> to PL210/PL220/PL310 (and variants) and isn't as generic as it sounds.
>>
>> I don't see that these are necessary at all.
>
> The datasheet does mention the data/tag RAM latencies/setup values, so
> I put them in DT using the properties I could fine.

Furthermore these values are different for different SoCs in the same family
(e.g. r8a7790 vs. other R-Car Gen2 members), even though they seem to
have the same Cortex-A15 cores.

So to me these look like properties we want to document in the DTS...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
