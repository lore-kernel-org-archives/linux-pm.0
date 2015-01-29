From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 1/2] PM: Update function header for dev_pm_get_subsys_data()
Date: Thu, 29 Jan 2015 18:44:41 +0100
Message-ID: <CAMuHMdVm3jXrMT6zfk_pCAZNf=cBBUX9sQZhZUJ-UKnqN+PbGw@mail.gmail.com>
References: <1422553145-14798-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f169.google.com ([209.85.217.169]:46245 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753623AbbA2Ron (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 29 Jan 2015 12:44:43 -0500
Received: by mail-lb0-f169.google.com with SMTP id f15so30807787lbj.0
        for <linux-pm@vger.kernel.org>; Thu, 29 Jan 2015 09:44:41 -0800 (PST)
In-Reply-To: <1422553145-14798-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Linux PM list <linux-pm@vger.kernel.org>, Kevin Hilman <khilman@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>

On Thu, Jan 29, 2015 at 6:39 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> The commit "PM: Make dev_pm_get_subsys_data() always return 0 on success"
> changed the return value from dev_pm_get_subsys_data(). Let's update the
> comment in the function header to reflect this change as well.
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
