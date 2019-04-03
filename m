From: Markus Elfring <Markus.Elfring@web.de>
Subject: Re: [4/7] cpufreq: maple: Checking implementation of
 maple_cpufreq_init()
Date: Wed, 3 Apr 2019 15:50:44 +0200
Message-ID: <5d0e8f12-baaa-e4af-f1d2-03e0508e3fd1@web.de>
References: <1554082674-2049-5-git-send-email-wen.yang99@zte.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1554082674-2049-5-git-send-email-wen.yang99@zte.com.cn>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wen Yang <wen.yang99@zte.com.cn>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, kernel-janitors@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Yi Wang <wang.yi59@zte.com.cn>
List-Id: linux-pm@vger.kernel.org

> @@ -210,7 +210,7 @@  static int __init maple_cpufreq_init(void)
>  	 */
>  	valp =3D of_get_property(cpunode, "clock-frequency", NULL);
>  	if (!valp)
> -		return -ENODEV;
> +		goto bail_noprops;
>  	max_freq =3D (*valp)/1000;
>  	maple_cpu_freqs[0].frequency =3D max_freq;
>  	maple_cpu_freqs[1].frequency =3D max_freq/2;

* How do you think about use the jump label =E2=80=9Cput_node=E2=80=9D ins=
tead?

* Would you like to reduce a bit of duplicate source code at the end
  of this function?
  https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree=
/drivers/cpufreq/maple-cpufreq.c?id=3Dbf97b82f37c6d90e16de001d0659644c57fa=
490d#n232

Regards,
Markus
