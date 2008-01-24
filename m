From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] PM: invoke suspend notifications after
	console switch
Date: Thu, 24 Jan 2008 11:46:32 +1100
Message-ID: <1201135592.6815.14.camel@pasglop>
References: <1197853799.4885.7.camel@johannes.berg>
	<1199970876.3861.66.camel@johannes.berg> <20080111182042.GC4016@ucw.cz>
Reply-To: benh@kernel.crashing.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080111182042.GC4016@ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Len Brown <len.brown@intel.com>, Johannes Berg <johannes@sipsolutions.net>, linux-pm <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org


> Its pretty intrusive I'd say. And it is wrong; we'd prefer userspace
> to know what we are doing; if they are told we are suspending,
> userspace may be able to do something more clever than long console
> switch.
> 
> I'd prefer this not to go into mainline.

So you'd prefer mainline to be broken and X to lock up ? nice !

The console switch happens -anyway- with the current code right ? So we
aren't changing that.

However, (even today I believe), users of /dev/apm_bios, such as X, will
deadlock the VT subsystem if they get notified of the suspend before the
kernel initiated console switch happen (which can happen today if the
suspend is triggered by an APM application I -think- (to be verified)
and will happen more once Johannes next patch gets in which fixes a
regression of current APM emulation which doesn't notify user space when
the suspend isn't APM originated.

So this patch will fix it by console switching before notifying them,
which is by far the right way to go for now. In the future, we may have
smarter ways to handle that graphic subsystem (and smarter gfx drivers)
and may want to provide ways to totally disable the console switching,
but that's a separate issue. In fact, some distro already disable the
console switch in their kernels for various reasons.

But if we keep the console switch we have today, we need this patch to
make it work properly and not potentially deadlock with X.

Ben.
