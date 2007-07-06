From: Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Fri, 06 Jul 2007 09:07:38 +0200
Message-ID: <E1I6huk-0003AH-00@dorka.pomaz.szeredi.hu>
References: <18059.10554.955290.148535@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.44L0.0707041045150.25704-100000@netrider.rowland.org>
	<18060.14856.824473.325660@cargo.ozlabs.ibm.com>
	<200707050858.03638.oliver@neukum.org>
	<E1I6MWb-0008Tq-00@dorka.pomaz.szeredi.hu>
	<20070705091801.GB3084@elf.ucw.cz>
	<E1I6NgZ-0000F6-00@dorka.pomaz.szeredi.hu>
	<20070705220444.GD3881@elf.ucw.cz>
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <20070705220444.GD3881@elf.ucw.cz> (message from Pavel Machek on
	Fri, 6 Jul 2007 00:04:44 +0200)
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: pavel@ucw.cz
Cc: mjg59@srcf.ucam.org, miklos@szeredi.hu, linux-kernel@vger.kernel.org, johannes@sipsolutions.net, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

> > Actually fuse allows SIGKILL, because it's always fatal, and the
> > syscall may not be restarted.
> 
> Okay, and you should handle refrigerator in the same paths where you
> handle SIGKILL. Just add try_to_freeze() there...

It's the fourth time I'm repeating this in this thread:

Yes adding try_to_freeze() there would partially solve the probelem.

But another task can be sleeping on a mutex held by the task waiting
for the reply.  And the freezer won't be able to handle that one.

Generally, calling try_to_freeze() with mutexes held is not a good
idea.

Miklos
