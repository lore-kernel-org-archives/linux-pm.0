From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] suspend/resume self-test
Date: Tue, 19 Feb 2008 15:40:05 +0100
Message-ID: <20080219144005.GC21176__13748.470953624$1203432160$gmane$org@elte.hu>
References: <20080130131748.GA3796@elf.ucw.cz>
	<200802180240.47510.david-b@pacbell.net>
	<20080218130914.GC17697@elte.hu>
	<200802181216.25350.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200802181216.25350.david-b@pacbell.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-pm@lists.linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


* David Brownell <david-b@pacbell.net> wrote:

> > And, at least to me, there seems to be a rather apparent correlation 
> > between "suspend/resume regressions caught as early as possible" and 
> > the future, desired state of: "STR working sanely on x86" ;-)
> 
> Thing is, this will catch not just regressions ... but cases where STR 
> never worked in the first place.  Video problems, etc.  Also various 
> system startup races, as in the PCMCIA and MMC/SD/SDIO cases I noted.

yes, but that's not your problem, that's the STR folks' problem.

> Right, and the best way to ensure that it's only *regressions* that 
> break things is to expect someone to have configured the kernel 
> command line appropriately (in grub or whatever).

a simple .config flag is perfectly fine for that, as long as it's 
default disabled and properly demarked. We have literally _dozens_ of 
"dangerous" test options and _nobody_ complains about them being 
dangerous ... They do their primary job of triggering bugs sooner, 
faster and harder, resulting in bugs getting fixed sooner, faster and 
harder.

> Another way to achieve that is to include the test code based on one 
> config option, and change the test *mode* based on another one.  That 
> way a distro could include that in standard kernels with "no test" 
> mode as the default, but it would be easy to enable only for oneshot 
> tests or field troubleshooting ... while developers could turn on the 
> more dangerous "always test STR" (or standby, or hibernate) mode, if 
> they were helping to find and fix problems surfaced by such tests.

no distro would enable this option, it just adds a needless 5-6 seconds 
delay to the bootup, and a needless "s2ram blows up sooner than it 
should" risk. _I_ want to enable this option, and want to see it trigger 
more often than just once out of a hundred randconfig setups.

really, you are making rookie mistakes in this area and you are doing 
injustice to the code you wrote and maintain :-) As i said it before, 
externally it looks like as if you intentionally avoided your code from 
being used, from people who _want_ to use your code. _I_ had to fight 
for almost an hour (!) until i figured out the zillions of .config 
variants that were finally able to get my test-system to boot-time 
suspend and resume all by itself. It's totally non-obvious. As far as 
the general Linux community goes, it's almost as if your code did not 
even exist, so well hidden and obscured it is.

	Ingo
