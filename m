From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 9/9] Revert "PM / Domains: Power on the PM domain right
 after attach completes"
Date: Mon, 16 Mar 2015 10:07:24 +0100
Message-ID: <CAMuHMdXYt8JwaUg1DPey7DTqGS_oOKDDeCOu5ojnQns8822TFA@mail.gmail.com>
References: <1426261429-31883-1-git-send-email-ulf.hansson@linaro.org>
	<1426261429-31883-10-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f175.google.com ([209.85.214.175]:35957 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751345AbbCPJHY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 16 Mar 2015 05:07:24 -0400
Received: by obdfc2 with SMTP id fc2so30807237obd.3
        for <linux-pm@vger.kernel.org>; Mon, 16 Mar 2015 02:07:24 -0700 (PDT)
In-Reply-To: <1426261429-31883-10-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Kevin Hilman <khilman@linaro.org>, Linux PM list <linux-pm@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Fri, Mar 13, 2015 at 4:43 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> Due to the invent of dev_pm_domain_get|put() API and related code in the
> generic PM domain, we can now safely revert this commit.

... revert commit 2ed127697eb13766 ("PM / Domains: Power on the PM domain
right after attach completes").

So not everyone has to look for the commit ID.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
