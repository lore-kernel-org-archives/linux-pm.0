From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v3 1/7] PM / Domains: Add DT bindings for the R-Car System Controller
Date: Thu, 10 Mar 2016 09:21:19 +0100
Message-ID: <CAMuHMdWYPYHwn3GgPvqqXkJg0+8wGOxkcbEhMyx5thGsnU3D6A@mail.gmail.com>
References: <1457551122-21838-1-git-send-email-geert+renesas@glider.be>
	<1457551122-21838-2-git-send-email-geert+renesas@glider.be>
	<5264125.Rrtl9KtOQy@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <5264125.Rrtl9KtOQy@avalon>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Simon Horman <horms+renesas@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, linux-renesas-soc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu, Mar 10, 2016 at 3:24 AM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Wednesday 09 March 2016 20:18:36 Geert Uytterhoeven wrote:
>> The Renesas R-Car System Controller provides power management for the
>> CPU cores and various coprocessors, following the generic PM domain
>> bindings in Documentation/devicetree/bindings/power/power_domain.txt.
>>
>> This supports R-Car Gen1 (H1), Gen2, and Gen3.
>>
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

>> +++ b/Documentation/devicetree/bindings/power/renesas,rcar-sysc.txt
>> @@ -0,0 +1,48 @@
>> +DT bindings for the Renesas R-Car System Controller
>> +
>> +== System Controller Node ==
>> +
>> +The R-Car System Controller provides power management for the CPU cores and
>> +various coprocessors.
>> +
>> +Required properties:
>> +  - compatible: Must contain one or more of the following:
>
> I'd be curious to see a use case for specifying more than one ;-) I think you
> can phrase it as "Must contain exactly one of the following".

Thanks, that was a leftover of the previous version. Will fix.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
