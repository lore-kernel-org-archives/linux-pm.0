From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] [443/2many] MAINTAINERS - HIBERNATION (aka
 Software Suspend, aka swsusp):
Date: Tue, 14 Aug 2007 11:22:37 -0700
Message-ID: <20070814112237.a5f1e1a4.akpm__15064.1557098881$1187115887$gmane$org@linux-foundation.org>
References: <46bffbd3.IqsNHrHU1Y9BF7Dd%joe@perches.com>
	<200708132338.25925.rjw@sisk.pl> <20070814070528.GA2903@elf.ucw.cz>
	<200708141937.06676.rjw@sisk.pl>
	<1187114231.32555.105.camel@localhost>
	<alpine.LFD.0.999.0708141112110.30176@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
Cc: linux-kernel@vger.kernel.org, Machek <pavel@ucw.cz>, Pavel@smtp2.linux-foundation.org, Joe Perches <joe@perches.com>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Tue, 14 Aug 2007 11:15:41 -0700 (PDT)
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> In other words, it would be much better to just have per-file markers, 
> along with some per-subdirectory stuff or similar.

And a `make maintainers' target to pull it all together..

(perhaps we could add a

	maintainer <keyword>

record to Kconfig, then `make maintainers' goes and looks up <keyword>
somewhere and does something with it)
