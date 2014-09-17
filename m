From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [RFC PATCH 0/3] PM / clock_ops: allow to specify custom
 pm_clk_notifier callback
Date: Wed, 17 Sep 2014 17:03:03 +0200
Message-ID: <CAMuHMdUJzXNep14ny24R=FhA4WzsWU9401ZU-nnZ_CkkJqxSsA@mail.gmail.com>
References: <1406313096-29761-1-git-send-email-grygorii.strashko@ti.com>
	<7hr3zln692.fsf@linaro.org>
	<540F0381.7010500@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:56035 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754363AbaIQPDG (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 17 Sep 2014 11:03:06 -0400
In-Reply-To: <540F0381.7010500@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Kevin Hilman <khilman@linaro.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Geert Uytterhoeven <geert+renesas@glider.be>, Linux PM list <linux-pm@vger.kernel.org>, Ben Dooks <ben.dooks@codethink.co.uk>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Grant Likely <grant.likely@secretlab.ca>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>

Hi Grygorii,

On Tue, Sep 9, 2014 at 3:41 PM, Grygorii Strashko
<grygorii.strashko@ti.com> wrote:
>> Since you're essentially gutting clock_ops, have you considered
>> migrating to genpd and having your own pm_domain ops that manage your clocks?
>
> Yes. I've thought about using genpd. But:
> - PM domain is not merged in 3.17 and I don't know if it will be merged in 3.18 :(
> http://www.spinics.net/lists/arm-kernel/msg357003.html

Let's wait and see...

> - To switch using PM domains I will need to create PM domain node PER EACH device,
> (if I understand PM domain bindings right). For example:
>
> +power_netcp: power-controller@0 {
> +               compatible = "keystone,power-controller";
> +               #power-domain-cells = <0>;
> +               clocks = <&clkcpgmac>, <&clkpa>, <&chipclk12>;
> +       };
>
> netcp: netcp@2090000 {
>                 reg = <0x2620110 0x8>;
> +               power-domains = <&power_netcp>;
> ...
> }

I think you can have one power-controller, and add the clocks and
power-domains properties to the individual device nodes.

Then the power-controller driver can use the attach callback
introduced in "[PATCH/RFC v2 04/12] PM / Domains: Add genpd attach/detach
callbacks" (https://lkml.org/lkml/2014/9/16/429) to set up the clocks?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
