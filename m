From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: commit 66c1ca breaks fbdev mode switching
Date: Mon, 6 Apr 2009 20:47:18 +0200
Message-ID: <20090406204718.ce4909b3.krzysztof.h1__42708.5607582287$1239050711$gmane$org@poczta.fm>
References: <498817E2.3020008@gmail.com>
	<1233783983-28802-1-git-send-email-righi.andrea@gmail.com>
	<200903221748.42871.arvidjaar@gmail.com>
	<200903221857.20473.rjw@sisk.pl>
	<20090322145219.ad294615.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090322145219.ad294615.akpm@linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, "Antonino A. Daplas" <adaplas@gmail.com>, Andrey Borzenkov <arvidjaar@gmail.com>, linux-kernel@vger.kernel.org, Stefan Richter <stefanr@s5r6.in-berlin.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Johannes Weiner <hannes@cmpxchg.org>, linux-pm@lists.linux-foundation.org, Harvey Harrison <harvey.harrison@gmail.com>, Andrea Righi <righi.andrea@gmail.com>
List-Id: linux-pm@vger.kernel.org

Hi,

The commit 66c1ca breaks fbdev mode switching. The first mode
(selected with mode_option or during boot) is ok but every mode
switch with fbset locks up computer. If the commit is reverted
mode switching works correctly.

I do not understand why. I would be grateful if someone else
can confirm the problem as well.

The commit's details are:

commit 66c1ca019078220dc1bf968f2bb18421100ef147
Author: Andrea Righi <righi.andrea@gmail.com>
Date:   Tue Mar 31 15:25:18 2009 -0700

    fbmem: fix fb_info->lock and mm->mmap_sem circular locking dependency
    

Regards,
Krzysztof

----------------------------------------------------------------------
Kto lepiej radzi sobie w kuchni?
Odpowiedz i wygraj sprzet AGD! >> http://link.interia.pl/f2103 
