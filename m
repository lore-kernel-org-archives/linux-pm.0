From: Ai Li <aili@codeaurora.org>
Subject: Re: [PATCH v2] cpuidle: extend cpuidle and menu governor
 to handle dynamic states
Date: Thu, 29 Jul 2010 13:15:29 -0600
Message-ID: <1280430929.22142.51.camel__41292.8701648072$1280431114$gmane$org@ali-lnx.qualcomm.com>
References: <1280352443-28044-1-git-send-email-aili@codeaurora.org>
	<20100728145545.35caf67a.akpm@linux-foundation.org>
	<1280426600.22142.27.camel@ali-lnx.qualcomm.com>
	<20100729114306.093cc58c.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100729114306.093cc58c.akpm@linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: len.brown@intel.com, dwalker@codeaurora.org, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, mingo@elte.hu, arjan@linux.intel.com, shemminger@vyatta.com
List-Id: linux-pm@vger.kernel.org

On Thu, 2010-07-29 at 11:43 -0700, Andrew Morton wrote:

> I'd be reluctant to merge this code without also having code which uses
> it.  As it is the change is useless and untestable.

We have local code in the arch/arm/mach-msm branch that uses the new
cpuidle code.  We are still developing and testing the MSM patches, and
hope to upstream them in a few weeks.

~Ai
-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
