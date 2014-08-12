From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v4 3/5] cpufreq: Don't destroy/realloc policy/sysfs on hotplug/suspend
Date: Tue, 12 Aug 2014 14:47:43 +0530
Message-ID: <CAKohpokBE=r0oxF9Y-Cmu2HuLHnwKV4w+kFays=WY8TwD93oFw@mail.gmail.com>
References: <1406250448-470-1-git-send-email-skannan@codeaurora.org>
	<1406250448-470-4-git-send-email-skannan@codeaurora.org>
	<3141717.0s1tLjazMZ@vostro.rjw.lan>
	<CAKohpo=QrZBmFoWq0hBRBDUbP=AiyTRjnTtJ1R5q_r=dhBO3Og@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <CAKohpo=QrZBmFoWq0hBRBDUbP=AiyTRjnTtJ1R5q_r=dhBO3Og@mail.gmail.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Saravana Kannan <skannan@codeaurora.org>, Todd Poynor <toddpoynor@google.com>, "Srivatsa S . Bhat" <srivatsa@mit.edu>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Stephen Boyd <sboyd@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

On 7 August 2014 16:21, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 1 August 2014 03:26, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> I'm still quite unsure how this is going to work with the real CPU hot-remove
>> that makes the entire sysfs cpu directories go away.  Can you please explain
>> that?
>
> I have little less knowledge on this kind of hotplugs, can you please enlighten
> me with some info about this?
>
> Are we talking about big servers which are actually a combination of multiple
> motherboards (with SoC's), and any motherboard can be plugged out at
> run time. Obviously a single kernel would be running for all these motherboards.
>
> I don't know if we already support that.. Sorry for my lack of
> knowledge on this..

Ping!!
