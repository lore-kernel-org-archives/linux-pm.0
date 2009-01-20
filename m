From: Daniel Qarras <dqarras@yahoo.com>
Subject: Re: [PATCH] PCI PM: Restore standard config registers of
	all devices early (was: Re: EeePC resume failure - timers)
Date: Tue, 20 Jan 2009 08:21:21 -0800 (PST)
Message-ID: <749196.15280.qm@web36808.mail.mud.yahoo.com>
References: <alpine.LFD.2.00.0901200850560.3081@localhost.localdomain>
Reply-To: dqarras@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.00.0901200850560.3081@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: john stultz <johnstul@us.ibm.com>, Ingo Molnar <mingo@elte.hu>, Jesse Barnes <jbarnes@virtuousgeek.org>, Linux PCI <linux-pci@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> There's something fishy there in that it restores
> immediately rather than waiting for me to press the power
> button, but I guess that's quite possibly the (unrelated)
> issue with the PM wake event changes that went into -rc1. 

Not sure is this anything related that all but I reported similar issues few days ago, something also happened between 2.6.23 and 2.6.24:

https://lists.linux-foundation.org/pipermail/linux-pm/2009-January/019225.html

It was diagnosed that one workaround was to unload ehci-hcd:

https://lists.linux-foundation.org/pipermail/linux-pm/2009-January/019251.html

Cheers!




      
