From: Matthew Garrett <mjg@redhat.com>
Subject: Re: [PATCH 1/8] PM: Add suspend block api.
Date: Fri, 7 May 2010 18:36:21 +0100
Message-ID: <20100507173621.GA23604__6293.61260585046$1273253860$gmane$org@srcf.ucam.org>
References: <20100505234755.GI29604@atomide.com>
	<20100506134015.GA23426@srcf.ucam.org>
	<20100506170151.GA30928@atomide.com>
	<20100506170956.GA28104@srcf.ucam.org>
	<20100506171453.GC30928@atomide.com>
	<1273167311.20494.13.camel@c-dwalke-linux.qualcomm.com>
	<20100506183605.GF30928@atomide.com>
	<1273173110.20494.19.camel@c-dwalke-linux.qualcomm.com>
	<20100507020057.GG30928@atomide.com>
	<1273252837.3542.30.camel@c-dwalke-linux.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1273252837.3542.30.camel@c-dwalke-linux.qualcomm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Daniel Walker <dwalker@fifo99.com>
Cc: Len Brown <len.brown@intel.com>, markgross@thegnar.org, Brian Swetland <swetland@google.com>, linux-doc@vger.kernel.org, Kernel development list <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Wu Fengguang <fengguang.wu@intel.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Fri, May 07, 2010 at 10:20:37AM -0700, Daniel Walker wrote:

> MSM doesn't have those power states unfortunately .. Your kind of
> suggesting what I was suggesting in that we should suspend in idle. Your
> hardware can do it easier tho since your have power states that are
> equal to suspend.

If your wakeup latencies are sufficiently low and you have fine-grained 
enough control over your hardware then suspend in idle is a reasonable 
thing to do - but if you have a userspace app that's spinning then 
that doesn't solve the issue.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
