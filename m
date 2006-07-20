From: "Eugeny S. Mints" <eugeny.mints@gmail.com>
Subject: [RFC] PowerOP Take 3, sysfs UI core 2/5
Date: Thu, 20 Jul 2006 23:56:10 +0400
Message-ID: <c55240ed0607201256q2d902a0nd3e9e3fba4ac9dd8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
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
To: linux-pm@lists.osdl.org
Cc: patrick.mochel@intel.com, Matthew Locke <matt@nomadgs.com>, linux@dominikbrodowski.net, sampsa.fabritius@nokia.com
List-Id: linux-pm@vger.kernel.org

A sysfs interface for PowerOP that allows operating points to be created
and activated from userspace.

The platform-specific backend provides the code to read and write sysfs
attributes for each power parameter; the core sysfs interface has no
knowledge of the struct powerop_point contents.  This interface could be
seen as possible extension of cpufreq sysfs.  It is not
an integral part of PowerOP and is provided in part to facilitate
discussion and experimentation with PowerOP, but could serve as a basis
for a basic userspace power policy management stack.

Operating points are created by writing the name of the operating point
to /sys/powerop/new.  This may be a job for configfs.
/sys/powerop/<op>/ will contain an attribute for each power parameter
that may be written to set the associated parameter for the new
operating point.  An operating point may be activated by writing its
name to /sys/powerop/active.  The hardware power parameters currently
set may be read and written via /sys/powerop/hw/, a special operating
point that reads and writes parameter attribute values immediately,
primarily for diagnostic purposes.

Buried in this interface is also the notion of a registry of "named
operating points", allowing operating points created by some other
interface (such as cpufreq or loading a module with the definitions as
suggested previously by David Brownell) to be activated from userspace
via /sys/powerop/active.

Please note that the interface is not hooked up with the rest of the code
yet and is provided just for reference/review.
