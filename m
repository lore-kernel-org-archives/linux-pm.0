From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] Add ability for PXA2xx CPUFreq to be compiled as a module
 or, not at all
Date: Tue, 25 Nov 2014 16:35:27 +0530
Message-ID: <CAOh2x==+amATsYbASxr8D6z5x3UOxySLY_kNXzDvoSB4_tycAA@mail.gmail.com>
References: <5472AD1E.8010005@tul.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qc0-f172.google.com ([209.85.216.172]:52924 "EHLO
	mail-qc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752431AbaKYLF2 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 25 Nov 2014 06:05:28 -0500
Received: by mail-qc0-f172.google.com with SMTP id m20so196633qcx.17
        for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2014 03:05:27 -0800 (PST)
In-Reply-To: <5472AD1E.8010005@tul.cz>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Petr Cvek <petr.cvek@tul.cz>
Cc: Linux PM list <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Mon, Nov 24, 2014 at 9:29 AM, Petr Cvek <petr.cvek@tul.cz> wrote:
> Add ability for PXA2xx CPUFreq to be compiled as a module or not at all.
>
> Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
> ---
>  drivers/cpufreq/Kconfig.arm | 8 ++++++++
>  drivers/cpufreq/Makefile    | 3 +--
>  2 files changed, 9 insertions(+), 2 deletions(-)

Make sure you cc Maintainers to get quick responses.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
