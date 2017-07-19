From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] selftests: cpufreq: Check cpuinfo_cur_freq set as expected
Date: Wed, 19 Jul 2017 14:47:30 +0200
Message-ID: <3568375.ceg5RryLQe@aspire.rjw.lan>
References: <704cfb6696840b3838576ea583b8ab8ed2265aaf.1499858779.git.leonard.crestez@nxp.com> <1500406459.11874.1.camel@nxp.com> <20170719065406.GE352@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170719065406.GE352@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Leonard Crestez <leonard.crestez@nxp.com>, Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org, Octavian Purdila <octavian.purdila@nxp.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wednesday, July 19, 2017 12:24:06 PM Viresh Kumar wrote:
> On 18-07-17, 22:34, Leonard Crestez wrote:
> > The semantics of scaling_cur_freq and cpuinfo_cur_freq are not very
> > clear to me.
> 
> cpuinfo_cur_freq reads the frequency right from hardware all the time
> and so can be slow. It can only be read by root if I remember
> correctly.
> 
> Whereas scaling_cur_freq tries to read the cached frequency. But it
> has changed a bit with the below mentioned patch.
> 
> > In my particular case I need to check cpuinfo_cur_freq because this is
> > what ends up returning the rate of the arm clk. Otherwise
> > scaling_cur_freq just returns policy->cur
> 
> Yeah, we may actually need to use cpuinfo_cur_freq as that is what
> ends up giving the real freq.
> 
> > unless the driver has a
> > setpolicy function (I don't understand that condition).
> 
> That's because the core doesn't know the cached freq for setpolicy
> drivers and so we need to call the ->get() callback. But for non
> setpolicy drivers, core already has the cached value.

Please remember that cpuinfo_cur_freq may not be present.

Thanks,
Rafael
