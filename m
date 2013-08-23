From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: Re: [PATCH 11/12] cpuidle: mvebu: Add initial cpu idle support for
 Armada 370/XP SoC
Date: Fri, 23 Aug 2013 10:41:53 +0200
Message-ID: <52172051.2030505@free-electrons.com>
References: <1377240797-4047-1-git-send-email-gregory.clement@free-electrons.com>
 <1377240797-4047-12-git-send-email-gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1377240797-4047-12-git-send-email-gregory.clement@free-electrons.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>, Ike Pan <ike.pan@canonical.com>, Atsushi Yamagata <yamagata@plathome.co.jp>, Nadav Haklai <nadavh@marvell.com>, David Marlin <dmarlin@redhat.com>, Yehuda Yitschak <yehuday@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Dan Frazier <dann.frazier@canonical.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Eran Ben-Avi <benavi@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Leif Lindholm <leif.lindholm@arm.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Tomonori Kimura <kimura@plathome.co.jp>, Jason Cooper <jason@lakedaemon.net>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, linux-pm@vger.kernel.org, Jon Masters <jcm@redhat.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Hironobu Shibata <h-shibata@plathome.co.jp>, linux-arm-kernel@lists.infradead.org, Thomas Petazzoni <thomas.petazz>
List-Id: linux-pm@vger.kernel.org

On 23/08/2013 08:53, Gregory CLEMENT wrote:
> Add wfi/cpu idle/cpu deep idle power states support for Armada XP SoC.
> 
> All the latencies and the power consumption values used at the
> "armada_370_xp_idle_driver" structure are preliminary and will be
> modified in the future after running some measurements and analysis.
> 
> Based on the work of Nadav Haklai.

Atsushi Yamagata reported me an kernel crash when pm_support=off.
Indeed I have lost a small chunk of code during my code reshaping.
The following code will fix the issue. I will add it in the next
version of this series.

[...]
> +
> +	if (pm_support == WFI)
> +		pr_info(" (WFI)\n");
> +	else if (pm_support == MV_CPU_IDLE)
> +		pr_info(" (CPU_IDLE)\n");
> +	else if (pm_support == MV_CPU_DEEP_IDLE)
> +		pr_info(" (CPU_DEEP_IDLE)\n");


> +	else
> +		pr_info(" (DISABLED)\n");
Will be replaced by
+       else {
+                       pr_info(" (DISABLED)\n");
+                       return; /* do not register the cpuidle device */
+       }

> +
> +	armada_370_xp_idle_driver.state_count = pm_support + 1;
> +
> +	return cpuidle_register(&armada_370_xp_idle_driver, NULL);
> +}
> +

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
