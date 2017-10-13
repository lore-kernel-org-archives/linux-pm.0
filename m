From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH/RFC 3/5] mfd: bd9571mwv: Allow DDR Backup Power register
 access
Date: Fri, 13 Oct 2017 10:56:09 +0100
Message-ID: <20171013095609.7ievqlwa2e4pnuge@dell>
References: <1507649178-31473-1-git-send-email-geert+renesas@glider.be>
 <1507649178-31473-4-git-send-email-geert+renesas@glider.be>
 <20171013085851.ljvgmyd6ei2tv5fw@dell>
 <CAMuHMdVZiaq40r0Su01n9C7oXR7i_QWmNhZtY7Udhy9gdYHVRA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:50683 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756122AbdJMJ4N (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 13 Oct 2017 05:56:13 -0400
Received: by mail-wm0-f50.google.com with SMTP id u138so19939837wmu.5
        for <linux-pm@vger.kernel.org>; Fri, 13 Oct 2017 02:56:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAMuHMdVZiaq40r0Su01n9C7oXR7i_QWmNhZtY7Udhy9gdYHVRA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Marek Vasut <marek.vasut+renesas@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Fri, 13 Oct 2017, Geert Uytterhoeven wrote:

> Hi Lee,
> 
> On Fri, Oct 13, 2017 at 10:58 AM, Lee Jones <lee.jones@linaro.org> wrote:
> > On Tue, 10 Oct 2017, Geert Uytterhoeven wrote:
> >
> >> Enable read/write access to the BD9571MWV_BKUP_MODE_CNT register, which
> >> is a.o. used to configure DDR Backup Power.
> >
> > a.o.?  That's a new one on me.
> 
> among(st) others

Please just write that instead. :)

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
