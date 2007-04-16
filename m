From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [2/2] 2.6.21-rc7: known regressions
Date: Mon, 16 Apr 2007 12:06:22 +0200
Message-ID: <200704161206.31145.rjw@sisk.pl>
References: <Pine.LNX.4.64.0704151659570.5473@woody.linux-foundation.org> <20070416003723.GM3691@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751951AbXDPKDE@vger.kernel.org>
In-Reply-To: <20070416003723.GM3691@stusta.de>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Bunk <bunk@stusta.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jeff Chua <jeff.chua.linux@gmail.com>, pavel@suse.cz, linux-pm@lists.osdl.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, Dave Jones <davej@redhat.com>, Jeremy Fitzhardinge <jeremy@goop.org>, "Eric W. Biederman" <ebiederm@xmission.com>, gregkh@suse.de, linux-pci@atrey.karlin.mff.cuni.cz, Tobias Diedrich <ranma+kernel@tdiedrich.de>, Dmitry Torokhov <dtor@insightbb.com>, David Brownell <david-b@pacbell.net>, Marcus Better <marcus@better.se>, "Antonino A. Daplas" <adaplas@gmail.com>, James Simmons <jsimmons@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Monday, 16 April 2007 02:37, Adrian Bunk wrote:
> This email lists some known regressions in Linus' tree compared to 2.6.20.
> 
> If you find your name in the Cc header, you are either submitter of one
> of the bugs, maintainer of an affectected subsystem or driver, a patch
> of you caused a breakage or I'm considering you in any other way
> possibly involved with one or more of these issues.
> 
> Due to the huge amount of recipients, please trim the Cc when answering.
> 
[--snip--]
> 
> 
> Subject    : suspend to disk works only once
> References : http://lkml.org/lkml/2007/4/13/240
> Submitter  : Tobias Diedrich <ranma+kernel@tdiedrich.de>
> Caused-By  : Rafael J. Wysocki <rjw@sisk.pl>
>              commit ed746e3b18f4df18afa3763155972c5835f284c5
> Handled-By : Rafael J. Wysocki <rjw@sisk.pl>
>              Dmitry Torokhov <dtor@insightbb.com>
>              David Brownell <david-b@pacbell.net>
> Status     : problem is being debugged

Workaround is possible: do "echo shutdown > /sys/power/disk" before the
suspend or, for s2disk, add "shutdown method = shutdown" to the configuration
file.

Greetings,
Rafael
