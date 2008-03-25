From: Oliver Neukum <oliver@neukum.org>
Subject: Re:
	=?iso-8859-1?q?=5BRFC=5D=5BPATCH=5D_PM=3A_Introduce_ne?=
	=?iso-8859-1?q?w_top_level_suspend=09and_hibernation_callbacks_=28?=
	=?iso-8859-1?q?rev=2E_2=29?=
Date: Tue, 25 Mar 2008 15:24:33 +0100
Message-ID: <200803251524.34147.oliver__42774.7729038403$1206455231$gmane$org@neukum.org>
References: <Pine.LNX.4.44L0.0803251011110.4838-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0803251011110.4838-100000@iolanthe.rowland.org>
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
To: Alan Stern <stern@rowland.harvard.edu>
Cc: LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-pm@lists.linux-foundation.org, Alexey Starikovskiy <astarikovskiy@suse.de>, Johannes Berg <johannes@sipsolutions.net>
List-Id: linux-pm@vger.kernel.org

Am Dienstag, 25. M=E4rz 2008 15:19:45 schrieb Alan Stern:
> On Tue, 25 Mar 2008, Oliver Neukum wrote:
> =

> > Am Dienstag, 25. M=C3=A4rz 2008 14:06:15 schrieb Rafael J. Wysocki:
> > > On Tuesday, 25 of March 2008, Oliver Neukum wrote:
> > =

> > > > A device that cannot wake up is unusable. Shouldn't the pm core dis=
connect()
> > > > such a device?
> =

> It's not safe for the PM core to do such things unilaterally. =A0The =

> decision to unregister a device should be made by the driver or the =

> subsystem.

Why? You can trigger it from user space via sysfs and in many cases
suspending to disk will disconnect all devices on a bus, so I'd say a
failure to resume is just a limited subcase of a device vanishing during
sleep.

	Regards
		Oliver
