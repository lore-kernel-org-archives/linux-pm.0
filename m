From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/8] PM: Opportunistic suspend support.
Date: Thu, 27 May 2010 16:48:42 -0700
Message-ID: <20100527234841.GA8645__27805.2073474557$1275004236$gmane$org@core.coreip.homeip.net>
References: <AANLkTikFwznonORd42piWZvBv3oqqSj9odC9Jaud8o3x@mail.gmail.com>
	<Pine.LNX.4.44L0.1005262044001.6349-100000@netrider.rowland.org>
	<AANLkTingAiO8dkwnInc993PTyA63rV-WRvBIRlB2ChXs@mail.gmail.com>
	<20100527181333.GA8297@core.coreip.homeip.net>
	<AANLkTilu5us2sYmm_f422Z2gJ34ZmIF808yYRPXkLjme@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <AANLkTilu5us2sYmm_f422Z2gJ34ZmIF808yYRPXkLjme@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>
Cc: Len Brown <len.brown@intel.com>, Andi Kleen <ak@linux.intel.com>, linux-doc@vger.kernel.org, Kernel development list <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Tejun Heo <tj@kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Wu Fengguang <fengguang.wu@intel.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thu, May 27, 2010 at 04:36:28PM -0700, Arve Hj=F8nnev=E5g wrote:
> 2010/5/27 Dmitry Torokhov <dmitry.torokhov@gmail.com>:
> > On Wed, May 26, 2010 at 05:52:40PM -0700, Arve Hj=F8nnev=E5g wrote:
> >> 2010/5/26 Alan Stern <stern@rowland.harvard.edu>:
> >> > On Wed, 26 May 2010, Arve Hj=F8nnev=E5g wrote:
> >> >
> >> >> > I must be missing something. =A0In Arve's patch 1/8, if the syste=
m is in
> >> >> > opportunistic suspend, and a wakeup event occurs but no suspend
> >> >> > blockers get enabled by the handler, what causes the system to go=
 back
> >> >> > into suspend after the event is handled? =A0Isn't that a loop of =
some
> >> >> > sort?
> >> >> >
> >> >>
> >> >> Yes it is a loop. I think what you are missing is that it only loops
> >> >> repeatedly if the driver that aborts suspend does not use a suspend
> >> >> blocker.
> >> >
> >> > You mean "the driver that handles the wakeup event". =A0I was asking=
 what
> >> > happened if suspend succeeded and then a wakeup occurred. =A0But yes=
, if
> >> > a suspend blocker is used then its release causes another suspend
> >> > attempt, with no looping.
> >> >
> >> >> > And even if it isn't, so what? =A0What's wrong with looping behav=
ior?
> >> >>
> >> >> It is a significant power drain.
> >> >
> >> > Not in the situation I was discussing.
> >> >
> >>
> >> If you meant it spend most of the time suspended, then I agree. It
> >> only wastes power when a driver blocks suspend by returning an error
> >> from its suspend hook and we are forced to loop doing no useful work.
> >>
> >
> > If driver refuses to suspend that means there are events that need
> > processing. I fail to see why it would be called "looping doing no
> > useful work".
> =

> Because the useful work is done in another thread. All the loop does
> is check if the useful work has completed which most likely will slow
> down the useful work.

Or useful work could signal when it is done processing critical section.

> Blocking suspend with a suspend blocker until
> the useful work is done is more efficient.
> =


-- =

Dmitry
