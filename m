From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH RFC v2 07/16] arm: domain: Synchronize CPU device runtime
 PM usage with idle state
Date: Mon, 29 Jun 2015 15:13:58 +0200
Message-ID: <CAMuHMdUkhhde52TLH78Y1FOo=BjkjvAmxjQoMAdtrOiUgrR2UQ@mail.gmail.com>
References: <1435374156-19214-1-git-send-email-lina.iyer@linaro.org>
	<1435374156-19214-8-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f49.google.com ([209.85.218.49]:36579 "EHLO
	mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753026AbbF2NN7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 29 Jun 2015 09:13:59 -0400
Received: by oigb199 with SMTP id b199so117494946oig.3
        for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2015 06:13:59 -0700 (PDT)
In-Reply-To: <1435374156-19214-8-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@linaro.org>, =?UTF-8?Q?Krzysztof_Koz=C5=82owski?= <k.kozlowski@samsung.com>, Linux PM list <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, msivasub@codeaurora.org, agross@codeaurora.org

On Sat, Jun 27, 2015 at 5:02 AM, Lina Iyer <lina.iyer@linaro.org> wrote:
> When a CPU is running, the runtime PM usage count should be incremented
> and decremented when the CPU is powers down. To ensure that this happens

powered down

> correctly, increment the runtime usage from that CPU.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
