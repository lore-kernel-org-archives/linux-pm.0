From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] APM: delete APM in Linux-2.6.40
Date: Mon, 04 Apr 2011 16:18:33 -0400 (EDT)
Message-ID: <alpine.LFD.2.02.1104041615040.5324__10904.5612895445$1301948422$gmane$org@x980>
References: <alpine.LFD.2.02.1103232321070.3848@x980>
	<20110324154505.934a56a0.sfr@canb.auug.org.au>
	<alpine.LFD.2.02.1103240336590.4529@x980>
	<20110324102116.GA17446@khazad-dum.debian.net>
	<alpine.LFD.2.02.1103241903030.16085@x980>
	<20110325010705.GB4535@khazad-dum.debian.net>
	<20110404164456.GA13215@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <20110404164456.GA13215@elf.ucw.cz>
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Henrique de Moraes Holschuh <hmh@hmh.eng.br>
List-Id: linux-pm@vger.kernel.org


> I still have working thinkpad 560X, my brother occassionaly uses it...

There is no doubt that there are still people running Linux
on old APM laptops.

The question, however, is if they're running (or will run)
the latest upstream kernel.  Further, are they available
to test APM patches to the latest upstream kernel.

> I do not think we should remove APM support like this. It does not
> seem to be huge maintainance burden...

Last week we decided not to delete APM yet.
The jury is still out on APM's idle hooks.

cheers,
Len Brown, Intel Open Source Technology Center
