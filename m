From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: Fix NULL reference crash while accessing
 policy->governor_data
Date: Thu, 28 Jan 2016 07:45:53 +0530
Message-ID: <20160128021553.GC3935@vireshk>
References: <1297c8fc8135f8b5359f9c49d220a939c0ee640e.1453741314.git.viresh.kumar@linaro.org>
 <3004241.yqvZmcL5vE@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3004241.yqvZmcL5vE@vostro.rjw.lan>
Sender: stable-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, "# v4 . 2+" <stable@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 27-01-16, 23:54, Rafael J. Wysocki wrote:
> So I've applied this, but I'm not sure it is sufficient yet.

At least, this solves the crash Juri was hitting on a multi cluster
box.

> Have you double checked whether or not stuff cannot be reordered by
> the CPU and/or the compiler and no additional memory barriers are needed?

I don't think CPU will reorder things before a function call. It can
reorder lines, which CPU thinks aren't related but it can't assume the
same in this case. We have tons of code like this.

@Juri: What do you say? 

-- 
viresh
