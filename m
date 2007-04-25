From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [3/3] 2.6.21-rc7: known regressions (v2)
Date: Wed, 25 Apr 2007 13:43:17 +0200
Message-ID: <20070425114317.GA32153@elte.hu>
References: <Pine.LNX.4.64.0704151659570.5473@woody.linux-foundation.org>
	<20070423214909.GD3468@stusta.de>
	<20070425040605.6d6b4a82.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20070425040605.6d6b4a82.akpm@linux-foundation.org>
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
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Mikael Pettersson <mikpe@it.uu.se>, John Stultz <johnstul@us.ibm.com>, Tobias Diedrich <ranma+kernel@tdiedrich.de>, Guilherme Schroeder <guilherme@centralinf.com.br>, Jeff Chua <jeff.chua.linux@gmail.com>, Adrian Bunk <bunk@stusta.de>, linux-pci@atrey.karlin.mff.cuni.cz, ak@suse.de, James Simmons <jsimmons@infradead.org>, "Antonino A. Daplas" <adaplas@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, linux-pm@lists.linux-foundation.org, discuss@x86-64.org, gregkh@suse.de, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org


* Andrew Morton <akpm@linux-foundation.org> wrote:

> > Subject    : suspend to disk hangs  (CONFIG_NO_HZ)
> > References : http://lkml.org/lkml/2007/3/25/217
> > Submitter  : Jeff Chua <jeff.chua.linux@gmail.com>
> > Status     : unknown
> 
> That's still rather a lot of bustage from the timekeeping changes.  Is 
> anything really happening here or have we all given up?

Jeff: does that suspend-to-disk hang problem also happen if you use 
hpet=disable?

	Ingo
