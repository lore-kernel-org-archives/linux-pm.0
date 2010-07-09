From: Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.35-rc4-git3: Reported regressions from 2.6.34
Date: Fri, 9 Jul 2010 09:11:31 +0200
Message-ID: <20100709071131.GB10743__24898.8798623488$1278659614$gmane$org@elte.hu>
References: <-IGZ64uxA6G.A.P0H.bLmNMB@chimera>
	<AANLkTiknnzWyVpqnPCpyiEVHLgkewd0zaGzLInABRe2G@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <AANLkTiknnzWyVpqnPCpyiEVHLgkewd0zaGzLInABRe2G@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linus Torvalds <torvalds@linux-foundation.org>, "Paul E. McKenney" <paulmck@us.ibm.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jens Axboe <axboe@kernel.dk>, DRI <dri-devel@lists.sourceforge.net>, Linux SCSI List <linux-scsi@vger.kernel.org>, Patrick McHardy <kaber@trash.net>, Network Development <netdev@vger.kernel.org>, Linux Wireless List <linux-wireless@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, "David S. Miller" <davem@davemloft.net>, Linux ACPI <linux-acpi@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, Frederic Weisbecker <fweisbec@gmail.com>, Dave Airlie <airlied@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Kernel Testers List <kernel-testers@vger.kernel.org>, Shawn Starr <shawn.starr@rogers.com>, Linux PM List <linux-pm@lists.linux-foundation.org>, Maciej Rutecki <maciej.rutecki@gmail.c>
List-Id: linux-pm@vger.kernel.org


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> > Bug-Entry ? ? ? : http://bugzilla.kernel.org/show_bug.cgi?id=16346
> > Subject ? ? ? ? : 2.6.35-rc3-git8 - include/linux/fdtable.h:88 invoked rcu_dereference_check() without protection!
> > Submitter ? ? ? : Miles Lane <miles.lane@gmail.com>
> > Date ? ? ? ? ? ?: 2010-07-04 22:04 (5 days old)
> > Message-ID ? ? ?: <AANLkTinof0k28rk4rMr66aubxcRL2rFa5ZEArj1lqD3o@mail.gmail.com>
> > References ? ? ?: http://marc.info/?l=linux-kernel&m=127828107815930&w=2
> 
> I'm not entirely sure if these RCU proving things should count as 
> regressions.

Generally not - and we've delayed at least one more complex (cgroups) fix to 
v2.6.36 because the patch itself was riskier than the warning.

Still most of the warning fixes turned out to be simple, so we merged the 
very-low-risk ones and right now we seem to be on top of them.

But in general the default rule is that we delay these fixes to v2.6.36.

> Sure, the option to enable RCU proving is new, but the things it reports 
> about generally are not new - and they are usually not even bugs in the 
> sense that they necessarily cause any real problems.
> 
> That particular one is in the single-thread optimizated case for fget_light, ie
> 
>         if (likely((atomic_read(&files->count) == 1))) {
>                 file = fcheck_files(files, fd);
> 
> where I think it should be entirely safe in all ways without any locking. So 
> I think it's a false positive too.

Yeah, it's a bit like with lockdep (and it's a bit like with compiler warning 
fixes): we had to punch through a large stack of false positives that 
accumulated in the past 10 years.

( Because real bugs eventually get fixed, while false positives always just
  accumulate. So almost by definition we always start with a very assymetric
  collection of warnings and a large stack of false positives. )

Having said that, it appears we got most of the false positives and are 
beginning to be in a more representative equilibrium now. If v2.6.35 isnt 
going to be warning-free then v2.6.36 certainly will be and new warnings will 
have a much higher likelyhood of being real (and new) bugs (not just 
accumulated false-positives).

	Ingo
