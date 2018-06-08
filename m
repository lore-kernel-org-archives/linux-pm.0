From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V5] powercap/drivers/idle_injection: Add an idle
 injection framework
Date: Fri, 8 Jun 2018 10:18:39 +0530
Message-ID: <20180608044839.eyaib5gkbw7biu2a@vireshk-i7>
References: <1528190208-22915-1-git-send-email-daniel.lezcano@linaro.org>
 <20180605103917.pyhhcobdvaivqv6g@vireshk-i7>
 <57d769f8-46ea-512e-8f89-a0439c9d053f@linaro.org>
 <20180606042708.mtwd66ecy2cnjp7a@vireshk-i7>
 <2bebd1bc-e1ad-6d22-ad1e-aee2cf8ba878@linaro.org>
 <20180606104528.nhwcd2qnxeouk6il@vireshk-i7>
 <1d542490-fcb5-33fd-ab3b-eddf3d300bd4@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1d542490-fcb5-33fd-ab3b-eddf3d300bd4@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rjw@rjwysocki.net, linux-kernel@vger.kernel.org, Eduardo Valentin <edubezval@gmail.com>, Javi Merino <javi.merino@kernel.org>, Leo Yan <leo.yan@linaro.org>, Kevin Wangtao <kevin.wangtao@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Rui Zhang <rui.zhang@intel.com>, Daniel Thompson <daniel.thompson@linaro.org>, "open list:POWER MANAGEMENT CORE" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 07-06-18, 16:11, Daniel Lezcano wrote:
> >> I'm wondering if we can have a CPU hotplugged right after the
> >> 'put_online_cpus', resulting in the 'should park' flag set and then the
> >> thread goes in the kthread_parkme instead of jumping back the idle
> >> injection function and decrease the count, leading up to the timer not
> >> being set again.
> > 
> > True. That looks like a valid problem to me as well.
> > 
> > What about starting the hrtimer right from this routine itself, after taking
> > into account running-time, idle-time, delay, etc ? That would get rid of the
> > count stuff, this get_online_cpus(), etc.
> > 
> > Even if we restart the next play-idle cycle a bit early or with some delay, sky
> > wouldn't fall :)
> 
> We won't be able to call completion() in this case.

I was just having a look at smpboot.h and saw the park/unpark callbacks. I think
you can very much use them to align things with CPU hotplug.

-- 
viresh
