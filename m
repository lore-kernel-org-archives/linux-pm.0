From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Sat, 7 Jul 2007 14:09:19 +0200
Message-ID: <20070707120919.GB3111__39996.4733901017$1183810368$gmane$org@elf.ucw.cz>
References: <20070703042916.GA17240@srcf.ucam.org>
	<200707041310.11336.rjw@sisk.pl>
	<18059.33636.66185.902453@cargo.ozlabs.ibm.com>
	<200707041630.30048.rjw@sisk.pl>
	<18060.14341.341604.666867@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <18060.14341.341604.666867@cargo.ozlabs.ibm.com>
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
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>
List-Id: linux-pm@vger.kernel.org

On Thu 2007-07-05 10:15:01, Paul Mackerras wrote:
> Rafael J. Wysocki writes:
> 
> > This is incompatible with the code in kernel/power/main.c, since we only
> > disable the nonboot CPUs after devices have been suspended.  Do you think that
> > your framework can be modified to work without disabling the nonboot CPUs
> > by the user space?
> 
> Sure.  It was a "if it can be done in userspace, do it in userspace"
> kind of decision, but I'm not wedded to it.
> 
> I actually do want to converge to using the generic suspend-to-ram
> code on powerbooks.  I just want to avoid causing regressions for
> powerbook users, including myself. :)

Curious, do you actually use fuse? Can you try it _with_ freezer and
produce sysrq-t trace of deadlock?
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
