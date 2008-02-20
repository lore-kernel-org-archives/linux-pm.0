From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] suspend/resume self-test
Date: Wed, 20 Feb 2008 11:15:42 +0100
Message-ID: <20080220101542.GC3881__27895.5463706099$1203502703$gmane$org@elte.hu>
References: <20080130131748.GA3796@elf.ucw.cz>
	<20080219101116.GA2202@elf.ucw.cz> <20080219144328.GD21176@elte.hu>
	<200802191112.57616.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200802191112.57616.david-b@pacbell.net>
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

> > nowhere did i suggest that it should be default-enabled ...
> 
> The patch you asked to be merged *DID* have it be default-enabled! So 
> you did more than just "suggest"... if that option is enabled in 
> Kconfig, this test is always forced on and it will cause failures on 
> systems where STR has never worked.

i think you dont understand what "default enabled" means in this 
context. Default enabled means the Kconfig entry has a "default y" line 
- which it did not have in the patch i sent.

if a tester enables the .config option then it is very much expected to 
be triggered, just like the other .config debug options. Of course, the 
tester specifically enabled it, so that's what we want to happen. Not 
some other "yes_i_really_meant_it" boot option ... There can also be 
_another_ .config option that turns off the 'run by default' property - 
but if someone selects the _default off_ feature and enables it, just 
like i did, then the feature is very much expected to run.

you really seem to have deep misunderstandings about how testers use 
Linux, what it takes to build up a proper debug infrastructure and how 
to utilize all these things to make Linux better. You come from the 
embedded world where everything is configured together specifically, 
where people know what they are using and were every feature is well 
accounted for. But you seem to have little insight into how 
distributions utilize kernel features and what it takes to accept the 
help of testers who dont know the field that well but still want to help 
out - as long as we let them.

These are well-established practices we use in all other debug features 
that help Linux today, and what you are asking for is weird, unusual and 
wrong. Please take a look at how all the other debug stuff works. Rule
#1: testers dont have to beg the kernel for 1 hour and have to write 2
patches to let the test code be run finally ... ;-) This isnt even about 
any nuances where reasonable people might disagree, this is really basic 
testing-101 stuff.

	Ingo
