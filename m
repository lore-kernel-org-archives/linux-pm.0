From: Alex Shi <alex.shi@linaro.org>
Subject: Re: [PATCH 3/3] cpuidle/menu: add per cpu pm_qos_resume_latency
 consideration
Date: Fri, 20 Jan 2017 16:35:51 +0800
Message-ID: <c242e66c-b8d5-fb27-4c54-12c1ef823031@linaro.org>
References: <1484227624-6740-1-git-send-email-alex.shi@linaro.org>
 <1484227624-6740-4-git-send-email-alex.shi@linaro.org>
 <20170117093837.GA2085@mai> <01f9b016-0b7c-44ac-70e5-8cd9b8bd1500@linaro.org>
 <20170119102158.GA1827@mai>
 <CAJZ5v0ifEfqN04XdDjjMQhuo6eznqgnj+VQEGFCUxzjzAxb2=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0ifEfqN04XdDjjMQhuo6eznqgnj+VQEGFCUxzjzAxb2=g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Vincent Guittot <vincent.guittot@linaro.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Arjan van de Ven <arjan@linux.intel.com>, Rik van Riel <riel@redhat.com>
List-Id: linux-pm@vger.kernel.org



On 01/20/2017 05:43 AM, Rafael J. Wysocki wrote:
> The above may be problematic if the constraints change relatively
> often.  It is global and it will affect all of the CPUs in the system
> every time and now think about systems with hundreds of them.

Yes, the disadvantage is waking up all idle cpus when value changed. As
to the multi core concern, maybe a per cpu notifier way is better? But
that's another story of pm_qos...

So Rafael, any comments for this patch version?

Regards
Alex
