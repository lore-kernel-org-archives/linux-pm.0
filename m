From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] APM: delete APM in Linux-2.6.40
Date: Mon, 4 Apr 2011 18:44:56 +0200
Message-ID: <20110404164456.GA13215__2288.20738052509$1301935601$gmane$org@elf.ucw.cz>
References: <alpine.LFD.2.02.1103232321070.3848@x980>
	<20110324154505.934a56a0.sfr@canb.auug.org.au>
	<alpine.LFD.2.02.1103240336590.4529@x980>
	<20110324102116.GA17446@khazad-dum.debian.net>
	<alpine.LFD.2.02.1103241903030.16085@x980>
	<20110325010705.GB4535@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20110325010705.GB4535@khazad-dum.debian.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi!

> > > People with a ThinkPad T23, T30 will really not appreciate this, and it
> > > should not be too difficult to recruit some as testers.
> > 
> > I have both, and they both support ACPI.
> 
> I wonder why I had some users of those two boxes advocating APM, maybe
> it used to work better or something.  Or I got the T21 and A30 confused
> with the T23.
> 
> Well, I don't think we need to support the thre-digit series ThinkPads,
> the number of those still working is probably on the four digits
> world-wide.  And I haven't heard from anyone with a T21 or A31 in a
> while, so they might be down to five digits already.

I still have working thinkpad 560X, my brother occassionaly uses it...

I do not think we should remove APM support like this. It does not
seem to be huge maintainance burden...
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
