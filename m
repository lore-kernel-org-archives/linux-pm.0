From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 2.6.25-rc3] cpuidle: fix cpuidle time and
	usage overflow
Date: Mon, 25 Feb 2008 11:15:33 +0100
Message-ID: <20080225101533.GB30685__36122.3730528311$1203934805$gmane$org@elte.hu>
References: <1199441414.19185.9.camel@yangyi-dev.bj.intel.com>
	<1201043126.3861.5.camel@yangyi-dev.bj.intel.com>
	<1203032921.3897.10.camel@yangyi-dev.bj.intel.com>
	<1203900372.4954.8.camel@yangyi-dev.bj.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1203900372.4954.8.camel@yangyi-dev.bj.intel.com>
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
Cc: cpufreq@lists.linux.org.uk, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, akpm@linux-foundation.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org


* Yi Yang <yi.y.yang@intel.com> wrote:

> cpuidle C-state sysfs node time and usage are very easy to overflow 
> because they are all of unsigned int type, time will overflow within 
> about two hours, usage will take longer time to overflow, but they are 
> increasing for ever.
> 
> This patch will convert them to unsigned long long.

what happens if such an overflow happens - any particular regression or 
other misbehavior, or just funny looking stats in sysfs?

	Ingo
