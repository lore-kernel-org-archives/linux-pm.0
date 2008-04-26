From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH 2/5] Container Freezer: Make
	refrigerator always available
Date: Sat, 26 Apr 2008 15:02:36 +0200
Message-ID: <200804261502.37413.rjw__44651.2802308009$1209215068$gmane$org@sisk.pl>
References: <20080424064756.643890130@us.ibm.com>
	<20080425110456.GF14903@elf.ucw.cz> <4811C978.6010508@fr.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4811C978.6010508@fr.ibm.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Cedric Le Goater <clg@fr.ibm.com>
Cc: Oren Laadan <orenl@cs.columbia.edu>, Linux Containers <containers@lists.linux-foundation.org>, Linux-Kernel <linux-kernel@vger.kernel.org>, Paul Menage <menage@google.com>, Linus Torvalds <torvalds@linux-foundation.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Friday, 25 of April 2008, Cedric Le Goater wrote:
> Pavel Machek wrote:
> > Hi!
> > 
> >> Now that the TIF_FREEZE flag is available in all architectures,
> >> extract the refrigerator() and freeze_task() from kernel/power/process.c
> >> and make it available to all.
> >>
> >> The refrigerator() can now be used in a control group subsystem 
> >> implementing a control group freezer.
> >>
> >> Signed-off-by: Cedric Le Goater <clg@fr.ibm.com>
> >> Signed-off-by: Matt Helsley <matthltc@us.ibm.com>
> >> Tested-by: Matt Helsley <matthltc@us.ibm.com>
> > 
> > There's no problem with doing this... but you should get some debate
> > (with Linus?) whether using freezer for cgroups is sane. 
> 
> Yes that's what we are trying to know, is the fake signal mechanism 
> used by the freezer something we can build upon ? 

Well, currently, the freezer doesn't send fake signals to kernel threads which
turns out to be problematic, becase some kernel threads behave very much like
user space processes (basically, the threads related to NFS and CIFS).

I have an idea how to fix this issue, but I'm not sure if it's acceptable
overall.  I'll try to prepare a patch later today or tomorrow.

Thanks,
Rafael
