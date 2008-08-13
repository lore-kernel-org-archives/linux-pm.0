From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [ProbableSpam]Re: [PATCH 2/5] Container Freezer:
	Make refrigerator always available
Date: Wed, 13 Aug 2008 16:31:48 +0200
Message-ID: <200808131631.49889.rjw__45710.1627522663$1218653021$gmane$org@sisk.pl>
References: <20080811235323.872291138@us.ibm.com>
	<200808122249.27553.rjw@sisk.pl>
	<1218589300.19008.135.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1218589300.19008.135.camel@localhost.localdomain>
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
To: Matt Helsley <matthltc@us.ibm.com>
Cc: Linux Containers <containers@lists.linux-foundation.org>, Li Zefan <lizf@cn.fujitsu.com>, Linux-Kernel <linux-kernel@vger.kernel.org>, Cedric Le Goater <clg@fr.ibm.com>, linux-pm@lists.linux-foundation.org, "Serge E. Hallyn" <serue@us.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Paul Menage <menage@google.com>
List-Id: linux-pm@vger.kernel.org

On Wednesday, 13 of August 2008, Matt Helsley wrote:
> 
> On Tue, 2008-08-12 at 22:49 +0200, Rafael J. Wysocki wrote:
> > On Tuesday, 12 of August 2008, Matt Helsley wrote:
> > > Now that the TIF_FREEZE flag is available in all architectures,
> > > extract the refrigerator() and freeze_task() from kernel/power/process.c
> > > and make it available to all.
> > > 
> > > The refrigerator() can now be used in a control group subsystem
> > > implementing a control group freezer.
> > > 
> > > Signed-off-by: Cedric Le Goater <clg@fr.ibm.com>
> > > Signed-off-by: Matt Helsley <matthltc@us.ibm.com>
> > > Acked-by: Serge E. Hallyn <serue@us.ibm.com>
> > > Tested-by: Matt Helsley <matthltc@us.ibm.com>
> > 
> > Your Signed-off-by implies your Tested-by (at least it should ;-)).
> 
> I wasn't sure that was always true so I added it just in case. I'll take
> it out of any future postings.
> 
> > > ---
> > [--snip--]
> > > Index: linux-2.6.27-rc1-mm1/kernel/power/Kconfig
> > > ===================================================================
> > > --- linux-2.6.27-rc1-mm1.orig/kernel/power/Kconfig
> > > +++ linux-2.6.27-rc1-mm1/kernel/power/Kconfig
> > > @@ -85,6 +85,9 @@ config PM_SLEEP
> > >  	depends on SUSPEND || HIBERNATION || XEN_SAVE_RESTORE
> > >  	default y
> > >  
> > > +config FREEZER
> > > +	def_bool PM_SLEEP
> > > +
> > 
> > I'd still prefer this to go into a Kconfig in the parent directory (ie. where
> > freezer.c and the Makefile building it are located).  Otherwise it's guaranteed
> > to confuse someone.
> 
> 	I'm thinking of making a patch moving the cgroups config variables into
> a kernel/Kconfig.cgroups file. Would moving config FREEZER to such a
> file be satisfactory? Paul, what do you think?

Well, in fact FREEZER is not directly dependent on cgroups, as it can also
depend on PM_SLEEP, even if cgroups are not used at all.

I would just add 'Kconfig.freezer' to 'kernel', put 'config FREEZER' in there
and make it depend on whatever needs it.  Of course,
'source "kernel/Kconfig.freezer"' would have to be added to top-level
Kconfigs for all architectures, but please note that only a few architectures
include 'kernel/power/Kconfig', so you'd have to change the top-level
Kconfigs anyway.

Alternatively, you can just add 'config FREEZER' directly to the top-level
Kconfigs.

Thanks,
Rafael
