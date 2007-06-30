From: linux@horizon.com
Subject: Re: 2.6.22-rcX Transmeta/APM regression
Date: 29 Jun 2007 23:03:43 -0400
Message-ID: <20070630030343.31711.qmail__10405.7605182335$1183172916$gmane$org@science.horizon.com>
References: <20070627153114.17953.qmail@science.horizon.com>
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070627153114.17953.qmail@science.horizon.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org
Cc: bk@suse.de, michal.k.k.piotrowski@gmail.com, linux@horizon.com, ak@suse.de, hpa@zytor.com
List-Id: linux-pm@vger.kernel.org

Okay, after a ridiculous amount of bisecting and recompiling and
rebooting...

First I had to find out that the kernel stops booting as of
bf50467204: "i386: Use per-cpu GDT immediately on boot"
(With theis commit, it silently stops booting.  The GP fault I
posted earlier comes a little later, but I didn't bother finding it.)

and starts again as of
b0b73cb41d: "i386: msr.h: be paranoid about types and parentheses"

However, one commit before the former suspends properly, and the latter
fails to suspend (exactly the same problem at get_fixed_ranges+0x9/0x60),
so I had to bisect further between the two, backporting the msr.h changes
across the msr-index.h splitoff.

Anyway, the patch which introduces the problem is the aptly named 3ebad:
3ebad59056: [PATCH] x86: Save and restore the fixed-range MTRRs of the BSP when suspending

2.6.22-rc6 plus that one commit reverted successfully does APM suspend
(and resume) for me.
