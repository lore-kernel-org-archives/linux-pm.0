From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] PM / Domains: Make pm_genpd_init() available to modules
Date: Fri, 14 Aug 2015 09:56:32 +0200
Message-ID: <CAMuHMdW2=+sNHFcBHNTGZrVT8Otx-LKyfywzo_q-ep1J1zic+Q@mail.gmail.com>
References: <1439446917-32304-1-git-send-email-rnayak@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f171.google.com ([209.85.214.171]:36789 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751515AbbHNH4d (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 14 Aug 2015 03:56:33 -0400
In-Reply-To: <1439446917-32304-1-git-send-email-rnayak@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rajendra Nayak <rnayak@codeaurora.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Stephen Boyd <sboyd@codeaurora.org>

On Thu, Aug 13, 2015 at 8:21 AM, Rajendra Nayak <rnayak@codeaurora.org> wrote:
> Export symbol pm_genpd_init so it can be used in loadable
> kernel modules
>
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>

Assuming you're aware of the consequences:
  - Modular PM Domain drivers don't work for "critical" devices where the
    driver is started from *OF_DECLARE(),
  - This may depend on "PM / Domains: Return -EPROBE_DEFER if we fail to
    init or turn-on domain" in pm/linux-next
    https://git.kernel.org/cgit/linux/kernel/git/rafael/linux-pm.git/commit/?h=linux-next&id=311fa6adf92c5110057daa439fdaff012864aa2b

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
