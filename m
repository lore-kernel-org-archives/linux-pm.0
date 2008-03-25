From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC][PATCH] PM: Introduce new top level suspend and
 hibernation callbacks (rev. 3)
Date: Tue, 25 Mar 2008 10:24:03 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0803251020530.4838-100000__1991.5941441015$1206455195$gmane$org@iolanthe.rowland.org>
References: <200803251437.17268.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200803251437.17268.oliver@neukum.org>
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
Cc: LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Alexey Starikovskiy <astarikovskiy@suse.de>
List-Id: linux-pm@vger.kernel.org

On Tue, 25 Mar 2008, Oliver Neukum wrote:

> Am Dienstag, 25. M=E4rz 2008 13:40:53 schrieb Rafael J. Wysocki:
> > On Tuesday, 25 of March 2008, Oliver Neukum wrote:
> > > Am Montag 24 M=E4rz 2008 schrieb Rafael J. Wysocki:
> =

> > > > + *=A0=A0=A0=A0=A0after @prepare() returns. =A0If @prepare() detect=
s a situation it cannot
> > > > + *=A0=A0=A0=A0=A0handle (e.g. registration of a child already in p=
rogress), it may return
> > > > + *=A0=A0=A0=A0=A0-EAGAIN, so that the PM core can execute it once =
again (e.g. after the
> > > > + *=A0=A0=A0=A0=A0new child has been registered) to recover from th=
e race condition. This
> > > > + *=A0=A0=A0=A0=A0method is executed for all kinds of suspend trans=
itions and is followed
> > > > + *=A0=A0=A0=A0=A0by one of the suspend callbacks: @suspend(), @fre=
eze(), or @poweroff().
> > > =

> > > This could be understood so that disconnect() cannot be called.
> > =

> > At what time exactly?
> =

> I see no locking that would would prevent disconnect() in the window betw=
een
> prepare() and suspend()/...

There is no such locking.  It's perfectly legal for a device to be =

unregistered between prepare() and suspend().  I suppose it wouldn't =

hurt to add a general comment explaining that a device can be =

unregistered at any time except when one of its methods is running.

Alan Stern
