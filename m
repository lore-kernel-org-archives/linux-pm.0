From: Florian Mickler <florian@mickler.org>
Subject: Re: suspend blockers & Android integration
Date: Fri, 4 Jun 2010 17:07:38 +0200
Message-ID: <20100604170738.75c7436e__35785.3059577339$1275664202$gmane$org@schatten.dmk.lab>
References: <20100603193045.GA7188@elte.hu>
	<AANLkTinsOF3wnxsruR0TvjBAQcHks4tf0ay_sM2xB_p4@mail.gmail.com>
	<20100604075722.GA15181@elte.hu>
	<AANLkTiksGnpL8tkcc5eScWHrGoijyZNUwZik5lXmU_TS@mail.gmail.com>
	<20100604085513.GE15181@elte.hu>
	<AANLkTinphtxn-8pGTYv_mBxKFMa7jU8i1yNbHrs50Vzl@mail.gmail.com>
	<20100604095917.GA3324@elte.hu>
	<1275661446.4455.33.camel@mulgrave.site>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1275661446.4455.33.camel@mulgrave.site>
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
Cc: Peter Zijlstra <peterz@infradead.org>, tytso@mit.edu, Peter Zijlstra <a.p.zijlstra@chello.nl>, Neil Brown <neilb@suse.de>, Brian Swetland <swetland@google.com>, LKML <linux-kernel@vger.kernel.org>, Felipe@smtp1.linux-foundation.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, Linux PM <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Balbi <felipe.balbi@nokia.com>
List-Id: linux-pm@vger.kernel.org

On Fri, 04 Jun 2010 09:24:06 -0500
James Bottomley <James.Bottomley@suse.de> wrote:

> On Fri, 2010-06-04 at 11:59 +0200, Ingo Molnar wrote:
> > Anyway, i'm not pessimistic at all: _some_ sort of scheme appears to be =

> > crystalising out today. Everyone seems to agree now that the main useca=
ses are =

> > indeed useful and need handling one way or another - the rest is really=
 just =

> > technological discussions how to achieve the mostly-agreed-upon end goa=
l.
> =

> It's still not clear to me whether everyone's revolving around to using
> the current suspend block API because it's orthogonal to all other
> mechanisms and is therefore separate from the kernel (and can be
> compiled out if you don't want it).  Or whether re-expressing what the
> android drivers want (minimum idle states and suspend block) in pm_qos
> terms which others can use is the way to go.  I think the latter, but
> I'd like to know what other people think (because I'm not wedded to this
> preference).

I'd like to know that also. =

I have a patch to add=A0pm_qos_add_request_nonblock function, so it is
possible to register an pm_qos constraint by passing preallocated
memory to it. =


Notifying should be possible to do from atomic contexts via
async_schedule()?

The scalability issues of pm_qos can be adressed by using plists for
all pm_qos_class'es. Or by having the different pm_qos_class'es provide
their own implementations for the update and get operations. =


Cheers,
Flo

> =

> James
> =
