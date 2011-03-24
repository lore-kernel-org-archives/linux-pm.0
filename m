From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] APM: delete APM in Linux-2.6.40
Date: Thu, 24 Mar 2011 19:29:25 -0400 (EDT)
Message-ID: <alpine.LFD.2.02.1103241905250.16085__24870.7038270824$1301009514$gmane$org@x980>
References: <alpine.LFD.2.02.1103232321070.3848@x980>
	<20110324154505.934a56a0.sfr@canb.auug.org.au>
	<alpine.LFD.2.02.1103240336590.4529@x980>
	<201103241315.34722.linux@rainbow-software.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <201103241315.34722.linux@rainbow-software.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ondrej Zary <linux@rainbow-software.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

> Please don't turn Linux into second Windows.

No worry there.

I mention Microsoft not to advocate that Linux be Windows,
but to point out that this (hardware/firmware) ship sank 5 years
ago and Linux is still on the boat.  MS was able to delete 
APM support in 2006 from their source tree, yet we still carry it.

> If you don't want APM in the 
> kernel, just don't compile it. There are many people using older systems with 
> APM - and most of them wouldn't oppose to this removal as they don't even 
> know about it.

They can still run old Linux on an old APM-only laptop --
just like they can still run Windows 3.1 or Windows XP if they want to.

What we'd be taking away is their ability to run the latest
Linux kernel on that laptop.

The issue at hand is people (like me) who have to maintain
the latest Linux source code.  In sort, I don't want to
write, debug, and test a cpuidle driver for an apm-only laptop
when I could be spending effort on code that people will
actually run.

thanks,
-Len
