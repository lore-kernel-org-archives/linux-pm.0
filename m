From: Florian Mickler <florian@mickler.org>
Subject: Re: [PATCH 1/8] PM: Opportunistic suspend support.
Date: Wed, 26 May 2010 11:23:03 +0200
Message-ID: <20100526112303.3fef15a4__46855.1842066974$1274865937$gmane$org@schatten.dmk.lab>
References: <Pine.LNX.4.44L0.1005251647530.1634-100000@iolanthe.rowland.org>
	<201005252344.37639.rjw@sisk.pl>
	<AANLkTimL5rU5lALezEZVCwdcZL85tVahhsTibdpq9s-Y@mail.gmail.com>
	<1274863342.5882.4850.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1274863342.5882.4850.camel@twins>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Greg KH <gregkh@suse.de>, linux-doc@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>, Maxim@smtp1.linux-foundation.org, Matthew@smtp1.linux-foundation.org, Pavel@smtp1.linux-foundation.org, Andi Kleen <ak@linux.intel.com>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Len Brown <len.brown@intel.com>, Dmitry@smtp1.linux-foundation.org, tytso@mit.edu, Torokhov <dmitry.torokhov@gmail.com>, Kernel development list <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Wu Fengguang <fengguang.wu@intel.com>
List-Id: linux-pm@vger.kernel.org

On Wed, 26 May 2010 10:42:22 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Tue, 2010-05-25 at 15:33 -0700, Arve Hj=F8nnev=E5g wrote:
> > The biggest problem here is not that it is hard to change our
> > user-space, but that the proposed change is inferior to what we have
> > now. It forces us to poll until all drivers stop aborting suspend. On
> > one hand we have people telling us that all code that polls is broken
> > and must be fixed (instead of suspending to limit the damage), and on
> > the other hand we have people suggesting we implement opportunistic
> > suspend by polling from user-space until suspend succeeds. =

> =

> No it does _not_. You're really not getting that Dmitry is proposing.
> =

> =

> So your proposal is that when we wake userspace, it
> opens /dev/suspend_blocker _before_ it consumes whatever event, consumes
> the event, deals with the event, then closes the suspend_blocker. Then
> the kernel, upon reaching a 0 suspend_blocker count, will try to suspend
> again.
> =

> =

> What Dmitry proposes is that, the app _before_ it consumes the event,
> pokes at this suspend manager, it increases a blocker count, then
> consumes the event (the kernel will _not_ auto-suspend), handles it and
> then again pokes the suspend manager, this time decreasing the blocker
> count.
> =

> The suspend manager will, upon reaching a 0 block count, suspend the
> machine. If that fails, it means there's something to do, an app will
> inc, work, dec its count, and it will try again once it reaches 0 again.
> =

> There is no polling what-so-ever in this model.
> =

> The only thing is that the kernel will not try to auto-suspend and there
> is no user-space suspend blocker API.

There is polling, because the suspend manager in userspace doesn't have
the whole picture. i.e. it doesn't know if a suspend will be
successfull. =

So for aggressive suspending as a powersave-feature you need to poll
(i.e. retry upon failure). because you don't want to stay unsuspended. =


This discussion really is going in circles. You could all may well be
just posting references to postings by now, instead of actually writing
mails.

Cheers,
Flo
