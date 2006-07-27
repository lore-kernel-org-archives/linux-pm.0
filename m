From: "Gross, Mark" <mark.gross@intel.com>
Subject: Re: [RFC] PowerOP Take 3, sysfs UI core 2/5
Date: Wed, 26 Jul 2006 17:14:41 -0700
Message-ID: <5389061B65D50446B1783B97DFDB392D01F92E25@orsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-class: urn:content-classes:message
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Eugeny S. Mints" <eugeny.mints@gmail.com>, linux-pm@lists.osdl.org
Cc: "Mochel, Patrick" <patrick.mochel@intel.com>, Matthew Locke <matt@nomadgs.com>, sampsa.fabritius@nokia.com, linux@dominikbrodowski.net
List-Id: linux-pm@vger.kernel.org



>-----Original Message-----
>From: Eugeny S. Mints [mailto:eugeny.mints@gmail.com]
>Sent: Thursday, July 20, 2006 12:56 PM
>To: linux-pm@lists.osdl.org
>Cc: Matthew Locke; toddpoynor@gmail.com; linux@dominikbrodowski.net;
Gross, Mark;
>igor.stoppa@nokia.com; amit.kucheria@nokia.com;
sampsa.fabritius@nokia.com; r-woodruff2@ti.com;
>Mochel, Patrick
>Subject: [RFC] PowerOP Take 3, sysfs UI core 2/5
>
>A sysfs interface for PowerOP that allows operating points to be
created
>and activated from userspace.
>
>The platform-specific backend provides the code to read and write sysfs
>attributes for each power parameter; the core sysfs interface has no
>knowledge of the struct powerop_point contents.  This interface could
be
>seen as possible extension of cpufreq sysfs.  It is not
>an integral part of PowerOP and is provided in part to facilitate
>discussion and experimentation with PowerOP, but could serve as a basis
>for a basic userspace power policy management stack.
>
>Operating points are created by writing the name of the operating point
>to /sys/powerop/new.  This may be a job for configfs.

Why create a new top level sysfs entry?  Can't we just put power op
under /sys/devices/platform or /sys/power ?

>/sys/powerop/<op>/ will contain an attribute for each power parameter
>that may be written to set the associated parameter for the new
>operating point.  An operating point may be activated by writing its
>name to /sys/powerop/active.  The hardware power parameters currently
>set may be read and written via /sys/powerop/hw/, a special operating
>point that reads and writes parameter attribute values immediately,
>primarily for diagnostic purposes.

Whaaa?  Is this for creating named operating points like say,
full_speed, deep_idle, pay_back, ui points, that could be activated by
echoing their name to /sys/powerop/active ?

These aren't new points, just named existing ones.  Right?


>Buried in this interface is also the notion of a registry of "named
>operating points", allowing operating points created by some other
>interface (such as cpufreq or loading a module with the definitions as
>suggested previously by David Brownell) to be activated from userspace
>via /sys/powerop/active.

Would it make more sense to echo "active" to the named <op> sysfs node?

>
>Please note that the interface is not hooked up with the rest of the
code
>yet and is provided just for reference/review.
