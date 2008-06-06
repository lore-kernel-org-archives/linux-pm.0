From: Pavel Machek <pavel@suse.cz>
Subject: Re: >3G => iommu => suspend problems -- was Re: SB600
	AHCI: Hard Disk Corruption
Date: Fri, 6 Jun 2008 15:20:11 +0200
Message-ID: <20080606132011.GA9027__13594.7602954277$1212763506$gmane$org@ucw.cz>
References: <1211717435.6038.53.camel@localhost.localdomain>
	<1211815881.6140.19.camel@localhost.localdomain>
	<20080527112236.GA13957@elf.ucw.cz>
	<200806040033.20736.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200806040033.20736.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Patrick <ragamuffin@datacomm.ch>, Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> > > > Can you try this one? It should prevent suspend in the broken cases,
> > > > but allow it in mem=4G config.
> > > 
> > > Sure!
> > > 
> > > root@babar:/usr/src/linux-2.6.25# patch -p1 < /home/pat/patch-2.6.26-rc3.gart-suspend
> > > patching file arch/x86/kernel/pci-gart_64.c
> > > Hunk #4 succeeded at 629 with fuzz 2 (offset 11 lines).
> > > 
> > > .....make; cp bzImage /boot; reboot....
> > 
> > Thanks!
> > 
> > This goes on top of the second patch... it makes it work.
> > 
> > 								Pavel
> > 
> > For iommu suspend/resume code to work, functions it calls may not be
> > __init.
> > 
> > Signed-off-by: Pavel Machek <pavel@suse.cz>
> 
> I consolidated some of your patches sent in this thread and made the result
> apply to the current -git.  It hasn't been tested yet, but does it look good?
> 
> It's on top of the patch that adds the GART sysdev.

Looks ok to me.

							Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
