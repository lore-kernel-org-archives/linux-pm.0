From: Markus Elfring <Markus.Elfring@web.de>
Subject: Re: [1/7] cpufreq: ap806: Checking implementation of
 armada_8k_cpufreq_init()
Date: Tue, 2 Apr 2019 15:54:27 +0200
Message-ID: <bc7c03e2-798f-7ccc-4386-227a9e16611d@web.de>
References: <1554082674-2049-2-git-send-email-wen.yang99@zte.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1554082674-2049-2-git-send-email-wen.yang99@zte.com.cn>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Wen Yang <wen.yang99@zte.com.cn>, Gregory Clement <gregory.clement@bootlin.com>, Viresh Kumar <viresh.kumar@linaro.org>, kernel-janitors@vger.kernel.org
Cc: Yi Wang <wang.yi59@zte.com.cn>, Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-pm@vger.kernel.org

> @@ -132,6 +132,7 @@ static int __init armada_8k_cpufreq_init(void)
>  		of_node_put(node);
>  		return -ENODEV;
>  	}
> +	of_node_put(node);
>
>  	nb_cpus = num_possible_cpus();
>  	freq_tables = kcalloc(nb_cpus, sizeof(*freq_tables), GFP_KERNEL);

Would another null pointer check be safer for this memory allocation?
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/cpufreq/armada-8k-cpufreq.c?id=05d08e2995cbe6efdb993482ee0d38a77040861a#n137

Regards,
Markus
