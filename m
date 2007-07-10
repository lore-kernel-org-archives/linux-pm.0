From: Paul Mackerras <paulus@samba.org>
Subject: Re: Re: hibernation/snapshot design [was Re: [PATCH] Remove
	process freezer from suspend to RAM pathway]
Date: Tue, 10 Jul 2007 11:56:41 +1000
Message-ID: <18066.59225.533802.387340__40911.0277345919$1184032657$gmane$org@cargo.ozlabs.ibm.com>
References: <Pine.LNX.4.44L0.0707072224270.10912-100000@netrider.rowland.org>
	<20070708221315.GF5401@elf.ucw.cz> <200707090101.28832.rjw@sisk.pl>
	<200707101133.01566.nigel@nigel.suspend2.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200707101133.01566.nigel@nigel.suspend2.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: nigel@suspend2.net
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org, Kyle Moffett <mrmacman_g4@mac.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Nigel Cunningham writes:

> (Finally catching up on emails since Saturday!)

Yes, I know what you mean; I was occupied with other work stuff on
Friday and not well on Saturday, and by that stage there was a backlog
of about 500 emails for me to wade through... :/

> The freezer is also essential for doing a full image of memory - you
> have to be able to guarantee that some of the image won't change in
> order to be able to write it out before the atomic copy. Of course the
> freezer alone isn't enough, but it solves 95% of the issue.

Sure.  As I pointed out in another email, it's unrealistic to expect
the freezer to be able to stop everything in a state where any
arbitrary mutex is free.  But as long as you don't need to do anything
that depends on getting a mutex while the system is frozen, there
should be no problem.

Paul.
