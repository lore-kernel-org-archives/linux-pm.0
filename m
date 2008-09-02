From: Pavel Machek <pavel@suse.cz>
Subject: Re: >3G => iommu => suspend problems -- was Re: SB600
	AHCI: Hard	Disk Corruption
Date: Tue, 2 Sep 2008 10:05:35 +0200
Message-ID: <20080902080535.GC15399__44054.7325685204$1220347523$gmane$org@elf.ucw.cz>
References: <1211717435.6038.53.camel@localhost.localdomain>
	<200806090036.32267.rjw@sisk.pl>
	<1213184587.6376.37.camel@localhost.localdomain>
	<200806111638.50933.rjw@sisk.pl> <484FE97D.4040805@firstfloor.org>
	<1215106548.5194.22.camel@localhost.localdomain>
	<20080807081747.GC1647@elf.ucw.cz>
	<1218235204.5590.20.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1218235204.5590.20.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Patrick <ragamuffin@datacomm.ch>
Cc: Ingo Molnar <mingo@elte.hu>, Andi Kleen <andi@firstfloor.org>, linux-kernel@vger.kernel.org, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> > Can you test 2.6.27-rc2? It should be all there...
> 
> Ja, sure! I noticed that it's there already... thank you all!
> 
> So as you requested, I got myself a -rc2 tree, compiled and tested
> #s2ram and #s2disk. It works!

Good.

> Maybe it's got something to do with the fact that I'm using
> https://launchpad.net/~xorg-edgers xserver now to have 3d acceleration
> working for my radeon X1200 (RS690 builtin) and the drm module versions
> don't match. Xserver wants 1.30 but starts anyway. I can't fix this
> because the script can't compile the
> git://anongit.freedesktop.org/git/mesa/drm modules for 2.6.27-rc2 ....
> This creates some unpredictable problems with the X server process when
> I log into my account (can't find out what triggers it ... cpu usage
> goes to 100%, have to reboot) As a workaround, I could log into a guest
> account to do the tests but switched back to my patched 2.6.26-rc5 for
> now for everyday PC usage.

Yes, 3d has some problems.

> BTW, if somebody would like to explain to me, why the simultanious usage
> of the GART by drm and as iommu DON'T bite each other, I'd be quiet
> interrested to learn.

No idea, sorry.
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
