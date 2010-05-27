From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Thu, 27 May 2010 18:49:18 +0100
Message-ID: <20100527184918.3d090921__39315.1797507473$1274982314$gmane$org@lxorguk.ukuu.org.uk>
References: <20100526142430.327ccbc4@schatten.dmk.lab>
	<20100526141612.3e2e0443@lxorguk.ukuu.org.uk>
	<AANLkTin97MMu-XO_Lk-snefBWz2ymhS0Qi1y1RxLwdVA@mail.gmail.com>
	<20100527003943.07c17f85@lxorguk.ukuu.org.uk>
	<20100527140655.GA28048@srcf.ucam.org>
	<alpine.LFD.2.00.1005271642440.3032@localhost.localdomain>
	<20100527155201.GA31937@srcf.ucam.org>
	<alpine.LFD.2.00.1005271808340.3032@localhost.localdomain>
	<20100527165931.GB1062@srcf.ucam.org>
	<alpine.LFD.2.00.1005271905000.3032@localhost.localdomain>
	<20100527172343.GB2468@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100527172343.GB2468@srcf.ucam.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Paul@smtp1.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, Arve@smtp1.linux-foundation.org, Florian Mickler <florian@mickler.org>, Linux@smtp1.linux-foundation.org, Thomas Gleixner <tglx@linutronix.de>, List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, felipe.balbi@nokia.com
List-Id: linux-pm@vger.kernel.org

> What is a "Correctly implemented driver" in this case? One that receives 
> a wakeup event and then prevents suspend being entered until userspace 
> has acknowledged that event? Because that's what an in-kernel suspend 
> blocker is.

Kernel side maybe - but even then its a subset of expressing
latency/lowest level requirements. That bit isn't really too contentious.
You need a kernel object to hang a constraint off.

> ACPI provides no guarantees about what level of hardware functionality 
> remains during S3. You don't have any useful ability to determine which 
> events will generate wakeups. And from a purely practical point of view, 
> since the latency is in the range of seconds, you'll never have a low 
> enough wakeup rate to hit it.

So PCs with current ACPI don't get opportunistic suspend capability. It
probably won't be supported on the Commodore Amiga either - your point ?

> Suspend blockers are the mechanism for the 
> driver to indicate whether the wakeup event has been handled. That's 
> what they're there for. The in-kernel ones don't paper over anything.

Semantically the in kernel blockers and the in kernel expression of
device driven constraints are the same thing except that instead of 
yes/no you replace the boolean with information.


So we go from

	block_suspend() / unblock_suspend()

to
	add_pm_constraint(latency, level) 
	remove_pm_constraint(latency, level);


And if Android choses to interpret that in its policy code as

	if (latency > MAGIC)
		suspend_is_cool();
	else
		suspend_isnt_cool();

that's now isolated in droidspace policy

Alan
