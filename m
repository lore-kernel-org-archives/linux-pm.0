From: mark gross <640e9920@gmail.com>
Subject: Re: [PATCH]PM QOS refresh against next-20100430
Date: Mon, 3 May 2010 21:41:51 -0700
Message-ID: <20100504044151.GB3043__37126.8594674349$1272948178$gmane$org@thegnar.org>
References: <20100430212043.GA30315@linux.intel.com>
	<20100503103300.6330e522@bike.lwn.net>
Reply-To: markgross@thegnar.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20100503103300.6330e522@bike.lwn.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jonathan Corbet <corbet@lwn.net>
Cc: davidb@quicinc.com, dwalker@codeaurora.org, tiwai@suse.de, bruce.w.allan@intel.com, lkml <linux-kernel@vger.kernel.org>, mcgrof@gmail.com, linux-pm <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Mon, May 03, 2010 at 10:33:00AM -0600, Jonathan Corbet wrote:
> On Fri, 30 Apr 2010 14:20:43 -0700
> mark gross <mgross@linux.intel.com> wrote:
> 
> > This patch changes the string based list management to a handle base
> > implementation to help with the hot path use of pm-qos
> 
> Having taken a quick look, I think the API change makes a lot of
> sense.  Hot paths are one thing; avoidance of accidental conflicts
> would be another.

Conflicts? say more please.
 
> One question, though...  one clear use of this API is for drivers to
> say "don't go into C3 or deeper because things go wrong"; I'm about to
> add another one of those.  It works, but the use of a
> PM_QOS_CPU_DMA_LATENCY requirement with a hard-coded number that one
> hopes is small enough seems a bit...indirect.  I wonder if it would be
> clearer and more robust to add a new requirement^Wrequest type saying
> "the quality of service I need is shallow sleeps only"?

Well, adding such an api to cpuidle could do this for you.  "shallow" is
hard to define, but one could do what google did and define a
cpu_wake_lock type of API to block entry into any low power halt/mwait
type of state.  i.e. shallow would be C0, or just halt in idle.

If such a thing fits a "hotpath" API extention to pm_qos basically
implementing a low overhead disable lowpower behavior without having to
walk the pm_qos lists to get an agrigate value.  But, if such an api
belongs in cpu_idle thats fine too, as the only user of such and API
really is devices (like spi devices hangining of a clock that goes down
in the deeper idle states) wanting to block low power idle states, so be
it.

--mgross

> 
> jon
> _______________________________________________
> linux-pm mailing list
> linux-pm@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/linux-pm
