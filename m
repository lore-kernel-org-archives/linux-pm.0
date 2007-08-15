From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] [443/2many] MAINTAINERS - HIBERNATION (aka
	Software Suspend, aka swsusp):
Date: Tue, 14 Aug 2007 18:45:14 -0700
Message-ID: <1187142314.32555.191.camel@localhost>
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
> In other words, it would be much better to just have per-file markers, 
> along with some per-subdirectory stuff or similar.

So that there would be no hot single file, I cut the
MAINTAINER file into single file segments in maintainers/*

00_descriptions
3c359_network_driver
3c505_network_driver
3c59x_network_driver
3cr990_network_driver
...
zd1211rw_wireless_driver
zf_machz_watchdog
zr36067_video_for_linux_driver
zs_decstation_z85c30_serial_driver
zz_the_rest

611 files.

How could "make" make a single MAINTAINERS?

	"cat [0-9a-z]* > ../MAINTAINERS"?

Would it need to?
Anyone have suggestions for Makefile/Kconfig support?
