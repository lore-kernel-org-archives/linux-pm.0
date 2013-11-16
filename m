From: viresh kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: suspend/resume governors with PM notifiers
Date: Sat, 16 Nov 2013 10:01:50 +0530
Message-ID: <5286F536.70403@linaro.org>
References: <0e476d16e0ae4b001f5dd4f9ac191f899095928a.1384510171.git.viresh.kumar@linaro.org> <5020664.HldDXMO8cr@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <5020664.HldDXMO8cr@vostro.rjw.lan>
Sender: cpufreq-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, tianyu.lan@intel.com, nm@ti.com, jinchoi@broadcom.com, sebastian.capella@linaro.org
List-Id: linux-pm@vger.kernel.org

On Saturday 16 November 2013 05:54 AM, Rafael J. Wysocki wrote:
> Will cpufreq work during system-wide power transitions (suspend/resume etc.)
> after this?  In particular, what about hibernation?

I am disabling governors as soon as we start suspend. So No, cpufreq wouldn't
work during suspend/resume. But once system is resumed we are starting it back
again.

Hibernation is probably not supported by my code yet.. I just went through
hibernation code quickly and it looks we don't send PM_SUSPEND_PREPARE or
PM_POST_SUSPEND notifications in case of hibernation. Correct?

And these are the notifications that we send:
- PM_HIBERNATION_PREPARE
- PM_POST_HIBERNATION
- PM_RESTORE_PREPARE
- PM_POST_RESTORE

If I am not wrong I need to stop governors on PM_HIBERNATION_PREPARE and need to
start them back on: PM_POST_HIBERNATION (I am a bit confused with this one. Does
this POST_HIBERNATION one happens at the end of going into hibernation? or after
booting back? I need a notifier at the end of restore)..

--
viresh
