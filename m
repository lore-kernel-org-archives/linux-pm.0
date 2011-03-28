From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] apm: orphan the driver
Date: Mon, 28 Mar 2011 19:24:37 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1103281924010.26754__12796.694369945$1301333222$gmane$org@pobox.suse.cz>
References: <20110326172204.05e52c10.sfr@canb.auug.org.au>
	<alpine.LRH.2.00.1103281443240.8162@twin.jikos.cz>
	<20110329004438.d9e755ef.sfr@canb.auug.org.au>
	<alpine.LNX.2.00.1103281604040.26754@pobox.suse.cz>
	<1301321667.30628.21.camel@Joe-Laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1301321667.30628.21.camel@Joe-Laptop>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Joe Perches <joe@perches.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Ingo Molnar <mingo@elte.hu>, x86@kernel.org, LKML <linux-kernel@vger.kernel.org>, Andi Kleen <andi@firstfloor.org>, Thomas Gleixner <tglx@linutronix.de>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, "H. Peter Anvin" <hpa@zytor.com>, Ondrej Zary <linux@rainbow-software.org>, Andrew Morton <akpm@linux-foundation.org>, Linus <torvalds@linux-foundation.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Mon, 28 Mar 2011, Joe Perches wrote:

> > > > I still have some hardware that uses APM and put a new 2.6 on it time 
> > > > to time, so I can take this driver over if you want to. According to 
> > > > git log it's really low effort anyway :)
> > > If you want it, its yours :-)
> > Not really fighting for maintaining it actively, but can certainly give it 
> > some care when necessary.
> > diff --git a/MAINTAINERS b/MAINTAINERS
> []
> > @@ -548,8 +548,9 @@ S:	Maintained
> >  F:	sound/aoa/
> >  
> >  APM DRIVER
> > -L:	linux-laptop@vger.kernel.org
> > -S:	Orphan
> > +M:	Jiri Kosina <jkosina@suse.cz>
> > +L:	linux-kernel@vger.kernel.org
> 
> Please don't add L: LKML as it's the default
> and it could confuse people that read the file
> and see some sections with LKML and other without
> and may think that LKML is somehow optional.
> 
> > +S:	Maintained
> 
> If you're not actively maintaining it, maybe
> S:	Odd Fixes
> instead?

Whatever ...



From: Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH] APM: take over maintainership

Commit 04a6553f076 ("apm: orphan the driver") Orphaned the APM
driver as Stephen is not willing/able to maintain it any more.

As I still have some hardware that is using APM and running 2.6,
I can take it over.

Signed-off-by: Jiri Kosina <jkosina@suse.cz>
---
 MAINTAINERS |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8aa1cac..a8f2705 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -548,8 +548,8 @@ S:	Maintained
 F:	sound/aoa/
 
 APM DRIVER
-L:	linux-laptop@vger.kernel.org
-S:	Orphan
+M:	Jiri Kosina <jkosina@suse.cz>
+S:	Odd Fixes
 F:	arch/x86/kernel/apm_32.c
 F:	include/linux/apm_bios.h
 
-- 
1.7.3.1
