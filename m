From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 2.6.18-rc2-mm 1/2] PM: make
	/sys/devices/.../power/state optional
Date: Wed, 16 Aug 2006 11:40:53 -0700
Message-ID: <200608161140.54035.david-b@pacbell.net>
References: <200607191337.02365.david-b@pacbell.net>
	<20060816115729.GB10764@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060816115729.GB10764@elf.ucw.cz>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Linus Torvalds <torvalds@osdl.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday 16 August 2006 4:57 am, Pavel Machek wrote:
> > Add a new PM_SYSFS_DEPRECATED config option to control whether or
> > not the /sys/devices/.../power/state files are provided. =A0...
> =

> Looks good to me, ACK.
> =

> (And sorry for long delay). =


Greg still hasn't merged it; so, no prob.  :)

I updated patch 2/2  so that it doesn't test for the problematic and
incomplete prepare_suspend() method, and to remove prepare_suspend().
(That removal was discussed separately.)



> I guess this should go with it...? OTOH andrew wanted alternative,
> first, before removing the feature... but it is unclear to me if we
> want the feature at all on the production system, so...

How about this one instead?  The issue is not limited to that sysfs
file and its use of PM_EVENT_* codes, that's just the most visible
facet of the problem.

- Dave

Index: o26/Documentation/feature-removal-schedule.txt
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- o26.orig/Documentation/feature-removal-schedule.txt	2006-07-30 22:08:10=
.000000000 -0700
+++ o26/Documentation/feature-removal-schedule.txt	2006-08-16 11:34:54.0000=
00000 -0700
@@ -6,6 +6,21 @@ be removed from this file.
 =

 ---------------------------
 =

+What:	/sys/devices/.../power/state
+	dev->power.power_state
+	dpm_runtime_{suspend,resume)()
+When:	July 2007
+Why:	Broken design for runtime control over driver power states, confusing
+	driver-internal runtime power management with:  mechanisms to support
+	system-wide sleep state transitions; event codes that distinguish
+	different phases of swsusp "sleep" transitions; and userspace policy
+	inputs.  This framework was never widely used, and most attempts to
+	use it were broken.  Drivers should instead be exposing domain-specific
+	interfaces either to kernel or to userspace, iff they are even needed.
+Who:	Pavel Machek <pavel@suse.cz>
+
+---------------------------
+
 What:	RAW driver (CONFIG_RAW_DRIVER)
 When:	December 2005
 Why:	declared obsolete since kernel 2.6.3
