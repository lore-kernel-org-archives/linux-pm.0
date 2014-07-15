From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2] cpufreq: Don't destroy/realloc policy/sysfs on hotplug/suspend
Date: Tue, 15 Jul 2014 11:22:40 +0530
Message-ID: <CAKohpo=y4KiTrTxvacyN7cbuaOJBXa-hyg+kmyV7V-0nCRZkkg@mail.gmail.com>
References: <1404959850-11617-1-git-send-email-skannan@codeaurora.org>
	<1405052287-4744-1-git-send-email-skannan@codeaurora.org>
	<CAKohponB9feyh50p+dL5hyU1ffHAzHU59G-sYCrCm1AbHQe9hw@mail.gmail.com>
	<2f549e6e4871ccf2a94dd4c8872c7a0b.squirrel@www.codeaurora.org>
	<CAKohpokhmj1OkCRj=X+Q7eYiun8fsqD2dpEt66VKYnqo3dENVA@mail.gmail.com>
	<53C0A12A.2060204@codeaurora.org>
	<CAKohpon9en_VnSx+CVydPsWBHtArvmazn0hrodrRJt9jgOa0-g@mail.gmail.com>
	<53C42AA8.8010107@codeaurora.org>
	<CAKohpomkqbHZo9KrJMSwsEKGt6+Ac2Fg2X0+S7ZAo=OzhAc45g@mail.gmail.com>
	<53C4BDFB.70707@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <53C4BDFB.70707@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Saravana Kannan <skannan@codeaurora.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Todd Poynor <toddpoynor@google.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Stephen Boyd <sboyd@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

On 15 July 2014 11:06, Saravana Kannan <skannan@codeaurora.org> wrote:
> Btw, I tried to take a stab at removing any assumption in cpufreq code about
> policy->cpu being ONLINE. There are 160 instances of those of with 23 are in
> cpufreq.c
>
> So, even if we are sure cpufreq.c is fine, it's 137 other uses spread across
> all the other files. I definitely don't want to try and fix those as part of
> this patch. Way too risky and hard to get the test coverage it would need.
> Even some of the acpi cpufreq drivers seem to be making this assumption.

Hmm, yeah that would be an issue. So this is what you should do now:
- Left policy->cpu as it is, i.e. updated only when policy->cpu goes down.
- Just make sure sysfs nodes are untouched when any cpu goes down

> Btw, I think v3 is done. I did some testing and it was fine. But made some
> minor changes. Will test tomorrow to make sure I didn't break anything with
> the minor changes and then send them out.

Ok, just comply to the above comments.
