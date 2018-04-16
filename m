From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v3 6/7] thermal/drivers/cpu_cooling: Introduce the cpu
 idle cooling driver
Date: Mon, 16 Apr 2018 15:20:06 +0530
Message-ID: <20180416095006.GC4244@vireshk-i7>
References: <1522945005-7165-1-git-send-email-daniel.lezcano@linaro.org>
 <1522945005-7165-7-git-send-email-daniel.lezcano@linaro.org>
 <3f3b3b7a-3b74-aee2-2fac-f2759babe3f0@arm.com>
 <939f7943-feec-aaa2-3bd3-59a6618330c0@linaro.org>
 <20180416073729.GA4244@vireshk-i7>
 <0a3164f9-4738-e24e-6ed0-2c75024c304c@linaro.org>
 <20180416093747.GB4244@vireshk-i7>
 <4abf0d97-d2b8-46ab-3c05-4a11510ac3fe@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4abf0d97-d2b8-46ab-3c05-4a11510ac3fe@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, edubezval@gmail.com, kevin.wangtao@linaro.org, leo.yan@linaro.org, vincent.guittot@linaro.org, linux-kernel@vger.kernel.org, javi.merino@kernel.org, rui.zhang@intel.com, daniel.thompson@linaro.org, linux-pm@vger.kernel.org, Amit Daniel Kachhap <amit.kachhap@gmail.com>
List-Id: linux-pm@vger.kernel.org

On 16-04-18, 11:45, Daniel Lezcano wrote:
> Can you elaborate a bit ? I'm not sure to get the point.

Sure. With your current code on Hikey960 (big/LITTLE), you end up
creating two cooling devices, one for the big cluster and one for
small cluster. Which is the right thing to do, as we also have two
cpufreq cooling devices.

But with the change Sudeep is referring to, the helper you used to get
cluster id will return 0 (SoC id) for all the 8 CPUs. So your code
will end up creating a single cpuidle cooling device for all the CPUs.
Which would be wrong.

> BTW, Am I asked to change my code to stick to something which is not
> merged ?

Sudeep looked pretty confident on how the meaning of this routine is
going to change very soon. I will let him respond on what guarantees
we have that it will get merged :)

-- 
viresh
