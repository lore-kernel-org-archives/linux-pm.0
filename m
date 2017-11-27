From: Meelis Roos <mroos@linux.ee>
Subject: Re: 4.14 regression - hang on shutdown (VIA longhaul related?)
Date: Mon, 27 Nov 2017 16:31:24 +0200 (EET)
Message-ID: <alpine.LRH.2.21.1711271630290.27709@math.ut.ee>
References: <alpine.LRH.2.21.1711241741080.10361@math.ut.ee> <CAJZ5v0h34pcz5Xpo-Yaj+Jnth7_GZ6G0gydAOR_hCPx-0h2-dw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp1.it.da.ut.ee ([193.40.5.66]:45426 "EHLO smtp1.it.da.ut.ee"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752369AbdK0Ob2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 27 Nov 2017 09:31:28 -0500
In-Reply-To: <CAJZ5v0h34pcz5Xpo-Yaj+Jnth7_GZ6G0gydAOR_hCPx-0h2-dw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel list <linux-kernel@vger.kernel.org>

> Please try to replace the 10000 in
> cpufreq_policy_transition_delay_us() with a greater number (say 20000
> or 50000) and see if that helps.

With 50000 it has worked 4 reboots out of 4.

-- 
Meelis Roos (mroos@linux.ee)
