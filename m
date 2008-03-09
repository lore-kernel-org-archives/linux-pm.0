From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] cpuidle: avoid singing capacitors
Date: Sun, 9 Mar 2008 19:19:24 +0100
Message-ID: <200803091919.25465.rjw__23481.3960422345$1205086959$gmane$org@sisk.pl>
References: <924EFEDD5F540B4284297C4DC59F3DEEA2E8B2@orsmsx423.amr.corp.intel.com>
	<20080306092730.4412d085@mjolnir.drzeus.cx>
	<20080309151659.63d54f38@mjolnir.drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080309151659.63d54f38@mjolnir.drzeus.cx>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: LKML <linux-kernel@vger.kernel.org>, Adam Belay <abelay@novell.com>, Andi Kleen <andi@firstfloor.org>, linux-pm@lists.linux-foundation.org, Lee Revell <rlrevell@joe-job.com>
List-Id: linux-pm@vger.kernel.org

On Sunday, 9 of March 2008, Pierre Ossman wrote:
> I'm beginning to think this is a lost cause. I've tried several variants, all without satisfactory results.
> 
> In case anyone else has any more ideas, I'll detail what I've found influences the noise:
> 
> 1. C state
> 
> This is the big one. There is no noise as long as C3 is avoided (processor.max_cstate).
> 
> 2. uhci_hcd driver
> 
> USB is somehow involved in this problem. Unloading the uhci_hcd driver almost
> entirely kills the noise on a 1000 HZ NO_HZ kernel. On a 100 HZ, no NO_HZ
> kernel, the effect is very small, but still there.  
> 
> 3. Low speed USB devices
> 
> Related, the noise goes away if I insert a USB mouse (low speed).
> A high-speed device does not effect the noise, neither does the two built-in
> low speed devices (a fingerprint reader and a bluetooth host).  
> 
> 4. Battery and AC
> 
> The noise increases with the battery present and also when the AC supply is
> removed. 
> 
> 5. Second core
> 
> Disabling the second core makes the noise go away. This might be
> a subset of 1., as I've been told that a stopped core enters C1. 
> 
> 
> Changing HZ and NO_HZ has no noticeable effect on the problem (except
> the odd behaviour in 2.). This is further supported by the fact that Windows
> also has the problem (which should behave close to 100 HZ without NO_HZ).  
> 
> 
> So for now, the only viable workaround is processor.max_cstate....

Well, there may be some users willing to trade some battery life for having a
quiet box. :-)

Perhaps it's worth documenting?

Thanks,
Rafael
