From: Alex Shi <alex.shi@linaro.org>
Subject: Re: [PATCH 3/3] cpuidle/menu: add per cpu pm_qos_resume_latency
 consideration
Date: Mon, 23 Jan 2017 22:58:28 +0800
Message-ID: <2df41252-5302-c1ed-aad6-58517719f359@linaro.org>
References: <1484227624-6740-1-git-send-email-alex.shi@linaro.org>
 <1484227624-6740-4-git-send-email-alex.shi@linaro.org>
 <20170117093837.GA2085@mai> <01f9b016-0b7c-44ac-70e5-8cd9b8bd1500@linaro.org>
 <20170119102158.GA1827@mai>
 <CAJZ5v0ifEfqN04XdDjjMQhuo6eznqgnj+VQEGFCUxzjzAxb2=g@mail.gmail.com>
 <20170120105428.GA1804@mai> <58840B80.7000808@linaro.org>
 <20170123125025.GB2166@mai>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170123125025.GB2166@mai>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Vincent Guittot <vincent.guittot@linaro.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Arjan van de Ven <arjan@linux.intel.com>, Rik van Riel <riel@redhat.com>
List-Id: linux-pm@vger.kernel.org



On 01/23/2017 08:50 PM, Daniel Lezcano wrote:
> On Sun, Jan 22, 2017 at 09:31:44AM +0800, Alex Shi wrote:
>>
>>> Yeah, that could be problematic. The code snippet gives the general idea but it
>>> could be changed by for example by a flag telling the cpus when they enter idle
>>> to update their state_count. Or something like that.
>>
>> Yes, this idea could be helpful.
>>
>> But since the idle path isn't a hot path. and a few memory access won't cost
>> a lot. So I doubt if the benefit could be measurable.
> 
> It won't be measurable, as well as reading the cpu device latency before
> checking the latency req is zero, but it makes sense.

Just simple change the cpu state may make it looks unnatural. :)
> 
> The idle routine is not a hot path but a very special place where the interrupt
> are disabled, the rcu is not usable, tick is disabled etc ...
> 
> Perhaps it is not a problem for the moment, but it is probably worth to mention that
> using API from other subsystems in the idle select path could be problematic
> and perhaps it is time to think about another approach for the future.
> 

Yes, before idle, it did consider lots of parts, included pm qos for
long time... :)
