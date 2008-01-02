From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [ANNOUNCE] Userland suspend/hibernation tool v0.8
	released
Date: Wed, 2 Jan 2008 16:36:35 +0100
Message-ID: <200801021636.35851.rjw__45092.4684330404$1199288181$gmane$org@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
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
To: pm list <linux-pm@lists.linux-foundation.org>
Cc: suspend-devel List <suspend-devel@lists.sourceforge.net>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

New version 0.8 of the userland suspend/hibernation tools (aka uswsusp) has
been released.  The source code package is available for download at:

http://downloads.sourceforge.net/suspend/suspend-0.8.tar.gz

(changelog and release notes within).

The following utilities are included in the package (among other things):

s2ram
- Wrapper around the kernel's suspend-to-RAM mechanism allowing the user to
  perform some graphics adapter manipulations from the user land before
  suspending and after resuming that may help to bring the graphics (and the
  entire system) back to life after the resume.  Incorporates the functionality
  of vbetool and radeontool as well as some tricks of its own.  Includes a list
  of working hardware configurations along with the appropriate sets of
  operations to be performed to resume them successfully.

s2disk
- Saves hibernation images created by the kernel using the /dev/snapshot
  special device and its ioctl interface.  Supports image compression, image
  encryption (in particular, it is possible to use RSA to safely pass the
  session key information between s2disk and its resume counterpart)
  and splash-based graphical progress meters (bootsplash, splashy and fbsplash
  are supported).

s2both
- Saves a hibernation image like s2disk and then suspends the system to RAM
  like s2ram, allowing it to either resume from RAM, if the system memory is
  still powered, or resume from the hibernation image (still considered as
  experimental).

resume
- Loads a hibernation image saved by s2disk/s2both and makes the kernel restore
  the system memory state from it using the /dev/snapshot special device and
  its ioctl interface.  Intended for running from initrd/initramfs images.
