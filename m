From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 2/9] x86 idle: remove NOP
	cpuinfo_x86.hlt_works_ok flag
Date: Thu, 31 Mar 2011 10:23:55 +0100
Message-ID: <20110331102355.17d30a38__17378.9155822762$1301563641$gmane$org@lxorguk.ukuu.org.uk>
References: <67e90d97e0a77df4acd0c75e1bacc7714e011f3e.1301550524.git.len.brown@intel.com>
	<b048802b0285a5ff28e74a4309d833116174904a.1301550524.git.len.brown@intel.com>
	<20110331061247.GA24786@elte.hu>
	<alpine.LFD.2.02.1103310252160.8569@x980>
	<20110331081800.GH5938@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110331081800.GH5938@elte.hu>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Len Brown <len.brown@intel.com>, x86@kernel.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, linux-pm@lists.linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

> Do we know whether a distro adds this to the boot line? Do we know about users 
> relying on it.

I certainly had hardware that needed it. Don't any more but this is more
trying to rip out stuff without letting nature take its course.

It's a trivial feature item.

> > Do we really need both?
> 
> Probably not, as i said i do not disagree - i just think it should be more 
> explicit. Make it a: "users of CPU models X beware" commit title, not 'remove 
> inactive code' ...

Just make the one config variable respond to both boot configuration
options. The parser is __init code anyway so discarded so the actual code
cost of compatibility is exactly NIL.

Alan
