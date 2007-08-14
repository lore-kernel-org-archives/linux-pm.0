From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] [443/2many] MAINTAINERS - HIBERNATION (aka
	Software Suspend, aka swsusp):
Date: Tue, 14 Aug 2007 11:42:36 -0700
Message-ID: <1187116957.32555.136.camel__25115.5237238438$1187117559$gmane$org@localhost>
References: <46bffbd3.IqsNHrHU1Y9BF7Dd%joe@perches.com>
	<200708132338.25925.rjw@sisk.pl> <20070814070528.GA2903@elf.ucw.cz>
	<200708141937.06676.rjw@sisk.pl> <1187114231.32555.105.camel@localhost>
	<alpine.LFD.0.999.0708141112110.30176@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.0.999.0708141112110.30176@woody.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pm@lists.linux-foundation.org, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Tue, 2007-08-14 at 11:15 -0700, Linus Torvalds wrote:
> Quite frankly, I think the MAINTAINERS file gets a whole lot uglier this 
> way.

Me too.
Chopping up the current file is simple.

How about keeping the whole thing in git?
Please look at thread:
[PATCH] [1/2many] - Find the maintainer(s) for a patch - scripts/get_maintainer.pl

> In other words, it would be much better to just have per-file markers, 
> along with some per-subdirectory stuff or similar.

Perhaps a single top-level MAINTAINERS subdirectory with
500+ files or MAINTAINERS per subdirectory.

Doesn't matter to me.

I'd prefer no per-file external markers,
nor embedded per-file keywords.
