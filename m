From: Markus <lists4me@web.de>
Subject: Re: [1/4] 2.6.23-rc3: known regressions
Date: Wed, 15 Aug 2007 18:53:34 +0200
Message-ID: <200708151853.35643.lists4me__3319.63298745013$1187198164$gmane$org@web.de>
References: <46C09BEA.7010007@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <46C09BEA.7010007@googlemail.com>
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
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: Christian Zankel <chris@zankel.net>, "Antonino A. Daplas" <adaplas@gmail.com>, Jeff Chua <jeff.chua.linux@gmail.com>, Jan Dittmer <jdi@l4x.org>, linux-pm@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, Thomas Voegtle <tv@lio96.de>, Pavel Machek <pavel@ucw.cz>, linux-alpha@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Arkadiusz Miskiewicz <arekm@maven.pl>
List-Id: linux-pm@vger.kernel.org

> Subject         : konqueror suddenly vanishing, "konqueror: Fatal IO 
error: client killed"
> References      : http://lkml.org/lkml/2007/7/22/86
> Last known good : ?
> Submitter       : Markus <lists4me@web.de>
> Caused-By       : ?
> Handled-By      : Ingo Molnar <mingo@elte.hu>
> Status          : problem is being debugged
Last working kernel was the 2.6.22 without cfs. With the patch applied 
it shows the same problem (And so it does with the 2.6.23 as cfs was 
merged). And its caused by the cfs(-patch).

And the real problem is not just restricted to konqueror. Its just 
easier to reproduce. (So the original mails started at 
http://lkml.org/lkml/2007/7/14/60 )

   Markus
