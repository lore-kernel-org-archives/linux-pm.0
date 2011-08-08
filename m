From: MyungJoo Ham <myungjoo.ham@gmail.com>
Subject: Re: [PATCH v5 0/3] DEVFREQ,
	DVFS Framework for Non-CPU Devices.
Date: Mon, 8 Aug 2011 18:53:31 +0900
Message-ID: <CAJ0PZbSgVujLSW9Ea_iWHZVbq2_H3EWGJg_1Zh5rUfvG3sxgsw@mail.gmail.com>
References: <1312794188-9823-1-git-send-email-myungjoo.ham@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1312794188-9823-1-git-send-email-myungjoo.ham@samsung.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
Cc: Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@suse.de>, Kyungmin Park <kyungmin.park@samsung.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org

Hello all,


I've got one issue requesting some comments: whether to create devfreq
directory or not.

For now, we only have four basic governors and one not-yet-posted
devfreq user for DEVFREQ; thus, it seems not necessary for just now.

However, like CPUFREQ, DEVFREQ may have several users later and we may
want to gather these files to one location: /drivers/devfreq or
somewhere else in /drivers/*. For example, Exynos4210 Memory DEVFREQ
user is located at arch/arm/mach-exynos4/devfreq_bus.c and with a
separated directory, we may have it at
drivers/devfreq/exynos4_memory_bus.c.

How do you think about separating DEVFREQ directory? Should I do so or
wait until we have several DEVFREQ users?


Cheers!
MyungJoo
-- 
MyungJoo Ham, Ph.D.
Mobile Software Platform Lab,
Digital Media and Communications (DMC) Business
Samsung Electronics
cell: 82-10-6714-2858
