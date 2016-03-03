From: Steve Muckle <steve.muckle@linaro.org>
Subject: Re: [RFCv7 PATCH 04/10] sched/fair: add triggers for OPP change
 requests
Date: Wed, 2 Mar 2016 19:55:52 -0800
Message-ID: <56D7B5C8.7000504@linaro.org>
References: <1456190570-4475-1-git-send-email-smuckle@linaro.org>
 <1456190570-4475-5-git-send-email-smuckle@linaro.org>
 <CAAJzSMcf69vWKWYR09cp8e11D0dYRDmVm91ietfshy3UgmMEiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAAJzSMcf69vWKWYR09cp8e11D0dYRDmVm91ietfshy3UgmMEiA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ricky Liang <jcliang@chromium.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "Rafael J. Wysocki" <rafael@kernel.org>, open list <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>
List-Id: linux-pm@vger.kernel.org

Hi Ricky,

On 02/29/2016 10:51 PM, Ricky Liang wrote:
> The change hunks of this patch should probably all depend on
> CONFIG_SMP as capacity_orig_of() and cpu_util() are only available
> when CONFIG_SMP is enabled.

Yeah, I was deferring cleaning that up until there was more buy in on
the overall solution. But it looks like we will be moving forward using
Rafael's schedutil governor. The most recent posting of that is here:

http://thread.gmane.org/gmane.linux.kernel/2166378

thanks,
Steve
