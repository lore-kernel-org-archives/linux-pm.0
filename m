From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 1/8] PM: Add suspend block api.
Date: Mon, 3 May 2010 21:01:36 +0200
Message-ID: <20100503190136.GA4173__29859.8803849474$1272913479$gmane$org@ucw.cz>
References: <1272667021-21312-1-git-send-email-arve@android.com>
	<201005022210.54018.rjw@sisk.pl> <20100502205238.GC9051@elf.ucw.cz>
	<201005022329.48309.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201005022329.48309.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Len Brown <len.brown@intel.com>, linux-doc@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>, Magnus Damm <damm@igel.co.jp>, linux-pm@lists.linux-foundation.org, Wu Fengguang <fengguang.wu@intel.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> > > > As I explained before (and got no reply),  the proposed interface is
> > > > ugly. It uses one sysfs file to change semantics of another one.
> > > 
> > > In fact this behavior was discussed at the LF Collab Summit and no one
> > > involved had any problem with that.
> > 
> > Well, I explained why I disliked in previous mail in more details,
> 
> We do exactly the same thing with 'pm_test', so I'm not sure what the problem is.
> 
> > and neither you nor Arve explained why it is good solution.
> 
> Because it's less confusing.  Having two different attributes returning
> almost the same contents and working in a slightly different way wouldn't be
> too clean IMO.

No, I don't think it is similar to pm_test. pm_test is debug-only, and
orthogonal to state -- all combinations make sense.

With 'oportunistic > policy', state changes from blocking to
nonblocking (surprise!). Plus, it is not orthogonal:

(assume we added s-t-flash on android for powersaving... or imagine I
get oportunistic suspend working on PC --I was there with limited
config on x60).

policy: oportunistic forced

state: on mem disk

First disadvantage of proposed interface is that while 'opportunistic
mem' is active, I can't do 'forced disk' to save bit more power.

Next, not all combinations make sense.

oportunistic on == forced <nothing>

oportunistic disk -- probably something that will not be implemented
any time soon.

oportunistic mem -- makes sense.

forced on -- NOP

forced mem  -- makes sense.

forced disk -- makes sense.

So we have matrix of 7 possibilities, but only 4 make sense... IMO its confusing.



								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
