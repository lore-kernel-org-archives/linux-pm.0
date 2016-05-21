From: Fabio Estevam <festevam@gmail.com>
Subject: Re: Crash after 'reboot' due to 9be4fd2c7723a
Date: Fri, 20 May 2016 22:19:09 -0300
Message-ID: <CAOMZO5BBXmXAJayo8YpX4eV-_rTtAoDvjf91CUhWnLV8A0mx0g@mail.gmail.com>
References: <CAOMZO5A62LgnyT0sQw5N-xeHaD0nSGTjAFxUx=_6OpUm02robA@mail.gmail.com>
 <CAJZ5v0hX1dZ+79-KCyumf57o02WKivxcRLJ1Zi8akrqu_2CZEQ@mail.gmail.com>
 <CAOMZO5CD08cX0yDBZTdFV+iwgr__fjSaaWvgjimotr5L1yrbaQ@mail.gmail.com>
 <2148724.oQlEHos3jS@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <2148724.oQlEHos3jS@vostro.rjw.lan>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Russell King <linux@arm.linux.org.uk>, Ping Bai <ping.bai@nxp.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Guenter Roeck <linux@roeck-us.net>, Sascha Hauer <kernel@pengutronix.de>, "Rafael J. Wysocki" <rafael@kernel.org>, Shawn Guo <shawnguo@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

Hi Rafael,

On Fri, May 20, 2016 at 9:56 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:

> If I'm not mistaken, the patch below should allow irq_work to make forward
> progress for you, so please check if it makes any difference.
....

> Index: linux-pm/drivers/cpufreq/cpufreq_governor.c
> ===================================================================
> --- linux-pm.orig/drivers/cpufreq/cpufreq_governor.c
> +++ linux-pm/drivers/cpufreq/cpufreq_governor.c
> @@ -362,6 +362,7 @@ static struct policy_dbs_info *alloc_pol
>         mutex_init(&policy_dbs->timer_mutex);
>         atomic_set(&policy_dbs->work_count, 0);
>         init_irq_work(&policy_dbs->irq_work, dbs_irq_work);
> +       policy_dbs->irq_work.flags = IRQ_WORK_LAZY;
>         INIT_WORK(&policy_dbs->work, dbs_work_handler);
>
>         /* Set policy_dbs for all CPUs, online+offline */

Running a 4.6 kernel with this patch applied allows me to reboot the
system, thanks.

'echo performance >
/sys/devices/system/cpu/cpu0/cpufreq/scaling_governor' works fine now.
