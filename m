From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 02/22 v2] cpufreq/acpi-cpufreq: drop rdmsr_on_cpus() usage
Date: Mon, 28 Nov 2016 15:24:30 +0530
Message-ID: <20161128095430.GB3288@vireshk-i7>
References: <20161126231350.10321-1-bigeasy@linutronix.de>
 <20161126231350.10321-3-bigeasy@linutronix.de>
 <20161128095203.ls4wovz5taos7qxf@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f51.google.com ([74.125.83.51]:36041 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932508AbcK1Jyi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Nov 2016 04:54:38 -0500
Received: by mail-pg0-f51.google.com with SMTP id f188so55303396pgc.3
        for <linux-pm@vger.kernel.org>; Mon, 28 Nov 2016 01:54:33 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20161128095203.ls4wovz5taos7qxf@linutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, rt@linutronix.de, tglx@linutronix.de, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org

On 28-11-16, 10:52, Sebastian Andrzej Siewior wrote:
> The online / pre_down callback is invoked on the target CPU since commit
> 1cf4f629d9d2 ("cpu/hotplug: Move online calls to hotplugged cpu") which means
> for the hotplug callback we can use rmdsrl() instead of rdmsr_on_cpus().
> 
> This leaves us with set_boost() as the only user which still needs to
> read/write the MSR on different CPUs. There is no point in doing that
> update on all cpus with the read modify write magic via per cpu data. We
> simply can issue a function call on all online CPUs which also means that we
> need half that many IPIs.
> 
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
> v1…v2: rebase ontop of the previous patch.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
