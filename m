From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH 12/12] PM / r8169: Add simplified
	run-time PM support
Date: Mon, 4 Jan 2010 20:51:08 +0100
Message-ID: <201001042051.08692.rjw__24490.0282392793$1262634698$gmane$org@sisk.pl>
References: <200911160047.46299.rjw@sisk.pl> <201001032201.14087.rjw@sisk.pl>
	<20100104083108.GD1372@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100104083108.GD1372@ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux PCI <linux-pci@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Francois Romieu <romieu@fr.zoreil.com>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Monday 04 January 2010, Pavel Machek wrote:
> 
> > > > Using /proc/acpi/battery/BAT1/state I measured the energy drawn in 10 minutes
> > > > both with the network adapter in D0 and D3hot.  The results were that with the
> > > > network adapter in D0 the box drew 2476 mWh, while with the network adapter in
> > > > D3hot it drew 2361 mWh.  The difference is 115 mWh, or about 5% on this
> > > > particular box.
> > > > 
> > > > This means about 0.1 Wh in 10 minutes, so we can save about 0.6 Wh per hour.
> > > 
> > > Which means it saves 0.6W :-). Measuring power in Wh/h is "interesting".
> > 
> > You can't save power, you can only save energy.  Wh is just an energy unit.
> 
> Of course we can save power, you just did :-).
> 
> (And in some cases -- data centers, limited cooling -- you are limited
> by power, not energy.

But still energy is what you pay for, isn't it?

> You are right that on notebooks, energy is more important.)

You may require less power to run, so if that's what you mean by "saving", then
I agree. :-)

Rafael
