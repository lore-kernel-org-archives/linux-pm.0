From: Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Thu, 05 Jul 2007 10:17:17 +0200
Message-ID: <E1I6MWb-0008Tq-00__3828.43517368219$1183623633$gmane$org@dorka.pomaz.szeredi.hu>
References: <18059.10554.955290.148535@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.44L0.0707041045150.25704-100000@netrider.rowland.org>
	<18060.14856.824473.325660@cargo.ozlabs.ibm.com>
	<200707050858.03638.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <200707050858.03638.oliver@neukum.org> (message from Oliver
	Neukum on Thu, 5 Jul 2007 08:58:03 +0200)
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: oliver@neukum.org
Cc: mjg59@srcf.ucam.org, linux-kernel@vger.kernel.org, pavel@ucw.cz, johannes@sipsolutions.net, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

> > > I have discussed the benefits elsewhere. =C2=A0As for the deadlocks=
 -- do=20
> > > you still observe them if you use the version of the freezer which=20
> > > doesn't freeze kernel threads?
> >=20
> > In general the only way to guarantee there are no deadlocks is to
> > construct the graph of dependencies between tasks. =C2=A0Those depend=
encies
> > are not in practice observable from outside the tasks, so it is
> > virtually impossible to construct the graph.
>=20
> In which way can user space tasks depend on each other in a way that
> allows a them members of that cycle to be in uninterruptible sleep?

 - process A calls rename() on a fuse fs
 - process B, the fuse server, starts to process the rename request
 - process B is frozen before it can reply

Now process A is unfreezable.  We cannot make rename() restartable,
hence it cannot be interruptible.

Miklos
