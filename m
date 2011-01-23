From: Dave Airlie <airlied@linux.ie>
Subject: Re: Occasional (too common) suspend problem
Date: Sun, 23 Jan 2011 01:02:16 +0000 (GMT)
Message-ID: <alpine.DEB.2.00.1101230059220.13826__49757.0312618793$1295744712$gmane$org@skynet.skynet.ie>
References: <AANLkTikBRf00H_6YcS9nsnJG68WguDzL_AvNTRyDWRY=@mail.gmail.com>
	<AANLkTi=Tkf9MYmSmCX6CZ9Ymgqo8S1HmRkBn+Uvr2KUb@mail.gmail.com>
	<AANLkTikv55eQfNaCGLm-2pA3Ndyi9ZEzb4xn64D3u0ww@mail.gmail.com>
	<201101221110.17786.rjw@sisk.pl>
	<AANLkTik2sUJb9G5sA_Zr9_Q1=rJdYkgRe-MgTb0zhwc2@mail.gmail.com>
	<AANLkTikJVFEOgD_i+ghFupJksy2X_G1outhMmhPbP1Yd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTikJVFEOgD_i+ghFupJksy2X_G1outhMmhPbP1Yd@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jeff Chua <jeff.chua.linux@gmail.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, Chris Wilson <chris@chris-wilson.co.uk>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sat, 22 Jan 2011, Linus Torvalds wrote:

> code, and I'm hereby adding some of the i915 people to the mix.
> Because one of the main things that the pm-suspend scripts do is
> things like
> 
>         local con
>         for con in /sys/class/graphics/*/state; do
>                 [ -f $con ] || continue
>                 echo 1 >"${con}"
>         done

These caused me problems before esp when lockdep was setting 
oops_in_progress, but I repaired that and if X is running the VT 
should be in graphics mode and these end up doing nothing. Though there 
could be a race.

With -rc2 on my Thinkpad T60p, radeon r500 GPU, Intel T2500 (2 core), I 
just got a reboot on resume, after a pm-suspend. I'll do some more 
experiments later if I get some time.

does pm-suspend work from init 3? if not does nomodeset init 3 work?

Dave.
