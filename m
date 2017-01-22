From: Alex Shi <alex.shi@linaro.org>
Subject: Re: [PATCH 3/3] cpuidle/menu: add per cpu pm_qos_resume_latency
 consideration
Date: Sun, 22 Jan 2017 09:31:44 +0800
Message-ID: <58840B80.7000808@linaro.org>
References: <1484227624-6740-1-git-send-email-alex.shi@linaro.org>
 <1484227624-6740-4-git-send-email-alex.shi@linaro.org>
 <20170117093837.GA2085@mai> <01f9b016-0b7c-44ac-70e5-8cd9b8bd1500@linaro.org>
 <20170119102158.GA1827@mai>
 <CAJZ5v0ifEfqN04XdDjjMQhuo6eznqgnj+VQEGFCUxzjzAxb2=g@mail.gmail.com>
 <20170120105428.GA1804@mai>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170120105428.GA1804@mai>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Vincent Guittot <vincent.guittot@linaro.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Arjan van de Ven <arjan@linux.intel.com>, Rik van Riel <riel@redhat.com>
List-Id: linux-pm@vger.kernel.org


> Yeah, that could be problematic. The code snippet gives the general idea but it
> could be changed by for example by a flag telling the cpus when they enter idle
> to update their state_count. Or something like that.

Yes, this idea could be helpful.

But since the idle path isn't a hot path. and a few memory access won't 
cost a lot. So I doubt if the benefit could be measurable.


>
> But if you think the patchset is fine, it is ok, we can improve things afterwards.
>
