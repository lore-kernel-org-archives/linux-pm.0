From: Meelis Roos <mroos@linux.ee>
Subject: Re: 4.14 regression - hang on shutdown (VIA longhaul related?)
Date: Mon, 27 Nov 2017 17:19:39 +0200 (EET)
Message-ID: <alpine.LRH.2.21.1711271719260.27709@math.ut.ee>
References: <alpine.LRH.2.21.1711241741080.10361@math.ut.ee> <CAJZ5v0h34pcz5Xpo-Yaj+Jnth7_GZ6G0gydAOR_hCPx-0h2-dw@mail.gmail.com> <alpine.LRH.2.21.1711271630290.27709@math.ut.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LRH.2.21.1711271630290.27709@math.ut.ee>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

> > Please try to replace the 10000 in
> > cpufreq_policy_transition_delay_us() with a greater number (say 20000
> > or 50000) and see if that helps.
> 
> With 50000 it has worked 4 reboots out of 4.

With 20000, it also seems to work 3 out of 3 times.

-- 
Meelis Roos (mroos@linux.ee)
