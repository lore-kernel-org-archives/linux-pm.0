From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH 11/12] cpuidle: mvebu: Add initial cpu idle support for
 Armada 370/XP SoC
Date: Mon, 26 Aug 2013 20:28:01 -0700
Message-ID: <87d2oz7qym.fsf@linaro.org>
References: <1377240797-4047-1-git-send-email-gregory.clement@free-electrons.com>
 <1377240797-4047-12-git-send-email-gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1377240797-4047-12-git-send-email-gregory.clement@free-electrons.com>
 (Gregory CLEMENT's message of "Fri, 23 Aug 2013 08:53:16 +0200")
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

Hi Gregory,

Gregory CLEMENT <gregory.clement@free-electrons.com> writes:

> Add wfi/cpu idle/cpu deep idle power states support for Armada XP SoC.
>
> All the latencies and the power consumption values used at the
> "armada_370_xp_idle_driver" structure are preliminary and will be
> modified in the future after running some measurements and analysis.
>
> Based on the work of Nadav Haklai.
>
> Signed-off-by: Nadav Haklai <nadavh@marvell.com>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

[...]

> +int pm_support = WFI;
> +static int __init pm_enable_setup(char *str)
> +{
> +	if (!strncmp(str, "wfi", 3))
> +		pm_support = WFI;
> +	else if (!strncmp(str, "idle", 4))
> +		pm_support = MV_CPU_IDLE;
> +	else if (!strncmp(str, "deepidle", 6))
> +		pm_support = MV_CPU_DEEP_IDLE;
> +	else if (!strncmp(str, "off", 3))
> +		pm_support = DISABLED;
> +
> +	return 1;
> +}
> +__setup("pm_level=", pm_enable_setup);

Why is this new (but undocumented) kernel commandline needed when there
is already a way to configure the deepest C state from userspace?
(c.f. the 'disable' file under /sys/devices/system/cpu/cpuX/cpuidle/stateY)

Kevin
