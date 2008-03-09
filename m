From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH] cpuidle: avoid singing capacitors
Date: Sun, 9 Mar 2008 17:41:15 -0300
Message-ID: <20080309204115.GF27193__20856.5552872189$1205095381$gmane$org@khazad-dum.debian.net>
References: <20080304040048.GA31562@codemonkey.org.uk>
	<20080304071423.0e6b71c1@mjolnir.drzeus.cx>
	<20080304181924.70aaf8c1@mjolnir.drzeus.cx>
	<924EFEDD5F540B4284297C4DC59F3DEEA77031@orsmsx423.amr.corp.intel.com>
	<20080305070201.0d16cd40@mjolnir.drzeus.cx>
	<20080305094023.6486ebdf@mjolnir.drzeus.cx>
	<20080306092730.4412d085@mjolnir.drzeus.cx>
	<20080309151659.63d54f38@mjolnir.drzeus.cx>
	<20080309193009.GD27193@khazad-dum.debian.net>
	<20080309211428.5d93f042@mjolnir.drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20080309211428.5d93f042@mjolnir.drzeus.cx>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: LKML <linux-kernel@vger.kernel.org>, Adam Belay <abelay@novell.com>, Andi Kleen <andi@firstfloor.org>, linux-pm@lists.linux-foundation.org, Lee Revell <rlrevell@joe-job.com>
List-Id: linux-pm@vger.kernel.org

On Sun, 09 Mar 2008, Pierre Ossman wrote:
> On Sun, 9 Mar 2008 16:30:09 -0300
> Henrique de Moraes Holschuh <hmh@hmh.eng.br> wrote:
> > On Sun, 09 Mar 2008, Pierre Ossman wrote:
> > > I'm beginning to think this is a lost cause. I've tried several variants, all without satisfactory results.
> > 
> > THIS will work:
> > http://www.nordichardware.com/image3.php?id=1446
> > 
> > ThinkPad owners have known this for a while...
> 
> Odd. The thinkpad sites I've been looking at all agree that glue doesn't help at all. Do you have some more info about that "fix"?

I asked for some pictures for thinkwiki, but nobody sent them in yet :(

You also need to know what glue to use (it needs to be one that is *not* too
hard when cured or it will just propagate the high frequencies instead of
dampening them), and where to apply it (it may be the chip, the capacitor,
or one of the inductors, etc).

As soon as the warranty on my T43 is over, I will do some heavy research on
the subject and hardware-mod it with Arcric ice, a PLL/ICH heatsink and
noise dampening.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
