From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] PM / Domains: Move dev_pm_domain_attach|detach() to pm_domain.h
Date: Mon, 29 Sep 2014 14:33:07 +0200
Message-ID: <CAMuHMdU4=bOaJs3Hrx0h9X08vF651dL4U3Xn8qUM9fNHe75MXw@mail.gmail.com>
References: <1411991927-19654-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-la0-f53.google.com ([209.85.215.53]:33511 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751601AbaI2MdL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 29 Sep 2014 08:33:11 -0400
Received: by mail-la0-f53.google.com with SMTP id gq15so161732lab.26
        for <linux-pm@vger.kernel.org>; Mon, 29 Sep 2014 05:33:08 -0700 (PDT)
In-Reply-To: <1411991927-19654-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Linux PM list <linux-pm@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Kevin Hilman <khilman@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, Philipp Zabel <philipp.zabel@gmail.com>, Russell King <linux@arm.linux.org.uk>, Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Mon, Sep 29, 2014 at 1:58 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> The commit below, started using errno values in pm.h header file. It
> also failed to include the header for these, thus it caused compiler
> errors.
>
> 46420dd73b800f87a19af13af5883855cf38cb08
> (PM / Domains: Add APIs to attach/detach a PM domain for a device)
>
> Instead of including the errno header to pm.h, let's move the functions
> to pm_domain.h, since it's a better match.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
