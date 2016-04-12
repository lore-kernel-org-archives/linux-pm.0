From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/5] cpufreq: Loongson1: Replace kzalloc() with kcalloc()
Date: Tue, 12 Apr 2016 10:48:09 +0530
Message-ID: <20160412051809.GP16238@vireshk-i7>
References: <1460375759-20705-1-git-send-email-keguang.zhang@gmail.com>
 <1460375759-20705-2-git-send-email-keguang.zhang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f169.google.com ([209.85.192.169]:33193 "EHLO
	mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755583AbcDLFSN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 12 Apr 2016 01:18:13 -0400
Received: by mail-pf0-f169.google.com with SMTP id 184so6717112pff.0
        for <linux-pm@vger.kernel.org>; Mon, 11 Apr 2016 22:18:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1460375759-20705-2-git-send-email-keguang.zhang@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Keguang Zhang <keguang.zhang@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-mips@linux-mips.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>

On 11-04-16, 19:55, Keguang Zhang wrote:
> From: Kelvin Cheung <keguang.zhang@gmail.com>
> 
> This patch replaces kzalloc() with kcalloc() when allocating
> frequency table, and remove unnecessary 'out of memory' message.
> 
> Signed-off-by: Kelvin Cheung <keguang.zhang@gmail.com>
> ---
>  drivers/cpufreq/loongson1-cpufreq.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
