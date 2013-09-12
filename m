From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [PATCH 5/5] cpufreq: use correct values of cpus in __cpufreq_remove_dev_finish()
Date: Thu, 12 Sep 2013 12:46:16 +0530
Message-ID: <52316A40.4050600@linux.vnet.ibm.com>
References: <cover.1378963070.git.viresh.kumar@linaro.org> <8f777cc6b41b2fed4bf71ce2adc36800353d5738.1378963070.git.viresh.kumar@linaro.org> <523161D1.9040005@linux.vnet.ibm.com> <CAKohpomz-EDbRNqv58zn6B+kC1jdjrxx68hoDrAj==+YbeTj=g@mail.gmail.com> <CAKohpomCXoO20cQyCrWtN0WgWnzvVmEqFxuwTU8V0GpXsQxgHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAKohpomCXoO20cQyCrWtN0WgWnzvVmEqFxuwTU8V0GpXsQxgHw@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Stephen Warren <swarren@wwwdotorg.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Patch Tracking <patches@linaro.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 09/12/2013 12:26 PM, Viresh Kumar wrote:
> On 12 September 2013 12:17, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>> Currently cpus never become zero as we clear mask only while there are
>> more than one cpu in a policy... Wait let me see what's the cleanest way
>> to get this fixed..
> 
> Okay, simply replace cpumask_first() with cpumask_any_but() in
> cpufreq_nominate_new_policy_cpu() :)
> 

That sounds good! Even the naming is much better, it conveys the intent
clearly.

Regards,
Srivatsa S. Bhat

