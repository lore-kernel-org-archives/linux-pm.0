From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH -mm] PM: Change ordering of suspend and
	resume code
Date: Sun, 17 Dec 2006 18:58:15 +0100
Message-ID: <200612171858.16380.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <suspend-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/suspend-devel>,
	<mailto:suspend-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=suspend-devel>
List-Post: <mailto:suspend-devel@lists.sourceforge.net>
List-Help: <mailto:suspend-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/suspend-devel>,
	<mailto:suspend-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: suspend-devel-bounces@lists.sourceforge.net
Errors-To: suspend-devel-bounces@lists.sourceforge.net
To: pm list <linux-pm@lists.osdl.org>
Cc: suspend-devel List <suspend-devel@lists.sourceforge.net>, linux-acpi@vger.kernel.org, Stefan Seyfried <seife@suse.de>, Stephen Hemminger <shemminger@osdl.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

Hi,

As indicated in a recent thread on Linux-PM, it's necessary to call
pm_ops->finish() before devce_resume(), but enable_nonboot_cpus() has to be
called before pm_ops->finish()
(cf. http://lists.osdl.org/pipermail/linux-pm/2006-November/004164.html).
For consistency, it seems reasonable to call disable_nonboot_cpus() after
device_suspend().

This way the suspend code will remain symmetrical with respect to the resume
code and it may allow us to speed up things in the future by suspending and
resuming devices and/or saving the suspend image in many threads.

The following series of patches reorders the suspend and resume code so that
nonboot CPUs are disabled after devices have been suspended and enabled bef=
ore
the devices are resumed. =A0It also causes pm_ops->finish() to be called af=
ter
enable_nonboot_cpus() wherever necessary.

The first patch changes the ordering of the suspend-to-RAM code and is
untested, because my boxes continue refusing to resume from RAM for other
reasons.  If anyone can, please do me a favour and test it.

The second patch changes the ordering of the built-in suspend-to-disk code,
and the last two patches modify the swsusp userland interface code
accordingly.  As far as the last patch is concerned, I've decided to change
the existing ioctls, so that the patched kernel works with the "old" userla=
nd.
I don't think this change breaks anything of importance, but if it does, we
can just add (yet) another ioctl to set the platform mode, although in that
case the userland would have to be changed as well.

All of the patches are against 2.6.20-rc1 and should not be used with any
earlier kernel.

Greetings,
Rafael


-- =

If you don't have the time to read,
you don't have the time or the tools to write.
		- Stephen King


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
