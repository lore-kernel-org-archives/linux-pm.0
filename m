From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: Find transition latency dynamically
Date: Fri, 30 Jun 2017 09:28:44 +0530
Message-ID: <20170630035844.GW29665@vireshk-i7>
References: <8041a965fcca71231576ae77a141b1e4333a81cc.1496402967.git.viresh.kumar@linaro.org>
 <20170629042836.GI29665@vireshk-i7>
 <CAJZ5v0gOq-XPcXFfbycQkWzobBktoH5=eLxYAdh_G33fu8L1cg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gOq-XPcXFfbycQkWzobBktoH5=eLxYAdh_G33fu8L1cg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>
List-Id: linux-pm@vger.kernel.org

On 29-06-17, 22:34, Rafael J. Wysocki wrote:
> Shouldn't drivers do that really?

Well they can, but the we will have some sort of code duplication
then. Or else we can provide a helper for them to find this value
dynamically and that would be fine too. And maybe we can add a
callback for the cpufreq-driver, which can be filled by the generic
helper and core can call it once at policy initialization time.

-- 
viresh
