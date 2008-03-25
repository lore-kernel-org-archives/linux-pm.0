From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re:
 =?iso-8859-1?q?=5BRFC=5D=5BPATCH=5D_PM=3A_Introduce_ne?=
 =?iso-8859-1?q?w_top_level_suspend=09and_hibernation_callbacks_=28rev=2E_?=
 =?iso-8859-1?q?2=29?=
Date: Tue, 25 Mar 2008 10:33:22 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0803251030220.4838-100000__19564.0779952102$1206455730$gmane$org@iolanthe.rowland.org>
References: <200803251524.34147.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200803251524.34147.oliver@neukum.org>
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

On Tue, 25 Mar 2008, Oliver Neukum wrote:

> Am Dienstag, 25. M=E4rz 2008 15:19:45 schrieb Alan Stern:

> > It's not safe for the PM core to do such things unilaterally. =A0The =

> > decision to unregister a device should be made by the driver or the =

> > subsystem.
> =

> Why? You can trigger it from user space via sysfs

How can you do that?

>  and in many cases
> suspending to disk will disconnect all devices on a bus,

But these disconnects aren't done by the PM core; they are done by =

individual drivers or subsystems.

> so I'd say a
> failure to resume is just a limited subcase of a device vanishing during
> sleep.

I'll go along with that.  If a device vanishes during sleep, the PM =

core isn't responsible for unregistering it -- the device's subsystem =

is.

Alan Stern
