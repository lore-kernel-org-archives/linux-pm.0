From: Florian Mickler <florian@mickler.org>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Mon, 31 May 2010 22:47:32 +0200
Message-ID: <20100531224732.2073828d__20452.3509055891$1275338906$gmane$org@schatten.dmk.lab>
References: <20100527222514.0a1710bf@lxorguk.ukuu.org.uk>
	<Pine.LNX.4.44L0.1005271730180.3239-100000@iolanthe.rowland.org>
	<20100527230806.4deb6de3@lxorguk.ukuu.org.uk>
	<20100527220949.GB10602@srcf.ucam.org>
	<20100527232357.6d14fdb2@lxorguk.ukuu.org.uk>
	<20100527223605.GB11364@srcf.ucam.org>
	<20100527235546.09f3ce8a@lxorguk.ukuu.org.uk>
	<20100528043114.GC26177@thunk.org>
	<1275030704.32462.11.camel@laptop>
	<AANLkTikEtlbkT4Ws3H2YGt_9QC46B5dr-b1oxJOcG4GN@mail.gmail.com>
	<1275120618.27810.12699.camel@twins>
	<1275149418.4503.128.camel@mulgrave.site>
	<1275156734.1645.496.camel@laptop>
	<20100531221219.212bf119@schatten.dmk.lab>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100531221219.212bf119@schatten.dmk.lab>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Florian Mickler <florian@mickler.org>
Cc: tytso@mit.edu, Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, James Bottomley <James.Bottomley@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Linux PM <linux-pm@lists.linux-foundation.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, felipe.balbi@nokia.com
List-Id: linux-pm@vger.kernel.org

On Mon, 31 May 2010 22:12:19 +0200
Florian Mickler <florian@mickler.org> wrote:

> On Sat, 29 May 2010 20:12:14 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > Why would you try to let buggy apps work as intended instead of break
> > them as hard as possible? Such policy promotes crappy code since people
> > get away with it.
> 
> If I have a simple shell script then I don't wanna jump through
> hoops just to please your fragile kernel. 

Also why should that code on one device kill my uptime and on the
other machine (my wall-plugged desktop) work just well? That doesn't
sound right.

Clearly opportunistic suspend is a workaround for battery-driven devices
and no general solution. But it is not specific to android. At least
not inherently. It could be useful for any embedded or mobile device
where you can clearly distinguish important functions from convenience
functions.

I really can't understand the whole _fundamental_ opposition to this
design choice. 

Cheers,
Flo
