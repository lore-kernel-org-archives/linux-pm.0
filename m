From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] apm: orphan the driver
Date: Mon, 28 Mar 2011 16:05:14 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1103281604040.26754__33461.0663624064$1301321502$gmane$org@pobox.suse.cz>
References: <20110326172204.05e52c10.sfr@canb.auug.org.au>
	<alpine.LRH.2.00.1103281443240.8162@twin.jikos.cz>
	<20110329004438.d9e755ef.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110329004438.d9e755ef.sfr@canb.auug.org.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Ingo Molnar <mingo@elte.hu>, x86@kernel.org, LKML <linux-kernel@vger.kernel.org>, Andi Kleen <andi@firstfloor.org>, Thomas Gleixner <tglx@linutronix.de>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, "H. Peter Anvin" <hpa@zytor.com>, Ondrej Zary <linux@rainbow-software.org>, Andrew Morton <akpm@linux-foundation.org>, Linus <torvalds@linux-foundation.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Tue, 29 Mar 2011, Stephen Rothwell wrote:

> > I still have some hardware that uses APM and put a new 2.6 on it time 
> > to time, so I can take this driver over if you want to. According to 
> > git log it's really low effort anyway :)
> 
> If you want it, its yours :-)

Not really fighting for maintaining it actively, but can certainly give it 
some care when necessary.




From: Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH] APM: take over maintainership

Commit 04a6553f076 ("apm: orphan the driver") Orphaned the APM
driver as Stephen is not willing/able to maintain it any more.

As I still have some hardware that is using APM and running 2.6,
I can take it over.

Signed-off-by: Jiri Kosina <jkosina@suse.cz>
---
 MAINTAINERS |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8aa1cac..758a690 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -548,8 +548,9 @@ S:	Maintained
 F:	sound/aoa/
 
 APM DRIVER
-L:	linux-laptop@vger.kernel.org
-S:	Orphan
+M:	Jiri Kosina <jkosina@suse.cz>
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
 F:	arch/x86/kernel/apm_32.c
 F:	include/linux/apm_bios.h
 
-- 
1.7.3.1
