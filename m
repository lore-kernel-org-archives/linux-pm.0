From: Yi Yang <yi.y.yang@intel.com>
Subject: Re: [PATCH 2.6.25-rc3] cpuidle: fix cpuidle time and
	usage overflow
Date: Mon, 25 Feb 2008 09:10:26 +0800
Message-ID: <1203901826.4954.11.camel__48567.1400362209$1203935383$gmane$org@yangyi-dev.bj.intel.com>
References: <1199441414.19185.9.camel@yangyi-dev.bj.intel.com>
	<1201043126.3861.5.camel@yangyi-dev.bj.intel.com>
	<1203032921.3897.10.camel@yangyi-dev.bj.intel.com>
	<1203900372.4954.8.camel@yangyi-dev.bj.intel.com>
	<20080225101533.GB30685@elte.hu>
Reply-To: yi.y.yang@intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080225101533.GB30685@elte.hu>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ingo Molnar <mingo@elte.hu>
Cc: cpufreq@lists.linux.org.uk, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, akpm@linux-foundation.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Mon, 2008-02-25 at 11:15 +0100, Ingo Molnar wrote:
> * Yi Yang <yi.y.yang@intel.com> wrote:
> 
> > cpuidle C-state sysfs node time and usage are very easy to overflow 
> > because they are all of unsigned int type, time will overflow within 
> > about two hours, usage will take longer time to overflow, but they are 
> > increasing for ever.
> > 
> > This patch will convert them to unsigned long long.
> 
> what happens if such an overflow happens - any particular regression or 
> other misbehavior, or just funny looking stats in sysfs?
They are just stats info in sysfs, cpuidle's behaviors don't depend on
them. I didn't notice any regression or misbehaviors.

> 
> 	Ingo
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
