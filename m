From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] PCI PM: Restore standard config registers of
 all devices early (was: Re: EeePC resume failure - timers)
Date: Wed, 21 Jan 2009 06:45:45 +1100 (EST)
Message-ID: <alpine.LFD.2.00.0901210642570.2885__46403.3250151717$1232480983$gmane$org@localhost.localdomain>
References: <Pine.LNX.4.44L0.0901161010400.2417-100000@iolanthe.rowland.org>
	<200901200945.37371.jbarnes@virtuousgeek.org>
	<alpine.LFD.2.00.0901210613030.3457@localhost.localdomain>
	<200901201130.17987.jbarnes@virtuousgeek.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200901201130.17987.jbarnes@virtuousgeek.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, john stultz <johnstul@us.ibm.com>, Linux PCI <linux-pci@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org



On Tue, 20 Jan 2009, Jesse Barnes wrote:
> 
> Hm it's probably not display programming related then... Sounds like the 
> i830_update_dri_buffers() call is failing for some reason.  The kernel driver 
> does do some I/O mapping stuff at enter/leavevt time (and therefore 
> suspend/resume time), can you reproduce the issue just by VT switching?  If 
> so you might be able to see something useful in the kernel log...

I was going to say that I've been VT switching and it has worked, but I 
decided to double-check. And yes, I can reproduce it that way. And no, no 
kernel messages that are visible that way either. 

		Linus
