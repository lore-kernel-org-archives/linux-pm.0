From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH]PM QOS refresh against next-20100430
Date: Mon, 3 May 2010 22:39:19 +0100
Message-ID: <20100503213919.GA18910__36453.5155393698$1272922916$gmane$org@srcf.ucam.org>
References: <20100430212043.GA30315@linux.intel.com>
	<20100503103300.6330e522@bike.lwn.net>
	<87y6g1547o.fsf@deeprootsystems.com>
	<20100503104250.7605d2bc@bike.lwn.net>
	<87tyqo537l.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <87tyqo537l.fsf@deeprootsystems.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: davidb@quicinc.com, dwalker@codeaurora.org, Jonathan Corbet <corbet@lwn.net>, tiwai@suse.de, bruce.w.allan@intel.com, lkml <linux-kernel@vger.kernel.org>, mcgrof@gmail.com, linux-pm <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Mon, May 03, 2010 at 10:01:50AM -0700, Kevin Hilman wrote:
> Jonathan Corbet <corbet@lwn.net> writes:
> > Well, shallow could mean that the state lacks the CPUIDLE_FLAG_DEEP
> > flag; that should be relatively portable.  In any case, it seems
> > more so than "if I put in a 55us latency requirement, I'll stay out
> > of C3".
> 
> I guess it depends on your goal.  Do you just want to stay out of C3
> on your current platform?  or do you want to stay out of any low-power
> state (on any platform) where you'll have a latency of > 55 usecs?

I'd say that one plausible requirement is "DMA works", with another 
being "all interrupts work" as distinguished from "wakeup interrupts 
work".

-- 
Matthew Garrett | mjg59@srcf.ucam.org
