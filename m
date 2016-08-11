From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] PM / Domains: Always enable debugfs support if available
Date: Thu, 11 Aug 2016 13:14:04 +0200
Message-ID: <CAMuHMdVPMeQC-M-2tj+r0hSR+Jp16Juim+JGaEWgODAjB3UaGg@mail.gmail.com>
References: <1470912005-10914-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:34367 "EHLO
	mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751862AbcHKLOF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 11 Aug 2016 07:14:05 -0400
In-Reply-To: <1470912005-10914-1-git-send-email-jonathanh@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jon Hunter <jonathanh@nvidia.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Thu, Aug 11, 2016 at 12:40 PM, Jon Hunter <jonathanh@nvidia.com> wrote:
> Debugfs support for PM domains is only enabled if both CONFIG_PM_DEBUG
> and CONFIG_PM_ADVANCED_DEBUG are enabled. CONFIG_PM_ADVANCED_DEBUG is
> described as "extra PM attributes in sysfs for low-level
> debugging/testing" which does not seem related.
>
> Given that the debugfs for PM domains only allows users to view the
> state of the PM domains, always enable debugfs support for PM domains
> if PM domains and debugfs support is enabled.
>
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
