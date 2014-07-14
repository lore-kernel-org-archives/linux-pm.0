From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2] cpufreq: Don't destroy/realloc policy/sysfs on hotplug/suspend
Date: Mon, 14 Jul 2014 11:43:24 +0530
Message-ID: <CAKohpokdvtPj7jg88mon+EnHRCbUF7nqFWvmkFEMVh5WRzSS5A@mail.gmail.com>
References: <1404959850-11617-1-git-send-email-skannan@codeaurora.org>
	<1405052287-4744-1-git-send-email-skannan@codeaurora.org>
	<CAKohponB9feyh50p+dL5hyU1ffHAzHU59G-sYCrCm1AbHQe9hw@mail.gmail.com>
	<53C0A648.9080909@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <53C0A648.9080909@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Saravana Kannan <skannan@codeaurora.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Todd Poynor <toddpoynor@google.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Stephen Boyd <sboyd@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

On 12 July 2014 08:36, Saravana Kannan <skannan@codeaurora.org> wrote:
> On 07/10/2014 11:19 PM, Viresh Kumar wrote:
>
>>
>> Please make sure you take care of these issues:
>> - suspend/resume
>> - hotplug
>> - module insert/remove
>
> Ok, I was just at the current code. Does cpufreq_unregister_driver() even
> really work correctly as it stands?
>
> It doesn't even seem to stop any of the governors/policies before it just
> set the cpufreq_driver pointer to NULL.
>
> So, technically my v2 patch doesn't even make anything worse when it comes
> to unregistering the cpufreq driver.

Are you really sure about this? I have tested this *myself* earlier..

subsys_interface_unregister() should take care of stopping/freeing governor
stuff..
