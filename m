From: Adrian Bunk <bunk@stusta.de>
Subject: The big suspend mess
Date: Thu, 5 Jul 2007 00:19:53 +0200
Message-ID: <20070704221952.GM3492__30527.6846782819$1183587617$gmane$org@stusta.de>
References: <20070703042916.GA17240@srcf.ucam.org>
	<200707031456.40890.rjw@sisk.pl>
	<1183497290.3388.4.camel@localhost.localdomain>
	<200707032332.49694.rjw@sisk.pl>
	<18059.5165.861038.392332@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <18059.5165.861038.392332@cargo.ozlabs.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Paul Mackerras <paulus@samba.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Wed, Jul 04, 2007 at 01:29:49PM +1000, Paul Mackerras wrote:
> Rafael J. Wysocki writes:
> 
> > Still, do you really think that we're ready to drop it _right_ _now_ (I'm
> > referring to suspend only) and if so than on what basis (except that you
> > don't like it, which falls short of being a techical argument)?
> 
> The basis is that it (the freezer) causes more deadlocks and other
> problems than it avoids, so it's a net win to remove it.

You forget one important point:
Regressions are much worse than normal bugs.

It's not about the question whether the driver was "correct" or
"buggy" - for a user the important question is whether it worked in 
practice, and if yes, whether it continues to work.

And my impression is that every time someone touches some part of the 
suspend code some drivers break.

During 2.6.21-rc, it wasn't unusual for users to run with one kernel 
into up to three distinct suspend regressions on one machine.

And no, it wasn't always the same set of distinct regressions.

IMHO the suspend code is currently way too much of a moving target which 
results in this mess.

The correct order seems to be:
1. agree on what the suspend code as a whole should look like
2. implement this
3. fix ALL drivers to work at least as good as they do today
4. get it tested in -mm
5. fix all bugs people run into
6. submit it for inclusion in Linus' tree
7. quickly work on the most likely big amount of bug reports

Step 1 is the most important one - evolving code is often something 
good, but in this case with different people trying to evolve the 
suspend code in different directions it simply results in a big mess.

> Paul.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
