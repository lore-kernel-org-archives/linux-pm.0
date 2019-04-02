From: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH 7/7] cpufreq: ppc_cbe: fix possible object reference
 leak
Date: Tue, 2 Apr 2019 15:15:19 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1904021515000.3297@hadrien>
References: <1554082674-2049-8-git-send-email-wen.yang99@zte.com.cn> <89ab8dd4-e997-1796-a522-863ff511bb58@web.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1488356219-1554210919=:3297"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <89ab8dd4-e997-1796-a522-863ff511bb58@web.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Wen Yang <wen.yang99@zte.com.cn>, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Yi Wang <wang.yi59@zte.com.cn>
List-Id: linux-pm@vger.kernel.org

--8323329-1488356219-1554210919=:3297
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Tue, 2 Apr 2019, Markus Elfring wrote:

> > @@ -86,6 +86,7 @@ static int cbe_cpufreq_cpu_init(struct cpufreq_policy *policy)
> >  	if (!cbe_get_cpu_pmd_regs(policy->cpu) ||
> >  	    !cbe_get_cpu_mic_tm_regs(policy->cpu)) {
> >  		pr_info("invalid CBE regs pointers for cpufreq\n");
> > +		of_node_put(cpu);
> >  		return -EINVAL;
> >  	}
>
> I have taken another look at the implementation of this function.
> I find that the second statement “return -EINVAL” would need related
> source code adjustments.
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/cpufreq/ppc_cbe_cpufreq.c?id=05d08e2995cbe6efdb993482ee0d38a77040861a#n96
>
> How do you think about to complete the exception handling here?

There is an of_node_put two lines above.

julia
--8323329-1488356219-1554210919=:3297--
