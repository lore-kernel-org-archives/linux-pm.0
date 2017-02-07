From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 3/4] cpufreq: bmips-cpufreq: CPUfreq driver for
 Broadcom's BMIPS SoCs
Date: Tue, 7 Feb 2017 09:49:32 +0530
Message-ID: <20170207041932.GO3131@vireshk-i7>
References: <20170206215119.87099-1-code@mmayer.net>
 <20170206215119.87099-4-code@mmayer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f41.google.com ([74.125.83.41]:34186 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751809AbdBGETf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Feb 2017 23:19:35 -0500
Received: by mail-pg0-f41.google.com with SMTP id 14so34696114pgg.1
        for <linux-pm@vger.kernel.org>; Mon, 06 Feb 2017 20:19:35 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20170206215119.87099-4-code@mmayer.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Markus Mayer <code@mmayer.net>
Cc: Ralf Baechle <ralf@linux-mips.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Markus Mayer <mmayer@broadcom.com>, MIPS Linux Kernel List <linux-mips@linux-mips.org>, Power Management List <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 06-02-17, 13:51, Markus Mayer wrote:
> From: Markus Mayer <mmayer@broadcom.com>
> 
> Add the MIPS CPUfreq driver. This driver currently supports CPUfreq on
> BMIPS5xxx-based SoCs.
> 
> Signed-off-by: Markus Mayer <mmayer@broadcom.com>
> ---
>  drivers/cpufreq/Kconfig         |  10 +++
>  drivers/cpufreq/Makefile        |   1 +
>  drivers/cpufreq/bmips-cpufreq.c | 195 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 206 insertions(+)
>  create mode 100644 drivers/cpufreq/bmips-cpufreq.c

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
