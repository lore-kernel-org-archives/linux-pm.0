From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH -mm] PM: Change ordering of suspend
	and resume code
Date: Sun, 26 Nov 2006 11:08:30 +0100
Message-ID: <200611261108.30532.rjw@sisk.pl>
References: <200611252210.58203.rjw@sisk.pl>
	<20061126074400.GA12479@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <suspend-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20061126074400.GA12479@elf.ucw.cz>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/suspend-devel>,
	<mailto:suspend-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=suspend-devel>
List-Post: <mailto:suspend-devel@lists.sourceforge.net>
List-Help: <mailto:suspend-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/suspend-devel>,
	<mailto:suspend-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: suspend-devel-bounces@lists.sourceforge.net
Errors-To: suspend-devel-bounces@lists.sourceforge.net
To: Pavel Machek <pavel@ucw.cz>
Cc: suspend-devel List <suspend-devel@lists.sourceforge.net>, seife@suse.de, pm list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

Hi,

On Sunday, 26 November 2006 08:44, Pavel Machek wrote:
> Hi!
> 
> > The discussion in a recent thread on Linux-PM has indicated that it's
> > necessary to call pm_ops->finish() before devce_resume(),
> > but enable_nonboot_cpus() has to be called before pm_ops->finish()
> > (cf. http://lists.osdl.org/pipermail/linux-pm/2006-November/004164.html).
> > For consistency, it seems reasonable to call disable_nonboot_cpus() after
> > device_suspend().
> > 
> > This way the suspend code will remain symmetrical with respect to the resume
> > code and it may allow us to speed up things in the future by suspending and
> > resuming devices and/or saving the suspend image in many threads, but for this
> > purpose we first need to make freeze_processes() SMP-safe.
> 
> I do not think first patch is enough to make it SMP-safe, sorry.

So, what is the scenario in which it will fail?

> > The following series of patches makes freeze_processes() SMP-safe and
> > reorders the suspend and resume code so that nonboot CPUs are disabled
> > after devices have been suspended and enabled before the devices are
> > resumed.  It also causes pm_ops->finish() to be called after
> > enable_nonboot_cpus() wherever necessary.
> > 
> > The first four patches have been tested on two different x86-64 SMP boxes and
> > they don't seem to break anything.  Still, if anyone can test them on some other
> > SMP boxes (especially on i386 ones), please do so and tell me if there are
> > any problems.
> > 
> > The last patch is untested.
> 
> I guess I should fix s2ram enough that it works for you... What is the
> primary notebook you are using?

HPC nx6325.  Someone has reported he's managed to get s2ram working on it,
but it looks like his machine is slightly different to this one ...

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
