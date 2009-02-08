From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/3] PCI PM: Do not disable and enable
	bridges during suspend-resume
Date: Sun, 8 Feb 2009 14:23:08 +0100
Message-ID: <200902081423.08991.rjw__15373.035221319$1234099647$gmane$org@sisk.pl>
References: <200902012229.27517.rjw@sisk.pl> <200902071448.13877.rjw@sisk.pl>
	<20090208091157.GD8040@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090208091157.GD8040@elf.ucw.cz>
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
To: Pavel Machek <pavel@suse.cz>
Cc: Linux PCI <linux-pci@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>
List-Id: linux-pm@vger.kernel.org

On Sunday 08 February 2009, Pavel Machek wrote:
> Hi!
> 
> > > > their standard config spaces are restored.  Fix this by not attempting
> > > > to disable bridges during suspend and enable them during resume.
> > > ...
> > > > @@ -428,16 +428,18 @@ static int pci_pm_default_resume(struct 
> > > >  {
> > > >  	pci_fixup_device(pci_fixup_resume, pci_dev);
> > > >  
> > > > -	if (!pci_is_bridge(pci_dev))
> > > > -		pci_enable_wake(pci_dev, PCI_D0, false);
> > > > +	if (pci_is_bridge(pci_dev))
> > > > +		return 0;
> > > >  
> > > > +	pci_enable_wake(pci_dev, PCI_D0, false);
> > > >  	return pci_pm_reenable_device(pci_dev);
> > > >  }
> > > 
> > > Are you sure? This goes from doing reenable_device to not doing it for
> > > bridges, seemingly contradicting changelog?
> > 
> > Can you explain what you mean, please?
> 
> It looks to me like the patch does not match the changelog.
> 
> Changelog says "enable bridge during resume", but code does return 0
> if it seems bridge.

Ah, I see.  The changelog was supposed to mean that the bridges would not
be disabled during suspend and also would not be enabled during resume
(which shouldn't be necessary, since they would be automatically enabled
as a result of restoring their configuration registers).

Thanks,
Rafael


> 									Pavel


-- 
Everyone knows that debugging is twice as hard as writing a program
in the first place.  So if you're as clever as you can be when you write it,
how will you ever debug it? --- Brian Kernighan
