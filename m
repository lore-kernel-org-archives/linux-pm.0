From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Re: Hibernation considerations
Date: Fri, 20 Jul 2007 16:12:31 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0707201608120.2546-100000__14905.5936410607$1184962400$gmane$org@iolanthe.rowland.org>
References: <200707202203.27849.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200707202203.27849.oliver@neukum.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Oliver Neukum <oliver@neukum.org>
Cc: David Lang <david@lang.hm>, LKML <linux-kernel@vger.kernel.org>, Milton Miller <miltonm@bga.com>, Ying Huang <ying.huang@intel.com>, linux-pm <linux-pm@lists.linux-foundation.org>, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

On Fri, 20 Jul 2007, Oliver Neukum wrote:

> Am Freitag 20 Juli 2007 schrieb Alan Stern:
> > Some drivers need the ability to schedule. =A0Some will need the abil=
ity=20
> > to allocate memory (although GFP_ATOMIC is probably sufficient). =A0S=
ome=20
> > will need timers to run.
>=20
> Some will have to request firmware. It can add up to some megabytes.
> In addition, if we don't freeze, some drivers, eg. video drivers, can
> do allocations in the megabyte range.
>=20
> It seems to me that without the freezer we will end up with many driver=
s
> needing a two step notification process. Furthermore there are requirem=
ents
> on the order of shutting down system facilities, eg. device addition mu=
st
> be stopped before drivers allocate firmware.

These are really separate issues, since they refer to things that have=20
to happen well before the memory snapshot is captured.

We already have a pre-suspend notification available for drivers that=20
need to allocate large amounts of memory.

You are correct about the need to delay/stop device addition.  I don't
know how this can be done in general; each code path calling
device_add() may have to be treated individually.

Alan Stern
