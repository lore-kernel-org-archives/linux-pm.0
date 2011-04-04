From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 16/18] 2.6.40: x86 idle APM: remove
 deprecated apm_cpu_idle()
Date: Mon, 4 Apr 2011 11:05:58 +0100
Message-ID: <20110404110558.55301a8b__30433.63602269$1301911612$gmane$org@lxorguk.ukuu.org.uk>
References: <alpine.LFD.2.02.1104010020280.2797@x980>
	<1301725380-10579-1-git-send-email-lenb@kernel.org>
	<5d9716021b20302ece48fd486bbad9bcb2502353.1301724243.git.len.brown@intel.com>
	<20110402124054.49c3a3f4@lxorguk.ukuu.org.uk>
	<alpine.LFD.2.02.1104021529580.18682@x980>
	<20110402220021.74ecdb5b@lxorguk.ukuu.org.uk>
	<4D97E018.1090504@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4D97E018.1090504@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Trinabh Gupta <trinabh@linux.vnet.ibm.com>
Cc: Len Brown <len.brown@intel.com>, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

> There are other problems too. This design of pm_idle has been copied
> by numerous other architectures. arm/blackfin/cris/ia64/m32r/m68knomm
> /microblaze/mn10300/sh/sparc all have pm_idle. This will keep spreading
> in future I guess.

Presumably because they've decided it is a good model and works for them.
That's a matter for their arch maintainers surely.

> https://lkml.org/lkml/2010/10/19/449 . The problem  is that it
> results in two places of registration: cpuidle subsystem and
> this. It was pointed that 99.99% of people run cpuidle and
> we should directly call cpuidle and use its registration mechanism
> rather than duplicate code.

That makes sense. However what Len is trying to do doesn't seem to.

The most likely case is nobody really needs APM idle now. In which case
Len's first patches (adding the warnings) make sense, but instead of
rushing headlong into everything else a simple years wait until the WARNs
have been in Fedora and co for a few months would avoid any further work
on it. In the mean time it produces a WARN, it can even be marked
__deprecated to ensure nobody else uses it.

The less likely case is that at some point within the year it turns out a
few people do need and care about it, so it needs shuffling into cpuidle
nicely.

In computing terms this seems to be a lazy evaluation problem - why do
all the extra work and risk bugs and problems trying to do things within
one release when you can just let it chill for a year and maybe not do
any work at all ?

Don't let me stop anyone actually doing the work but it seems to be
impatience before sanity ?

Alan
