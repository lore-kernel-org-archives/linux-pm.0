From: Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH]PM QOS refresh against next-20100430
Date: Mon, 3 May 2010 10:42:50 -0600
Message-ID: <20100503104250.7605d2bc__7894.57511059499$1272905091$gmane$org@bike.lwn.net>
References: <20100430212043.GA30315@linux.intel.com>
	<20100503103300.6330e522@bike.lwn.net>
	<87y6g1547o.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <87y6g1547o.fsf@deeprootsystems.com>
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

On Mon, 03 May 2010 09:40:11 -0700
Kevin Hilman <khilman@deeprootsystems.com> wrote:

> > One question, though...  one clear use of this API is for drivers to
> > say "don't go into C3 or deeper because things go wrong"; I'm about to
> > add another one of those.  It works, but the use of a
> > PM_QOS_CPU_DMA_LATENCY requirement with a hard-coded number that one
> > hopes is small enough seems a bit...indirect.  I wonder if it would be
> > clearer and more robust to add a new requirement^Wrequest type saying
> > "the quality of service I need is shallow sleeps only"?  
> 
> The problem with that is portability.
> 
> What does "shallow" mean?  

Well, shallow could mean that the state lacks the CPUIDLE_FLAG_DEEP
flag; that should be relatively portable.  In any case, it seems more
so than "if I put in a 55us latency requirement, I'll stay out of C3".

Just a thought, anyway; it's not like I've really worked through a
plausible alternative API.

jon
