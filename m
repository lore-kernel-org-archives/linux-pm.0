From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: Don't destroy/realloc policy/sysfs on hotplug/suspend
Date: Thu, 17 Jul 2014 00:02:49 +0200
Message-ID: <16164926.ZsJxe6UV3e@vostro.rjw.lan>
References: <1404959850-11617-1-git-send-email-skannan@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1404959850-11617-1-git-send-email-skannan@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Saravana Kannan <skannan@codeaurora.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Todd Poynor <toddpoynor@google.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Wednesday, July 09, 2014 07:37:30 PM Saravana Kannan wrote:
> Preliminary patch. Not tested. Just sending out to give an idea of what I'm
> looking to do. Expect a lot more simplification when it's done.
> 
> Benefits:
> * A lot more simpler code.
> * Less stability issues.
> * Suspend/resume time would improve.
> * Hotplug time would improve.
> * Sysfs file permissions would be maintained.
> * More policy settings would be maintained across suspend/resume.
> * cpufreq stats would be maintained across hotplug for all CPUs.

One problem.  The real hotplug (when the CPU actually goes away) depends on
offline removing all that stuff for it.  How are you going to address that?

Rafael
