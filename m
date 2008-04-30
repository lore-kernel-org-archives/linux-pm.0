From: Matt Helsley <matthltc@us.ibm.com>
Subject: Re: [RFC][PATCH 2/5] Container Freezer: Make
	refrigerator always	available
Date: Wed, 30 Apr 2008 02:08:29 -0700
Message-ID: <1209546509.6095.133.camel__43968.1624099196$1209546645$gmane$org@localhost.localdomain>
References: <20080424064756.643890130@us.ibm.com>
	<20080424064757.227289200@us.ibm.com>
	<20080425110456.GF14903@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080425110456.GF14903@elf.ucw.cz>
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
Cc: Oren Laadan <orenl@cs.columbia.edu>, Linux Containers <containers@lists.linux-foundation.org>, Linux-Kernel <linux-kernel@vger.kernel.org>, Cedric Le Goater <clg@fr.ibm.com>, Paul Menage <menage@google.com>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org


On Fri, 2008-04-25 at 13:04 +0200, Pavel Machek wrote:
> Hi!
> 
> > Now that the TIF_FREEZE flag is available in all architectures,
> > extract the refrigerator() and freeze_task() from kernel/power/process.c
> > and make it available to all.
> > 
> > The refrigerator() can now be used in a control group subsystem 
> > implementing a control group freezer.
> > 
> > Signed-off-by: Cedric Le Goater <clg@fr.ibm.com>
> > Signed-off-by: Matt Helsley <matthltc@us.ibm.com>
> > Tested-by: Matt Helsley <matthltc@us.ibm.com>
> 
> There's no problem with doing this... but you should get some debate
> (with Linus?) whether using freezer for cgroups is sane. When that is

	OK, I've sent this reply directly to Linus. Hopefully this time he'll
let us know...

	One potential mitigating factor: I don't think we need the full freezer
for checkpoint/restart. Right now, because it shares code with "power
management" it's convenient to reuse the freezer. I'm hopeful that once
the freezer is no longer necessary for power management some code paths
can be simplified since I don't think checkpoint/restart requires
freezing kernel threads.

> done, there's no problem with this going in, probably through rafael's
> patch queue.

	OK, if all goes well then I'll send the next round to Rafael and Cc the
rest. If anyone currently on Cc doesn't care to see that feel free to
let me know.

> (The first patch -- add freezer for all archs -- is probably
> reasonably to go in ASAP, through akpm or something...)
> 								Pavel

	Well, that should only go in if the subsequent patches go in, correct?
Also, since to the best of my knowledge this flag hasn't been in every
arch, I'm wondering if I should Cc arch maintainers?

Cheers,
	-Matt Helsley
