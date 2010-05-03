From: Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH]PM QOS refresh against next-20100430
Date: Mon, 3 May 2010 11:10:20 -0600
Message-ID: <20100503111020.2dab8003__29816.2540341311$1272906745$gmane$org@bike.lwn.net>
References: <20100430212043.GA30315@linux.intel.com>
	<20100503103300.6330e522@bike.lwn.net>
	<87y6g1547o.fsf@deeprootsystems.com>
	<20100503104250.7605d2bc@bike.lwn.net>
	<87tyqo537l.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
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
Cc: davidb@quicinc.com, dwalker@codeaurora.org, tiwai@suse.de, bruce.w.allan@intel.com, lkml <linux-kernel@vger.kernel.org>, mcgrof@gmail.com, linux-pm <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 03 May 2010 10:01:50 -0700
Kevin Hilman <khilman@deeprootsystems.com> wrote:

> > Well, shallow could mean that the state lacks the CPUIDLE_FLAG_DEEP
> > flag; that should be relatively portable.  In any case, it seems
> > more so than "if I put in a 55us latency requirement, I'll stay out
> > of C3".  
> 
> I guess it depends on your goal.  Do you just want to stay out of C3
> on your current platform?  or do you want to stay out of any low-power
> state (on any platform) where you'll have a latency of > 55 usecs?

My case is a camera driver; as long as latencies are on the scale of
the frame rate, things won't go too wrong.  1ms latencies would not be
a huge problem.  What happens is that the hardware corrupts the data if
it goes into C3 while video capture is happening.

Comments in drivers/net/e1000e/netdev.c suggest that they were dealing
with similar issues.

> The former is not portable (as C-states don't have the same meanings
> across arches/SoCs) where as using a real-world number in usecs will
> have meaning on any platform.

Understood.  But the end result is that I've ended up specifying a
latency requirement that is far tighter than the situation really needs
in order to achieve the real goal.

> My main concern is that drivers not be written with latency
> constraints that assume an Intel-centric set of power states.  There
> are other SoCs out there with different sets of states and
> corresponding latencies, so keeping things in real-world numbers
> (latency, throughput, etc.) seems to me to be the only portable way.

Understood.  Perhaps the pm_qos interface isn't the best way to achieve
the real goal here, but it's all we have at the moment.

Thanks,

jon
