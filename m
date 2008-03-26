From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re:
 =?iso-8859-1?q?=5BRFC=5D=5BPATCH=5D_PM=3A_Introduce_ne?=
 =?iso-8859-1?q?w_top_level_suspend=09and_hibernation_callbacks_=28rev=2E_?=
 =?iso-8859-1?q?2=29?=
Date: Wed, 26 Mar 2008 10:10:01 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0803261003540.4755-100000__26524.7510084466$1206541160$gmane$org@iolanthe.rowland.org>
References: <200803252156.12185.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200803252156.12185.rjw@sisk.pl>
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
Cc: LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-pm@lists.linux-foundation.org, Alexey Starikovskiy <astarikovskiy@suse.de>, Johannes Berg <johannes@sipsolutions.net>
List-Id: linux-pm@vger.kernel.org

On Tue, 25 Mar 2008, Rafael J. Wysocki wrote:

> On Tuesday, 25 of March 2008, Oliver Neukum wrote:
> > Am Dienstag, 25. M=E4rz 2008 21:41:48 schrieb Rafael J. Wysocki:
> > > On Tuesday, 25 of March 2008, Oliver Neukum wrote:
> > > > Am Dienstag, 25. M=E4rz 2008 15:33:22 schrieb Alan Stern:
> > > > > > so I'd say a
> > > > > > failure to resume is just a limited subcase of a device vanishi=
ng during
> > > > > > sleep.
> > > > > =

> > > > > I'll go along with that. =A0If a device vanishes during sleep, th=
e PM =

> > > > > core isn't responsible for unregistering it -- the device's subsy=
stem =

> > > > > is.
> > > > =

> > > > Yes, that makes sense. You are right.
> > > =

> > > Still, if ->resume() returns an error, does it make sense, from the P=
M core's
> > > point of view, to execute ->complete() for that device, for example?
> > =

> > IMO you must always keep the ordering invariant. If a parent returns an=
 error
> > the PM core must not wake its children.

Don't think of it that way.  The PM core doesn't wake anything.  It
merely notifies drivers that the system sleep is ending, so that the
drivers can wake their devices.  It's up to the driver to detect
whether the parent failed to resume, in which case the driver should
take appropriate action.

The situation is no different from what happens when the user tries to =

access a mounted USB disk drive after the USB cable has been unplugged.  =

The drivers take care of everything.

> I'm agreeing here, but one of the previous Alan's comments suggests he ha=
s a
> differing opinion.  Alan?
> =

> I'm considering to make the PM core skip the resuming of the children of
> devices that failed to resume and skip calling ->complete() for that devi=
ces
> and their children.

While that might in principle be a reasonable thing to do, it's =

different from how the PM core has behaved in the past.  I don't see =

any point in making a change like that now.

Alan Stern
