From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [RFC 0/9] cpufreq: schedutil: Allow remote wakeups
Date: Thu, 16 Mar 2017 11:04:37 +0100
Message-ID: <CAJZ5v0jD4gjJiCnUvSTPJPcp4aECGVZM0FzSbdFjXVsf4F7J8g@mail.gmail.com>
References: <cover.1489058244.git.viresh.kumar@linaro.org> <4261790.UfzOU18DRK@aspire.rjw.lan>
 <20170316030916.GA5201@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170316030916.GA5201@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Steve Muckle <smuckle.linux@gmail.com>, Juri Lelli <juri.lelli@arm.com>, Morten Rasmussen <Morten.Rasmussen@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, eas-dev@lists.linaro.org
List-Id: linux-pm@vger.kernel.org

On Thu, Mar 16, 2017 at 4:09 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 15-03-17, 12:45, Rafael J. Wysocki wrote:
>> From the first quick look patches [1-3/9] seem to be split out somewhat
>> artificially.
>>
>> Any chance to fold them into the patches where the new stuff is actually used?
>>
>> I'll be looking at the rest of the patchset shortly.
>
> I thought it would be better to keep them separate, but I can merge them to
> others in the next version if you want.

Yes, it is kind of more convenient to see how they are used right away.

Otherwise I need to look at two patches at the same time which is a
pain on some machine form factors. :-)

Thanks,
Rafael
