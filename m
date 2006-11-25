From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH -mm] PM: Change ordering of suspend and
	resume code
Date: Sat, 25 Nov 2006 22:10:57 +0100
Message-ID: <200611252210.58203.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
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
Cc: suspend-devel List <suspend-devel@lists.sourceforge.net>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

Hi,

The discussion in a recent thread on Linux-PM has indicated that it's
necessary to call pm_ops->finish() before devce_resume(),
but enable_nonboot_cpus() has to be called before pm_ops->finish()
(cf. http://lists.osdl.org/pipermail/linux-pm/2006-November/004164.html).
For consistency, it seems reasonable to call disable_nonboot_cpus() after
device_suspend().

This way the suspend code will remain symmetrical with respect to the resume
code and it may allow us to speed up things in the future by suspending and
resuming devices and/or saving the suspend image in many threads, but for this
purpose we first need to make freeze_processes() SMP-safe.

The following series of patches makes freeze_processes() SMP-safe and
reorders the suspend and resume code so that nonboot CPUs are disabled
after devices have been suspended and enabled before the devices are
resumed.  It also causes pm_ops->finish() to be called after
enable_nonboot_cpus() wherever necessary.

The first four patches have been tested on two different x86-64 SMP boxes and
they don't seem to break anything.  Still, if anyone can test them on some other
SMP boxes (especially on i386 ones), please do so and tell me if there are
any problems.

The last patch is untested.

All of the patches are against 2.6.19-rc6-mm1.

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
