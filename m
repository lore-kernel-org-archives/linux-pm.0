From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] MIPS: Loongson 2F: fix broken build due incorrect
 includes
Date: Mon, 13 Jul 2015 08:00:32 +0530
Message-ID: <20150713023032.GB10415@linux>
References: <1436537377-7138-1-git-send-email-aaro.koskinen@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:33606 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751522AbbGMCaj (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 12 Jul 2015 22:30:39 -0400
Received: by pdbqm3 with SMTP id qm3so71529245pdb.0
        for <linux-pm@vger.kernel.org>; Sun, 12 Jul 2015 19:30:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1436537377-7138-1-git-send-email-aaro.koskinen@iki.fi>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Ralf Baechle <ralf@linux-mips.org>, Huacai Chen <chenhc@lemote.com>, linux-mips@linux-mips.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org

On 10-07-15, 17:09, Aaro Koskinen wrote:
> Commit 30ad29bb4888 ("MIPS: Loongson: Naming style cleanup and rework")
> renamed mach-loongson to mach-loongson64. Some files are including
> loongson.h using the asm/mach-loongson directory name, so the build
> got broken. Fix by removing the directory name; the mach directory
> is automatically in the include path.
> 
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>

Fixes: 30ad29bb4888 ("MIPS: Loongson: Naming style cleanup and rework")

> ---
>  arch/mips/loongson64/lemote-2f/clock.c | 2 +-
>  drivers/cpufreq/loongson2_cpufreq.c    | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
