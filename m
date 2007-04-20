From: Dave Jones <davej@redhat.com>
Subject: Re: [2/2] 2.6.21-rc7: known regressions
Date: Fri, 20 Apr 2007 01:03:44 -0400
Message-ID: <20070420050344.GG20566@redhat.com>
References: <Pine.LNX.4.64.0704151659570.5473@woody.linux-foundation.org>
	<20070416003723.GM3691@stusta.de> <4628482B.6040804@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4628482B.6040804@goop.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: gregkh@suse.de, Ingo Molnar <mingo@elte.hu>, linux-pm@lists.osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Adrian Bunk <bunk@stusta.de>, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org

On Thu, Apr 19, 2007 at 09:57:15PM -0700, Jeremy Fitzhardinge wrote:
 > Adrian Bunk wrote:
 > > Subject    : ThinkPad X60: resume no longer works  (PCI related?)
 > >              workaround: booting with "hpet=disable"
 > > References : http://lkml.org/lkml/2007/3/13/3
 > > Submitter  : Dave Jones <davej@redhat.com>
 > >              Jeremy Fitzhardinge <jeremy@goop.org>
 > > Caused-By  : PCI merge
 > >              commit 78149df6d565c36675463352d0bfe0000b02b7a7
 > > Handled-By : Eric W. Biederman <ebiederm@xmission.com>
 > >              Rafael J. Wysocki <rjw@sisk.pl>
 > > Status     : unknown
 > >   
 > 
 > OK. 2.6.21-rc7 suspend/resume works perfectly for me.  It's the first
 > kernel version in a long time.  I have no workarounds or special boot
 > options.  It's using hpet as the clocksource.

Do you have the backlight code enabled ?
I'm guessing not.

	Dave

-- 
http://www.codemonkey.org.uk
