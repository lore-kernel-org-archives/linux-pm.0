From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 01/22 v2] cpufreq/acpi-cpufreq: Convert to hotplug state
 machine
Date: Mon, 28 Nov 2016 15:24:11 +0530
Message-ID: <20161128095411.GA3288@vireshk-i7>
References: <20161126231350.10321-1-bigeasy@linutronix.de>
 <20161126231350.10321-2-bigeasy@linutronix.de>
 <20161128051520.GA9104@vireshk-i7>
 <20161128094908.o6f4itwnj4gssv46@linutronix.de>
 <20161128095101.psbseghv463lws76@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f175.google.com ([209.85.192.175]:32812 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932413AbcK1Jyh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Nov 2016 04:54:37 -0500
Received: by mail-pf0-f175.google.com with SMTP id d2so24330511pfd.0
        for <linux-pm@vger.kernel.org>; Mon, 28 Nov 2016 01:54:15 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20161128095101.psbseghv463lws76@linutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, rt@linutronix.de

On 28-11-16, 10:51, Sebastian Andrzej Siewior wrote:
> Install the callbacks via the state machine.
> 
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
> v1…v2: set msrs to NULL on error during init.
> 
>  drivers/cpufreq/acpi-cpufreq.c |   92 ++++++++++++++++++++---------------------
>  1 file changed, 45 insertions(+), 47 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
