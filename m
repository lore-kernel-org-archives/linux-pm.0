From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 6/6] cpufreq: Loongson1: Add cpufreq driver for Loongson1B (UPDATED)
Date: Fri, 17 Oct 2014 10:16:11 +0530
Message-ID: <CAKohpomjWt8fKU9=bT5fva+Qr_vJBg0cMWH1WcDFp_1NneV+qQ@mail.gmail.com>
References: <1413357812-16895-1-git-send-email-keguang.zhang@gmail.com>
	<20141016180355.GA14194@drone.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f171.google.com ([209.85.214.171]:62688 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750851AbaJQEqM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 17 Oct 2014 00:46:12 -0400
Received: by mail-ob0-f171.google.com with SMTP id va2so45031obc.30
        for <linux-pm@vger.kernel.org>; Thu, 16 Oct 2014 21:46:11 -0700 (PDT)
In-Reply-To: <20141016180355.GA14194@drone.musicnaut.iki.fi>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Kelvin Cheung <keguang.zhang@gmail.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>

On 16 October 2014 23:33, Aaro Koskinen <aaro.koskinen@iki.fi> wrote:
> Why it's called "ls1x-cpufreq" instead of "loongson1_cpufreq"?

This is what Kelvin told me when I asked him the same query:

Other drivers of loongson1 are already named *ls1x*, such as
clk-ls1x.c and rtc-ls1x.c.
So I just keep pace with them.
