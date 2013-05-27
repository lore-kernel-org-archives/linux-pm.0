From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC v2 0/3][TESTS] LAB: Support for Legacy Application Booster governor - tests results
Date: Mon, 27 May 2013 21:48:51 +0200
Message-ID: <41528879.GuKxJgVhIe@vostro.rjw.lan>
References: <1367590072-10496-1-git-send-email-jonghwa3.lee@samsung.com> <8856294.KaD55h4g0a@vostro.rjw.lan> <CAKohpom4sSwJG7r67+aNMjAdr7CToAqCbdcbd+vSCTEQkiTkcg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAKohpom4sSwJG7r67+aNMjAdr7CToAqCbdcbd+vSCTEQkiTkcg@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Lukasz Majewski <l.majewski@samsung.com>, Jonghwa Lee <jonghwa3.lee@samsung.com>, linux-kernel@vger.kernel.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Vicent Guittot <vincent.guittot@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>
List-Id: linux-pm@vger.kernel.org

On Monday, May 27, 2013 06:54:49 PM Viresh Kumar wrote:
> On 27 May 2013 17:30, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > Well, this really looks like software turbo modes, so let's call them
> > "TURBO" instead of "OVERDRIVE"
> 
> Yes, it looks better.
> 
> > and I seem to remember having a switch for
> > disabling/enabling turbo modes already.
> 
> This was added in intel_pstate driver and shows up in
> /sys/devices/system/cpu/cpufreq/ directory..
> 
> But this feature belongs to a governor instance and so
> will be present inside governor directory..
> 
> Specially for big LITTLE we want it to be per policy
> specific. So may need to add a new one.

I was talking about /sys/devices/system/cpu/cpufreq/boost that appears to
have been added by commit 615b730 (acpi-cpufreq: Add support for disabling
dynamic overclocking).

That's in acpi-cpufreq, but since that setting seems to be generally useful,
it may be a good idea to move it to the core somehow.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
