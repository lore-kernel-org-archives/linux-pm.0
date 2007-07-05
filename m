From: Oliver Neukum <oliver@neukum.org>
Subject: Re: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Thu, 5 Jul 2007 08:58:03 +0200
Message-ID: <200707050858.03638.oliver__1685.52709878913$1183618813$gmane$org@neukum.org>
References: <18059.10554.955290.148535@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.44L0.0707041045150.25704-100000@netrider.rowland.org>
	<18060.14856.824473.325660@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <18060.14856.824473.325660@cargo.ozlabs.ibm.com>
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
To: Paul Mackerras <paulus@samba.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Kernel development list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, Johannes Berg <johannes@sipsolutions.net>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Am Donnerstag, 5. Juli 2007 schrieb Paul Mackerras:
> > I have discussed the benefits elsewhere. =A0As for the deadlocks -- d=
o=20
> > you still observe them if you use the version of the freezer which=20
> > doesn't freeze kernel threads?
>=20
> In general the only way to guarantee there are no deadlocks is to
> construct the graph of dependencies between tasks. =A0Those dependencie=
s
> are not in practice observable from outside the tasks, so it is
> virtually impossible to construct the graph.

In which way can user space tasks depend on each other in a way that
allows a them members of that cycle to be in uninterruptible sleep?

	Regards
		Oliver
