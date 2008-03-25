From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re:
	=?iso-8859-1?q?=5BRFC=5D=5BPATCH=5D_PM=3A_Introduce_ne?=
	=?iso-8859-1?q?w_top_level_suspend=09and_hibernation_callbacks_=28?=
	=?iso-8859-1?q?rev=2E_2=29?=
Date: Tue, 25 Mar 2008 21:56:11 +0100
Message-ID: <200803252156.12185.rjw__18739.5839406692$1206478951$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0803251030220.4838-100000@iolanthe.rowland.org>
	<200803252141.49049.rjw@sisk.pl>
	<200803252149.37552.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200803252149.37552.oliver@neukum.org>
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
To: Oliver Neukum <oliver@neukum.org>
Cc: LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-pm@lists.linux-foundation.org, Alexey Starikovskiy <astarikovskiy@suse.de>, Johannes Berg <johannes@sipsolutions.net>
List-Id: linux-pm@vger.kernel.org

On Tuesday, 25 of March 2008, Oliver Neukum wrote:
> Am Dienstag, 25. M=E4rz 2008 21:41:48 schrieb Rafael J. Wysocki:
> > On Tuesday, 25 of March 2008, Oliver Neukum wrote:
> > > Am Dienstag, 25. M=E4rz 2008 15:33:22 schrieb Alan Stern:
> > > > > so I'd say a
> > > > > failure to resume is just a limited subcase of a device vanishing=
 during
> > > > > sleep.
> > > > =

> > > > I'll go along with that. =A0If a device vanishes during sleep, the =
PM =

> > > > core isn't responsible for unregistering it -- the device's subsyst=
em =

> > > > is.
> > > =

> > > Yes, that makes sense. You are right.
> > =

> > Still, if ->resume() returns an error, does it make sense, from the PM =
core's
> > point of view, to execute ->complete() for that device, for example?
> =

> IMO you must always keep the ordering invariant. If a parent returns an e=
rror
> the PM core must not wake its children.

I'm agreeing here, but one of the previous Alan's comments suggests he has a
differing opinion.  Alan?

I'm considering to make the PM core skip the resuming of the children of
devices that failed to resume and skip calling ->complete() for that devices
and their children.

Thanks,
Rafael
