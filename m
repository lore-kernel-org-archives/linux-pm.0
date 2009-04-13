From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [REGRESSION] commit 66c1ca0: {fbmem: fix
	fb_info->lock and mm->mmap_sem ...} causes Xfbdev not working
Date: Tue, 14 Apr 2009 01:34:47 +0200
Message-ID: <m21vrwi0vc.fsf__22620.4725252048$1239726419$gmane$org@igel.home>
References: <f17812d70904090436kd03744brca4a4bc4b85bba8@mail.gmail.com>
	<20090409125850.GA2727@linux>
	<20090410222122.87be60f6.krzysztof.h1@poczta.fm>
	<20090410220521.GB21294@linux>
	<20090411080415.7fe924a2.krzysztof.h1@poczta.fm>
	<49E05C36.9040204@s5r6.in-berlin.de> <20090411110840.GA7108@linux>
	<20090411150359.GA8265@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090411150359.GA8265@linux> (Andrea Righi's message of "Sat, 11
	Apr 2009 17:04:00 +0200")
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: Pavel Roskin <proski@gnu.org>, "Antonino A. Daplas" <adaplas@gmail.com>, Andrey Borzenkov <arvidjaar@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, Krzysztof Helt <krzysztof.h1@poczta.fm>, LKML <linux-kernel@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-fbdev-devel@lists.sourceforge.net, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Harvey Harrison <harvey.harrison@gmail.com>
List-Id: linux-pm@vger.kernel.org

Andrea Righi <righi.andrea@gmail.com> writes:

> Tested intelfb and X11 with fbdev. It seems to work fine, but I may be
> unable to test the mode switching right now:
>
>   intelfb: Non-CRT device is enabled ( LVDS port ).  Disabling mode switching.
>
> It would be great if someone could help me to test this patch (against
> latest Linus' git - no need to revert 66c1ca).

I can confirm that it fixes the issue.  Tested with radeonfb and MOL.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
