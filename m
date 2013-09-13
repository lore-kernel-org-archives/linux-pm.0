From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 206/228] cpufreq: sa11x0: remove calls to cpufreq_notify_transition()
Date: Fri, 13 Sep 2013 21:52:31 +0530
Message-ID: <CAKohpomBdAgciTYnQPn6fKC7iHvuBxFLiK8kCz62q7jRHhXK1A@mail.gmail.com>
References: <cover.1379063063.git.viresh.kumar@linaro.org>
	<6e2ca86ce948c0bc35f7709baf22672771fcf1e8.1379063063.git.viresh.kumar@linaro.org>
	<20130913155424.GB12758@n2100.arm.linux.org.uk>
	<CAKohpomAj0wDnjdi7XXw=bGsu0LMRrr1SMwdzBsa0GTxGrABoQ@mail.gmail.com>
	<20130913161527.GE12758@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <20130913161527.GE12758@n2100.arm.linux.org.uk>
Sender: cpufreq-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Patch Tracking <patches@linaro.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On 13 September 2013 21:45, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> The patch to which I'm replying removes the above calls.  These calls are
> necessary to shutdown various bits of CPU-clock dependent hardware
> before changing the CPU clock, and restore them - reconfiguring them
> for the new clock rate after the transition has happened.
>
> So, if you're removing these calls, what replaces them?  I don't see
> anything which does without the above set.

The other patch on which you commented about unnecessary read
locks being taken:

[PATCH 181/228] cpufreq: move freq change notifications to cpufreq

That calls these notifiers, for all platforms except the ones that have
set CPUFREQ_ASYNC_NOTIFICATION, before and after calling
->target_index()..

And so functionally the code is supposed to be the same.. Unless I
have done some stupid mistake..
