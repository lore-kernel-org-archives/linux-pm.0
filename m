From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [PATCH v3 09/14] sched/core: uclamp: propagate parent clamps
Date: Mon, 20 Aug 2018 12:01:09 +0200
Message-ID: <0a26a0de-f9e6-ef77-ceac-eb25bbf01664@arm.com>
References: <20180806163946.28380-1-patrick.bellasi@arm.com>
 <20180806163946.28380-10-patrick.bellasi@arm.com>
 <804c7937-2c47-0781-9c53-a8ef8eb04530@arm.com>
 <20180817144540.GL2960@e110439-lin>
 <d6c3b6f4-b3bd-22d9-70c0-38ad587b9339@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <d6c3b6f4-b3bd-22d9-70c0-38ad587b9339@arm.com>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Turner <pjt@google.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>, Suren Baghdasaryan <surenb@google.com>
List-Id: linux-pm@vger.kernel.org

On 08/17/2018 05:50 PM, Dietmar Eggemann wrote:
> On 08/17/2018 04:45 PM, Patrick Bellasi wrote:
>> On 17-Aug 15:43, Dietmar Eggemann wrote:
>>> On 08/06/2018 06:39 PM, Patrick Bellasi wrote:

[...]

>> AFAIK the default hierarcy (cgroups v2) has a much more stricy set of
>> requirements for the "delegation model".
> 
> Could be ... I guess I have to study this more.

So I see that this idea with the .effective files is used in Waiman's 
new cpuset cgroupv2 controller proposal.

The cpu controller with you util clamp extension has to be usable under 
cgroupv2 and cgroupv1, I assume?

[...]
