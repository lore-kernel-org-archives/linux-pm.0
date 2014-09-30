From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: cpufreq dir under /sys/devices/system/cpu/cpu* is not present for
 online=0 cpus
Date: Tue, 30 Sep 2014 15:30:53 +0530
Message-ID: <CAOh2x=mPzecwxi_SQx0gN2BDrNhLRMiPWYVHV9+wV9g8sbQb9Q@mail.gmail.com>
References: <loom.20140923T164259-12@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <loom.20140923T164259-12@post.gmane.org>
Sender: cpufreq-owner@vger.kernel.org
To: Ragu <raguramanmm@gmail.com>
Cc: "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Sep 23, 2014 at 8:19 PM, Ragu <raguramanmm@gmail.com> wrote:
> I am learning android and finding that the cpufreq dir under
> /sys/devices/system/cpu/cpu* is not present when online=0 for a cpu. Why are
> we hiding those directory and its content when a cpu goes offline/power
> collapse ?
>
> Because of the above, the cpu usage is not very accurate from some tools
> which reads data from sysfs.

These were removed because the CPU isn't online anymore and so we shouldn't
be able to change its frequency from userspace.

But probably this behavior can be changed to mark cpufreq directory and its
file as read-only in that case.

But that is some work to do..
