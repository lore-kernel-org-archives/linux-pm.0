From: Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH 1/3] PCI PM: Do not disable and enable
	bridges during	suspend-resume
Date: Sun, 8 Feb 2009 10:11:57 +0100
Message-ID: <20090208091157.GD8040__27741.3942073055$1234084590$gmane$org@elf.ucw.cz>
References: <200902012229.27517.rjw@sisk.pl> <200902012231.17933.rjw@sisk.pl>
	<20090207094720.GA1507@ucw.cz> <200902071448.13877.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200902071448.13877.rjw@sisk.pl>
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
Cc: Linux PCI <linux-pci@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> > > their standard config spaces are restored.  Fix this by not attempting
> > > to disable bridges during suspend and enable them during resume.
> > ...
> > > @@ -428,16 +428,18 @@ static int pci_pm_default_resume(struct 
> > >  {
> > >  	pci_fixup_device(pci_fixup_resume, pci_dev);
> > >  
> > > -	if (!pci_is_bridge(pci_dev))
> > > -		pci_enable_wake(pci_dev, PCI_D0, false);
> > > +	if (pci_is_bridge(pci_dev))
> > > +		return 0;
> > >  
> > > +	pci_enable_wake(pci_dev, PCI_D0, false);
> > >  	return pci_pm_reenable_device(pci_dev);
> > >  }
> > 
> > Are you sure? This goes from doing reenable_device to not doing it for
> > bridges, seemingly contradicting changelog?
> 
> Can you explain what you mean, please?

It looks to me like the patch does not match the changelog.

Changelog says "enable bridge during resume", but code does return 0
if it seems bridge.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
