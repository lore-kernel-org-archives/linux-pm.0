From: Dave Jones <davej@redhat.com>
Subject: Re: [PATCH] [443/2many] MAINTAINERS - HIBERNATION (aka
	Software Suspend, aka swsusp):
Date: Tue, 14 Aug 2007 19:24:30 -0400
Message-ID: <20070814232430.GA9325@redhat.com>
References: <46bffbd3.IqsNHrHU1Y9BF7Dd%joe@perches.com>
	<200708132338.25925.rjw@sisk.pl> <20070814070528.GA2903@elf.ucw.cz>
	<200708141937.06676.rjw@sisk.pl>
	<1187114231.32555.105.camel@localhost>
	<alpine.LFD.0.999.0708141112110.30176@woody.linux-foundation.org>
	<20070814112237.a5f1e1a4.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20070814112237.a5f1e1a4.akpm@linux-foundation.org>
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
Cc: linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Joe Perches <joe@perches.com>, linux-pm@lists.linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Aug 14, 2007 at 11:22:37AM -0700, Andrew Morton wrote:
 > On Tue, 14 Aug 2007 11:15:41 -0700 (PDT)
 > Linus Torvalds <torvalds@linux-foundation.org> wrote:
 > 
 > > In other words, it would be much better to just have per-file markers, 
 > > along with some per-subdirectory stuff or similar.
 > 
 > And a `make maintainers' target to pull it all together..
 > 
 > (perhaps we could add a
 > 
 > 	maintainer <keyword>
 > 
 > record to Kconfig, then `make maintainers' goes and looks up <keyword>
 > somewhere and does something with it)

Not everything that's in MAINTAINERS has a Kconfig entry though,
so it really needs to live in the .c/.h files.

	Dave


-- 
http://www.codemonkey.org.uk
