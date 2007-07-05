From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Wakeup settings for USB hubs?
Date: Thu, 5 Jul 2007 15:51:36 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0707051546010.4198-100000@iolanthe.rowland.org>
References: <200707052118.59885.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200707052118.59885.oliver@neukum.org>
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
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 5 Jul 2007, Oliver Neukum wrote:

> Am Donnerstag, 5. Juli 2007 schrieb Alan Stern:
> > Allow me to rephrase. =A0You seem to be saying that /sys/.../power/wa=
keup=20
> > should be able to hold four different values:
> >=20
> > =A0=A0=A0=A0=A0=A0=A0=A01. always disabled
> > =A0=A0=A0=A0=A0=A0=A0=A02. always enabled
> > =A0=A0=A0=A0=A0=A0=A0=A03. enabled at runtime but not during system s=
leep
> > =A0=A0=A0=A0=A0=A0=A0=A04. enabled during system sleep but not at run=
time
> >=20
> > Right? =A0With the default being 3 (except for a few things like the=20
> > power button).
> >=20
> > Or maybe there should be two attribute files: wakeup (used during
> > system sleep) and wakeup_runtime (used for runtime suspend).
> >=20
> > Comments from anybody else?
>=20
> I am not sure we ever want to do runtime suspend without remote wakeup.

You mean the user shouldn't be able to disable remote wakeup during a
runtime suspend?  But what if the user wants to put the device to sleep
with no possibility of wakeup?

> If we want that then it is orthogonal to its value during system sleep.
> That would call for two attributes.

Another attribute can be added easily enough.

Dave, you created the original wakeup attribute.  What do you think=20
about adding a separate wakeup_runtime?  (At a minimum, perhaps you can=20
suggest a better name!)

Alan Stern
