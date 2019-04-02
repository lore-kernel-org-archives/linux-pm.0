From: Markus Elfring <Markus.Elfring@web.de>
Subject: Re: [1/7] cpufreq: ap806: Checking implementation of
 armada_8k_cpufreq_init()
Date: Tue, 2 Apr 2019 15:54:27 +0200
Message-ID: <7298cc5c-27e8-c71d-ddc9-553534e502ef@web.de>
References: <1554082674-2049-2-git-send-email-wen.yang99@zte.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1554082674-2049-2-git-send-email-wen.yang99@zte.com.cn>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wen Yang <wen.yang99@zte.com.cn>, Gregory Clement <gregory.clement@bootlin.com>, Viresh Kumar <viresh.kumar@linaro.org>, kernel-janitors@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Yi Wang <wang.yi59@zte.com.cn>
List-Id: linux-pm@vger.kernel.org

> @@ -132,6 +132,7 @@ static int __init armada_8k_cpufreq_init(void)
>  		of_node_put(node);
>  		return -ENODEV;
>  	}
> +	of_node_put(node);
>
>  	nb_cpus =3D num_possible_cpus();
>  	freq_tables =3D kcalloc(nb_cpus, sizeof(*freq_tables), GFP_KERNEL);

Would another null pointer check be safer for this memory allocation?
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/d=
rivers/cpufreq/armada-8k-cpufreq.c?id=3D05d08e2995cbe6efdb993482ee0d38a770=
40861a#n137

Regards,
Markus
