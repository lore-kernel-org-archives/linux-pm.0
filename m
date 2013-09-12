From: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>
Subject: Re: [PATCH 0/4] cpufreq: fixes for v3.12
Date: Thu, 12 Sep 2013 09:18:00 +0100
Message-ID: <523178B8.8020806@arm.com>
References: <1378835989-19281-1-git-send-email-Sudeep.KarkadaNagesha@arm.com> <1795989.18GOYqdUtX@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1795989.18GOYqdUtX@vostro.rjw.lan>
Sender: cpufreq-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>, Shawn Guo <shawn.guo@linaro.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On 11/09/13 23:58, Rafael J. Wysocki wrote:
> On Tuesday, September 10, 2013 06:59:45 PM Sudeep KarkadaNagesha wrote:
>> From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
>>
>> Hi Shawn, Guennadi,
>>
>> These are the fixes for the issue reported by Guennadi.
>> cpu_dev should point to cpu0 device instead of cpufreq-cpu0 platform
>> devices. The dev_id is also updated while registering the cpu clocks.
>>
>> Can you review these ? Tested-by is much appreciated as I don't
>> have hardware to check the fix.
> 
> I have a little problem with this series, because the last patch is based
> on the current Linus' tree rather than on my master branch which is what
> I have ready to push.  I don't think it makes sense to rebase it, however,
> because that would introduce a merge conflict for Linus unnecessarily.
> 
> To avoid merging stuff back and forth, I'll push this series later in the
> cycle.
> 

Thanks Rafael.
Let me know in case if you need me to rebase onto your branch.

Regards,
Sudeep


