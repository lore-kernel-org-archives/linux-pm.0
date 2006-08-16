From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [patch 2.6.18-rc2-mm 1/2] PM: make
	/sys/devices/.../power/state optional
Date: Wed, 16 Aug 2006 13:57:29 +0200
Message-ID: <20060816115729.GB10764@elf.ucw.cz>
References: <200607191337.02365.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <200607191337.02365.david-b@pacbell.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: David Brownell <david-b@pacbell.net>
Cc: Linus Torvalds <torvalds@osdl.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

HI!

> There seems to be a consensus on linux-pm that the sysfs power/state files
> are the wrong approach to userspace having control over runtime PM.  Not
> that there's agreement on what such controls _should_ look like, or even
> that there should be such controls for purposes other than testing...
> =

> So here's a patch that just makes it easy to get rid of this misfeature.
> It'll help flush out any userspace software that really thinks it needs t=
hat
> mechanism; PCMCIA seems to no longer be in that camp, it has it's own
> sysfs attribute.

> Add a new PM_SYSFS_DEPRECATED config option to control whether or
> not the /sys/devices/.../power/state files are provided.  This will
> make it easier to get rid of that mechanism when the time comes,
> and to verify that userspace tools work right without it.
> =

> Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

Looks good to me, ACK.

(And sorry for long delay). =


I guess this should go with it...? OTOH andrew wanted alternative,
first, before removing the feature... but it is unclear to me if we
want the feature at all on the production system, so...

Signed-off-by: Pavel Machek <pavel@suse.cz>

diff --git a/Documentation/feature-removal-schedule.txt b/Documentation/fea=
ture-removal-schedule.txt
index 87851ef..4902bef 100644
--- a/Documentation/feature-removal-schedule.txt
+++ b/Documentation/feature-removal-schedule.txt
@@ -6,6 +6,16 @@ be removed from this file.
 =

 ---------------------------
 =

+What:	/sys/device/.../power/state
+When:	July 2007
+Files:	=

+Why:	Because it takes integers, and different userland applications
+	expect different numbers to mean different things.
+	(Pcmcia expect 2 for off, some other code expects 3 for off).
+Who:	Pavel Machek <pavel@suse.cz>
+
+---------------------------
+
 What:	RAW driver (CONFIG_RAW_DRIVER)
 When:	December 2005
 Why:	declared obsolete since kernel 2.6.3

-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
