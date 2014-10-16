From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [PATCH 6/6] cpufreq: Loongson1: Add cpufreq driver for
 Loongson1B (UPDATED)
Date: Thu, 16 Oct 2014 21:03:55 +0300
Message-ID: <20141016180355.GA14194@drone.musicnaut.iki.fi>
References: <1413357812-16895-1-git-send-email-keguang.zhang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from filtteri2.pp.htv.fi ([213.243.153.185]:46137 "EHLO
	filtteri2.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751309AbaJPSEF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 16 Oct 2014 14:04:05 -0400
Content-Disposition: inline
In-Reply-To: <1413357812-16895-1-git-send-email-keguang.zhang@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kelvin Cheung <keguang.zhang@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-mips@linux-mips.org, ralf@linux-mips.org

Hi,

On Wed, Oct 15, 2014 at 03:23:32PM +0800, Kelvin Cheung wrote:
> This patch adds cpufreq driver for Loongson1B which
> is capable of changing the CPU frequency dynamically.
> 
> Signed-off-by: Kelvin Cheung <keguang.zhang@gmail.com>

[...]

>  obj-$(CONFIG_LOONGSON2_CPUFREQ)		+= loongson2_cpufreq.o
> +obj-$(CONFIG_LOONGSON1_CPUFREQ)		+= ls1x-cpufreq.o

Why it's called "ls1x-cpufreq" instead of "loongson1_cpufreq"?

A.
