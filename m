From: Markus Elfring <Markus.Elfring@web.de>
Subject: Re: [5/7] cpufreq/pasemi: Checking implementation of
 pas_cpufreq_cpu_init()
Date: Wed, 3 Apr 2019 16:23:54 +0200
Message-ID: <c0c9c429-a09f-41ba-611d-123b64e410c8@web.de>
References: <1554082674-2049-6-git-send-email-wen.yang99@zte.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1554082674-2049-6-git-send-email-wen.yang99@zte.com.cn>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wen Yang <wen.yang99@zte.com.cn>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, kernel-janitors@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Yi Wang <wang.yi59@zte.com.cn>
List-Id: linux-pm@vger.kernel.org

> @@ -146,6 +146,7 @@  static int pas_cpufreq_cpu_init(struct cpufreq_poli=
cy *policy)
>
>  	cpu =3D of_get_cpu_node(policy->cpu, NULL);
>
> +	of_node_put(cpu);
>  	if (!cpu)
>  		goto out;

Can the statement =E2=80=9Creturn -ENODEV=E2=80=9D be nicer as exception h=
andling
in the if branch of this source code place?
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/d=
rivers/cpufreq/pasemi-cpufreq.c?id=3Dbf97b82f37c6d90e16de001d0659644c57fa4=
90d#n137

Regards,
Markus
