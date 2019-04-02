From: Markus Elfring <Markus.Elfring@web.de>
Subject: Re: [PATCH 7/7] cpufreq: ppc_cbe: fix possible object reference leak
Date: Tue, 2 Apr 2019 14:50:28 +0200
Message-ID: <89ab8dd4-e997-1796-a522-863ff511bb58@web.de>
References: <1554082674-2049-8-git-send-email-wen.yang99@zte.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1554082674-2049-8-git-send-email-wen.yang99@zte.com.cn>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wen Yang <wen.yang99@zte.com.cn>, kernel-janitors@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Yi Wang <wang.yi59@zte.com.cn>
List-Id: linux-pm@vger.kernel.org

> @@ -86,6 +86,7 @@ static int cbe_cpufreq_cpu_init(struct cpufreq_policy =
*policy)
>  	if (!cbe_get_cpu_pmd_regs(policy->cpu) ||
>  	    !cbe_get_cpu_mic_tm_regs(policy->cpu)) {
>  		pr_info("invalid CBE regs pointers for cpufreq\n");
> +		of_node_put(cpu);
>  		return -EINVAL;
>  	}

I have taken another look at the implementation of this function.
I find that the second statement =E2=80=9Creturn -EINVAL=E2=80=9D would ne=
ed related
source code adjustments.
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/d=
rivers/cpufreq/ppc_cbe_cpufreq.c?id=3D05d08e2995cbe6efdb993482ee0d38a77040=
861a#n96

How do you think about to complete the exception handling here?

Regards,
Markus
