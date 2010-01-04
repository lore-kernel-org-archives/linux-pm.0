From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH 12/12] PM / r8169: Add simplified
 run-time PM support
Date: Mon, 4 Jan 2010 22:00:40 +0100
Message-ID: <20100104210040.GA20001__14268.986383877$1262638923$gmane$org@elf.ucw.cz>
References: <200911160047.46299.rjw@sisk.pl> <201001032201.14087.rjw@sisk.pl>
	<20100104083108.GD1372@ucw.cz> <201001042051.08692.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201001042051.08692.rjw@sisk.pl>
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
Cc: Linux PCI <linux-pci@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Francois Romieu <romieu@fr.zoreil.com>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

> > > > Which means it saves 0.6W :-). Measuring power in Wh/h is "interesting".
> > > 
> > > You can't save power, you can only save energy.  Wh is just an energy unit.
> > 
> > Of course we can save power, you just did :-).
> > 
> > (And in some cases -- data centers, limited cooling -- you are limited
> > by power, not energy.
> 
> But still energy is what you pay for, isn't it?

Energy is what you pay for, but if you eat too much power, data centre
overheats and goes down.

> > You are right that on notebooks, energy is more important.)
> 
> You may require less power to run, so if that's what you mean by "saving", then
> I agree. :-)

Yes, that's what I meant by saving :-), and yes, they are very
related.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
