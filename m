From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V4 2/3] cpufreq: add support for intermediate (stable) frequencies
Date: Fri, 30 May 2014 06:49:48 +0530
Message-ID: <CAKohpomOuB102EDgTLsd0jqA9Fr_cn53LAL8FyAtRErpcsPu6A@mail.gmail.com>
References: <cover.1400662383.git.viresh.kumar@linaro.org>
	<59e1185a31e61c428aca9f4b8f0a69f182ee458e.1400662383.git.viresh.kumar@linaro.org>
	<CAD=FV=WpYRHaydJnu-+Be9V5ab2qLrA7Wz-9Z_QaG97XJhrhfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAD=FV=WpYRHaydJnu-+Be9V5ab2qLrA7Wz-9Z_QaG97XJhrhfg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Doug Anderson <dianders@chromium.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Arvind Chauhan <arvind.chauhan@arm.com>, Stephen Warren <swarren@nvidia.com>, Russell King <linux@arm.linux.org.uk>, Nicolas Pitre <nicolas.pitre@linaro.org>, Thomas Abraham <thomas.abraham@linaro.org>, Peter De Schrijver <pdeschrijver@nvidia.com>
List-Id: linux-pm@vger.kernel.org

On 29 May 2014 01:10, Doug Anderson <dianders@chromium.org> wrote:
> As far as I can tell this notification says "I tried to switch from
> "intermediate_freq" to "policy->restore_freq" but I failed, so I'm
> still at "intermediate_freq".  I think you probably want to pass 0 as
> the last argument to cpufreq_freq_transition_end() to fix...

Correct !!

> Other than that this looks good to me.  I'll do a final review when
> you spin the next version (since I think you need to fix stuff for
> Stephen too).  I'll probably wait and re-review the Tegra version when
> you and Stephen come to a consensus on it.

I am waiting for Stephen's reply on the other thread to close this issue.
