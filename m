From: David C Niemi <dniemi@verisign.com>
Subject: Re: [PATCH linux-next] cpufreq: conservative: Fix sampling_down_factor
 functionality
Date: Tue, 05 Mar 2013 09:21:04 -0500
Message-ID: <5135FF50.4020001@verisign.com>
References: <51351CC3.4010301@semaphore.gr> <CAOh2x=m0KLbjGKvLvTH7-yQb4SU5-v=-r4Ba3LSZz=NvfvO6mg@mail.gmail.com> <51358117.9060902@semaphore.gr> <5135FD01.8060306@verisign.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <5135FD01.8060306@verisign.com>
Sender: cpufreq-owner@vger.kernel.org
To: Stratos Karafotis <stratosk@semaphore.gr>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


I should clarify -- I wrote the sampling_down_factor in the *ondemand* governor.  I chose the name of the parameter based on the vaguely similar parameter in the conservative governor, but the documentation that was referenced (about it only applying at top speed and the comment about skipping evaluation opportunities when it is active) was written by me in reference to the ondemand governor.  It could be that someone backported some of the ondemand sampling_down_factor's behavior to the conservative governor.

I'd like to ask -- what is the intended use of the conservative governor these days as differentiated from the ondemand governor?  At one time it seemed more oriented towards power savings, but the ondemand governor had picked up most or all of its power-saving features.

DCN

On 03/05/13 09:11, David C Niemi wrote:
> I am the author of sampling_down_factor.  I only intended it to have an effect if you are already attempting to achieve maximum performance (e.g. at the top available clock speed for the current infrastructure).  This is special because there is no possibility of going any faster so the only speed change you can think about is slowing down, which is typically much less urgent than speeding up.  So I did not see sampling_down_factor as being relevant at intermediate frequencies, though perhaps there could be something interesting but opposite to do at the minimum-power state too.
>
> In the applications this was originally intended for you were likely to either be idle and trying to save power (but be ready to ramp up quickly), or at max speed, and rarely in between.  sampling_down_factor made a dramatic improvement in performance, to the point there was no longer any reason to use the "performance" governor.
>
> I suspect the rationale for sampling_down_factor would apply to non-frequency-based governor/driver combos as well, like the p-state driver, though in that case you are not necessarily changing a literal clock speed and you also have additional opportunities like turbo/boost states to consider.  But in some applications, you may not want to use boost states that cannot be sustained when all cores are active, so there is more user/operator intent that must be communicated to the governor.
>
> DCN

