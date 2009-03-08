From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC][PATCH][1/8] PM: Rework handling of interrupts
 during suspend-resume (rev. 5)
Date: Sun, 8 Mar 2009 10:20:22 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.0903081014430.19207__37576.2440883138$1236532996$gmane$org@localhost.localdomain>
References: <Pine.LNX.4.44L0.0903072248030.8870-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0903072248030.8870-100000@netrider.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, "Eric W. Biederman" <ebiederm@xmission.com>, pm list <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org



On Sat, 7 Mar 2009, Alan Stern wrote:
> 
> You didn't answer my question.  Why bother to distinguish between 
> "wake-up" interrupts and non-"wake-up" interrupts?
> 
> In other words, why not simply abort the suspend if IRQ_PENDING is set
> for _any_ interrupt during sysdev_suspend()?

.. because some drivers might not actually shut down the hardware until 
they get to "suspend_late"? If even then, for that matter - a driver may 
simply not care, knowing that the hardware will be powered off, and will 
be re-initialized at resume.

The thinking that you have to shut your hardware down at "->suspend()" 
time is a _disease_. There are literally classes of hardware out there 
where that would be an outright _bug_, like for a PCI bridge device. For 
many devices, "suspend()" has to be the phase where you shut down the 
_external_ stuff (eg for a disk controller, it's when you'd flush and stop 
your disks), but the controller itself may well be alive until later.

			Linus
