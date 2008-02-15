From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH 2.6.25-rc1] cpufreq: fix cpufreq policy
	refcount	imbalance
Date: Fri, 15 Feb 2008 13:01:37 -0800
Message-ID: <20080215210137.GE7583__4033.58929693258$1203109733$gmane$org@suse.de>
References: <1199441414.19185.9.camel@yangyi-dev.bj.intel.com>
	<1201043126.3861.5.camel@yangyi-dev.bj.intel.com>
	<1203032921.3897.10.camel@yangyi-dev.bj.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1203032921.3897.10.camel@yangyi-dev.bj.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Yi Yang <yi.y.yang@intel.com>
Cc: davej@codemonkey.org.uk, cpufreq@lists.linux.org.uk, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, akpm@linux-foundation.org, torvalds@linux-foundation.org, mingo@elte.hu
List-Id: linux-pm@vger.kernel.org

On Fri, Feb 15, 2008 at 07:48:41AM +0800, Yi Yang wrote:
> When one cpu is set to offline, the caller process will hang, according to
> the trace data, the problem lies in the refcount error in cpufreq driver,
> cpufreq_cpu_callback will wait for completion policy->kobj_unregister
> which is nerver completed because a refcount error in function
> __cpufreq_remove_dev in file driver/cpufreq/cpufreq.c results in not
> calling kobject release method.
> 
> In driver/cpufreq/cpufreq.c, the refcount of data->kobj isn't 1 when it
> will be unregistered, this problem didn't exist in 2.6.24 and earlier.
> 
> The root cause is kobject API switch, kobject_init_and_add and kobject_put
> replace older kobject_register and kobject_unregister in 2.6.25-rc1,
> compared to 2.6.24, kobject_unregister is deleted in function
> __cpufreq_remove_dev but it isn't replaced with kobject_put.
> 
> This patch adds kobject_put to balance refcount. I noticed Greg suggests
> it will fix a power-off issue to remove kobject_get statement block, but i
> think that isn't the best way because those code block has existed very long
> and it is helpful because the successive statements are invoking relevant
> data.
> 
> 
> Signed-off-by: Yi Yang <yi.y.yang@intel.com>

No, the additional kobject_get() needs to be removed.  I posted a patch
for this last night, and so did someone else earlier at:
		http://lkml.org/lkml/2008/2/8/342

this patch should not be added, I'll get the other one in instead.

thanks,

greg k-h
