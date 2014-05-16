From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 0/3] cpufreq: add support for intermediate (stable)
Date: Fri, 16 May 2014 15:40:43 +0530
Message-ID: <CAKohpokUP6rnV=UyES1GY0yqwiUndBrJFtw7fwJScsRigbE7tA@mail.gmail.com>
References: <cover.1400230695.git.viresh.kumar@linaro.org>
	<CAJuA9aitMu_=OLT+=6pX=us03HVfrPZ1zCYFXfNg58W+-nzm3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJuA9aitMu_=OLT+=6pX=us03HVfrPZ1zCYFXfNg58W+-nzm3g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Abraham <ta.omasab@gmail.com>
Cc: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Stephen Warren <swarren@nvidia.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Peter De Schrijver <pdeschrijver@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Doug Anderson <dianders@chromium.org>, Thomas Abraham <thomas.abraham@linaro.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Arvind Chauhan <arvind.chauhan@arm.com>
List-Id: linux-pm@vger.kernel.org

On 16 May 2014 15:39, Thomas Abraham <ta.omasab@gmail.com> wrote:
> In the given example above, the reworked implementation of cpufreq for
> exynos maintains the transition frequency at 800MHz / 4 = 200MHz by
> using a clock divider. So the transition frequency is ensured to be
> less than or equal to the pre-transition cpu clock frequency.

Thanks for the information. But I think this patchset is still required for
many platforms. Anyway these extra notifications must be sent for exynos
as well.
