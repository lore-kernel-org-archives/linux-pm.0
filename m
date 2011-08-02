From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v4 1/3] PM: Introduce DEVFREQ: generic DVFS
	framework with device-specific OPPs
Date: Tue, 02 Aug 2011 11:45:39 -0700
Message-ID: <87mxfrire4.fsf@ti.com>
References: <1310717510-19002-1-git-send-email-myungjoo.ham@samsung.com>
	<1310717510-19002-2-git-send-email-myungjoo.ham@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1310717510-19002-2-git-send-email-myungjoo.ham@samsung.com>
	(MyungJoo Ham's message of "Fri, 15 Jul 2011 17:11:48 +0900")
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Len Brown <len.brown@intel.com>, linux-pm@lists.linux-foundation.org, Greg Kroah-Hartman <gregkh@suse.de>, Thomas Gleixner <tglx@linutronix.de>, Kyungmin Park <kyungmin.park@samsung.com>
List-Id: linux-pm@vger.kernel.org

MyungJoo Ham <myungjoo.ham@samsung.com> writes:

> With OPPs, a device may have multiple operable frequency and voltage
> sets. However, there can be multiple possible operable sets and a system
> will need to choose one from them. In order to reduce the power
> consumption (by reducing frequency and voltage) without affecting the
> performance too much, a Dynamic Voltage and Frequency Scaling (DVFS)
> scheme may be used.
>
> This patch introduces the DVFS capability to non-CPU devices with OPPs.
> DVFS is a techique whereby the frequency and supplied voltage of a
> device is adjusted on-the-fly. DVFS usually sets the frequency as low
> as possible with given conditions (such as QoS assurance) and adjusts
> voltage according to the chosen frequency in order to reduce power
> consumption and heat dissipation.
>
> The generic DVFS for devices, DEVFREQ, may appear quite similar with
> /drivers/cpufreq.  However, CPUFREQ does not allow to have multiple
> devices registered and is not suitable to have multiple heterogenous
> devices with different (but simple) governors.
>
> Normally, DVFS mechanism controls frequency based on the demand for
> the device, and then, chooses voltage based on the chosen frequency.
> DEVFREQ also controls the frequency based on the governor's frequency
> recommendation and let OPP pick up the pair of frequency and voltage
> based on the recommended frequency. Then, the chosen OPP is passed to
> device driver's "target" callback.
>
> Tested with memory bus of Exynos4-NURI board.
>
> The test code with board support for Exynos4-NURI is at
> http://git.infradead.org/users/kmpark/linux-2.6-samsung/shortlog/refs/heads/devfreq
>
> Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>
> --
> Thank you for your valuable comments, Rafael, Greg, Pavel, and Colin.
>
> Changed from v3
> - In kerneldoc comments, DEVFREQ has ben replaced by devfreq

FYI... there are still lots of kerneldoc comments in this version with
DEVFREQ instead of devfreq, particularily in devfreq.h.

Kevin
