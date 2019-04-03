From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [5/7] cpufreq/pasemi: Checking implementation of
 pas_cpufreq_cpu_init()
Date: Wed, 3 Apr 2019 18:31:15 +0300
Message-ID: <20190403153115.GA22624@kadam>
References: <1554082674-2049-6-git-send-email-wen.yang99@zte.com.cn>
 <c0c9c429-a09f-41ba-611d-123b64e410c8@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <c0c9c429-a09f-41ba-611d-123b64e410c8@web.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Wen Yang <wen.yang99@zte.com.cn>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Yi Wang <wang.yi59@zte.com.cn>
List-Id: linux-pm@vger.kernel.org

On Wed, Apr 03, 2019 at 04:23:54PM +0200, Markus Elfring wrote:
> > @@ -146,6 +146,7 @@  static int pas_cpufreq_cpu_init(struct cpufreq_policy *policy)
> >
> >  	cpu = of_get_cpu_node(policy->cpu, NULL);
> >
> > +	of_node_put(cpu);
> >  	if (!cpu)
> >  		goto out;
> 
> Can the statement “return -ENODEV” be nicer as exception handling
> in the if branch of this source code place?
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/cpufreq/pasemi-cpufreq.c?id=bf97b82f37c6d90e16de001d0659644c57fa490d#n137
> 

Why am I only receiving only one side of this conversation?

I don't know why you're responding to...  It's not required to fix/change
unrelated style choices.  If people want, they can just focus on their
own thing.

regards,
dan carpenter
