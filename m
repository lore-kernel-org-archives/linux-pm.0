From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [PATCH] cpufreq: Set CPUFREQ_ASYNC_NOTIFICATION for drivers handling
 notification
Date: Fri, 25 Apr 2014 13:52:51 +0530
Message-ID: <535A1B5B.9000705@linux.vnet.ibm.com>
References: <c6c53fee017018869c7524a487688edf902c1413.1398412138.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <c6c53fee017018869c7524a487688edf902c1413.1398412138.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rjw@rjwysocki.net, mroos@linux.ee, linaro-kernel@lists.linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 04/25/2014 01:22 PM, Viresh Kumar wrote:
> CPUFREQ_ASYNC_NOTIFICATION was initially designed for drivers which don't want
> core to send notifications for them as they wouldn't finish frequency
> transitions in ->target_index().
>

And let's keep it that way. Overloading ASYNC_NOTIFICATION with other meanings
is a bad idea.
 
> But there were other kinds of drivers as well who don't have straight forward
> implementations of ->target_index() routines and wanted to handle notifications
> themselves.
> 

Looking at longhaul, powernow-k6 and powernow-k7, I think we can safely remove
the extra notifications from them and let them depend on the cpufreq core's set
of notifications. The patchset I posted just now uses that design.

Regards,
Srivatsa S. Bhat
