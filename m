From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [RFC PATCH] PM: Introduce generic DVFS
	framework	with device-specific OPPs
Date: Tue, 26 Apr 2011 16:07:11 +0100
Message-ID: <20110426150710.GB23812@sirena.org.uk>
References: <1303807401-16350-1-git-send-email-myungjoo.ham@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1303807401-16350-1-git-send-email-myungjoo.ham@samsung.com>
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
Cc: Nishanth Menon <nm@ti.com>, Len Brown <len.brown@intel.com>, Kevin Hilman <khilman@deeprootsystems.com>, Greg Kroah-Hartman <gregkh@suse.de>, Kyungmin Park <kyungmin.park@samsung.com>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Tue, Apr 26, 2011 at 05:43:21PM +0900, MyungJoo Ham wrote:

> +static int __init dvfs_init(void)
> +{
> +	platform_driver_register(&dvfs_pm_drv);
> +	platform_device_register(&dvfs_pm_dev);
> +
> +	INIT_DELAYED_WORK_DEFERRABLE(&dvfs_work, dvfs_monitor);
> +	schedule_delayed_work(&dvfs_work, msecs_to_jiffies(DVFS_INTERVAL));

This will unconditionally start the timer which polls the devices at
whatever rate.  I'd expect to start and stop the poll depending on if we
have devices and/or governor type code (which I don't see anything for
here, though it's hard to know what criteria a generic governor would
use) which require it.
