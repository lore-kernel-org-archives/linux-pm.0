From: Florian Mickler <florian@mickler.org>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Wed, 2 Jun 2010 21:47:48 +0200
Message-ID: <20100602214748.7742e3ae__4875.26462316072$1275508125$gmane$org@schatten.dmk.lab>
References: <20100527232357.6d14fdb2@lxorguk.ukuu.org.uk>
	<20100601135102.GA8098@srcf.ucam.org>
	<1275426085.21962.967.camel@mulgrave.site>
	<201006020024.14220.rjw@sisk.pl>
	<1275431816.21962.1108.camel@mulgrave.site>
	<AANLkTikObnAZbyOxeYAhXcEbimO3XTTO-HlC9CD_HH6t@mail.gmail.com>
	<1275451342.21962.1777.camel@mulgrave.site>
	<AANLkTilRcFZyYa-0HlaM-6IEZSyar3S9S_cCWSFax2Zo@mail.gmail.com>
	<1275491111.2799.110.camel@mulgrave.site>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1275491111.2799.110.camel@mulgrave.site>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: James Bottomley <James.Bottomley@suse.de>
Cc: tytso@mit.edu, Neil Brown <neilb@suse.de>, felipe.balbi@nokia.com, LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Linux@smtp1.linux-foundation.org, mark.gross@intel.com, Thomas Gleixner <tglx@linutronix.de>, Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

On Wed, 02 Jun 2010 10:05:11 -0500
James Bottomley <James.Bottomley@suse.de> wrote:

> On Tue, 2010-06-01 at 21:41 -0700, Arve Hj=F8nnev=E5g wrote:
> > No, they have to be two separate constraints, otherwise a constraint
> > to block suspend would override a constraint to block a low power idle
> > mode or the other way around.
> =

> Depends.  If you block the system from going into low power idle, does
> that mean you still want it to be fully suspended?
> =

> If yes, then we do have independent constraints.  If not, they have a
> hierarchy:
> =

>       * Fully Interactive (no low power idle or suspend)
>       * Partially Interactive (may go into low power idle but not
>         suspend)
>       * None (may go into low power idle or suspend)
> =

> Which is expressable as a ternary constraint.
> =

> James
> =


But unblocking suspend at the moment is independent to getting idle.
If you have the requirement to stay in the highest-idle level (i.e.
best latency you can get) that does not (currently) mean, that you can
not suspend.

To preserve that explicit fall-through while still having working
run-time-powermanagement I think the qos-constraints need to be
separated. =


<disclaimer: just from what I read>
Provided you can reach the same power state from idle, current suspend
could probably also be implemented by just the freezing part and a hint
to the idle-loop to provide accelerated fall-through to lowest power. =

</disclaimer>

At that point, you could probably merge the constraints. =


But the freezing part is also the hard part, isn't it? (I have no
idea. Thomas seems to think about cgroups for that and doing smth about the=
 timers.)

Cheers,
Flo
