From: Frans Pop <elendil@planet.nl>
Subject: [PATCH 00/16] remove trailing spaces in messages
Date: Sat, 6 Feb 2010 18:44:36 +0100
Message-ID: <201002061844.45212.elendil__4067.47303572974$1265478455$gmane$org@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
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
To: linux-kernel@vger.kernel.org
Cc: linux-mips@linux-mips.org, linux-m68k@vger.kernel.org, linux-ia64@vger.kernel.org, Roman Zippel <zippel@linux-m68k.org>, linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>, sparclinux@vger.kernel.org, linux-s390@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, Helge Deller <deller@gmx.de>, x86@kernel.org, Ingo Molnar <mingo@elte.hu>, Fenghua Yu <fenghua.yu@intel.com>, Mike Frysinger <vapier@gentoo.org>, user-mode-linux-devel@lists.sourceforge.net, microblaze-uclinux@itee.uq.edu.au, Jeff Dike <jdike@addtoit.com>, linux-pm@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, Michal Simek <monstr@monstr.eu>, Tony Luck <tony.luck@intel.com>, Jiri Kosina <trivial@kernel.org>, linux-cris-kernel@axis.com, linux-parisc@vger.kernel.org, Ralf Baechle <ralf@linux-m>
List-Id: linux-pm@vger.kernel.org

This is a first series of patches to remove trailing spaces in messages. 
Patches cover arch-specific code plus one fix for PM and one in 
Documentation. Depending on how this series is received I'll continue
with other parts of the kernel.

Benefits are:
- general cleanup and consistency
- minor reduction in kernel size and user's log file size
- reduced annoyance for people writing logcheck rules

The patch for m68k has been rebased against linux-next; all other
patches apply against both mainline and -next (as of 5-2).

Shortstat:
 74 files changed, 135 insertions(+), 136 deletions(-)

Frans Pop (16):
      alpha: remove trailing spaces in messages
      arm: remove trailing spaces in messages
      ia64: remove trailing space in messages
      m68k: remove trailing space in messages
      microblaze: remove trailing space in messages
      mips: remove trailing space in messages
      parisc: remove trailing space in messages
      s390: remove trailing space in messages
      sparc: remove trailing space in messages
      x86: remove trailing space in messages
      blackfin: remove trailing space in messages
      cris/trivial: remove trailing space in message
      powerpc: remove trailing space in messages
      um: remove trailing space in messages
      PM: remove trailing space in message
      trivial: remove trailing space in spidev test program
