From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PCI PM: Restore standard config registers of
	all devices early (was: Re: EeePC resume failure - timers)
Date: Tue, 20 Jan 2009 00:26:17 +0100
Message-ID: <200901200026.18539.rjw__39051.3902683326$1232407900$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0901161010400.2417-100000@iolanthe.rowland.org>
	<alpine.LFD.2.00.0901200850560.3081@localhost.localdomain>
	<alpine.LFD.2.00.0901200917320.2930@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.00.0901200917320.2930@localhost.localdomain>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, john stultz <johnstul@us.ibm.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, Linux PCI <linux-pci@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Monday 19 January 2009, Linus Torvalds wrote:
> 
> On Tue, 20 Jan 2009, Linus Torvalds wrote:
> > 
> > It also seems to have trouble restoring the second time, but it still 
> > seems like a big improvement to not restoring at all ;)
> 
> .. and this issue seems to be about X restore, not about the kernel. I can 
> suspend/restore many many times if I use "acpi_sleep=s3_bios,s3_mode" and 
> just stay in text-mode. But X won't restore the second time around.
> 
> So this machine does have several issues, but your patch definitely 
> improves on parts of it.

Good, thanks for testing! :-)

The patch is in the Jesse's tree now.

Thanks,
Rafael
