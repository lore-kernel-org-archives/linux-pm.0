From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] apm: orphan the driver
Date: Sat, 26 Mar 2011 17:22:04 +1100
Message-ID: <20110326172204.05e52c10.sfr__33447.9824793108$1301120604$gmane$org@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linus <torvalds@linux-foundation.org>
Cc: Ingo Molnar <mingo@elte.hu>, x86@kernel.org, LKML <linux-kernel@vger.kernel.org>, Andi Kleen <andi@firstfloor.org>, Thomas Gleixner <tglx@linutronix.de>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, "H. Peter Anvin" <hpa@zytor.com>, Ondrej Zary <linux@rainbow-software.org>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org


Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 MAINTAINERS |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

I no longer have access to any hardware that uses APM and have not
provided real maintenance for several years.  Hopefully someone with the
hardware or energy will step forward if the driver is to be kept.

diff --git a/MAINTAINERS b/MAINTAINERS
index 749f9cd..61f9948 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -548,10 +548,8 @@ S:	Maintained
 F:	sound/aoa/
 
 APM DRIVER
-M:	Stephen Rothwell <sfr@canb.auug.org.au>
 L:	linux-laptop@vger.kernel.org
-W:	http://www.canb.auug.org.au/~sfr/
-S:	Supported
+S:	Orphan
 F:	arch/x86/kernel/apm_32.c
 F:	include/linux/apm_bios.h
 
-- 
1.7.4.1

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
