From: Pavel Machek <pavel@ucw.cz>
Subject: Re: linux-next: Tree for Feb 24
Date: Mon, 25 Feb 2008 10:26:28 +0100
Message-ID: <20080225092628.GA493__47412.6829104081$1203946447$gmane$org@elf.ucw.cz>
References: <20080224162309.3e67dd22.sfr@canb.auug.org.au>
	<47C1B52B.3080104@gmail.com> <200802242100.46474.rjw@sisk.pl>
	<47C1FF2E.4060600@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Resent-Message-ID: <20080225113649.GB2855@elf.ucw.cz>
Resent-To: peterz@infradead.org, linux-pm@lists.linux-foundation.org
Content-Disposition: inline
In-Reply-To: <47C1FF2E.4060600@gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Kevin Winchester <kjwinchester@gmail.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, len.brown@intel.com, peterz@infradead.org, LKML <linux-kernel@vger.kernel.org>, linux-next@vger.kernel.org, linux-pm@lists.linux-foundation.org, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

Hi!

> > velocity_suspend() seems to be at fault.
> 
> (gdb) l *(velocity_suspend+0x37)
> 0xc0244665 is in velocity_suspend (drivers/net/via-velocity.c:3399).
> 3394		if(!netif_running(vptr->dev))
> 3395			return 0;
> 3396	
> 3397		netif_device_detach(vptr->dev);
> 3398	
> 3399		spin_lock_irqsave(&vptr->lock, flags);
> 3400		pci_save_state(pdev);
> 3401	#ifdef ETHTOOL_GWOL
> 3402		if (vptr->flags & VELOCITY_FLAGS_WOL_ENABLED) {
> 3403			velocity_get_ip(vptr);
> (gdb) 
> 3404			velocity_save_context(vptr, &vptr->context);
> 3405			velocity_shutdown(vptr);
> 3406			velocity_set_wol(vptr);
> 3407			pci_enable_wake(pdev, PCI_D3hot, 1);
> 3408			pci_set_power_state(pdev, PCI_D3hot);
> 3409		} else {
> 3410			velocity_save_context(vptr, &vptr->context);
> 3411			velocity_shutdown(vptr);
> 3412			pci_disable_device(pdev);
> 3413			pci_set_power_state(pdev, pci_choose_state(pdev, state));
> (gdb) 
> 3414		}
> 3415	#else
> 3416		pci_set_power_state(pdev, pci_choose_state(pdev, state));
> 3417	#endif
> 3418		spin_unlock_irqrestore(&vptr->lock, flags);
> 3419		return 0;
> 3420	}
> 
> So velocity_suspend calls spin_lock_irqsave, and then pci_set_power_state which msleep()s.  Is that the root problem here? (I've added Ingo & Peter to the CC list since they may have some comments on the scheduler/lockdep parts of the trace).

Looks like velocity is broken. Can you try to unload it before sleep
to see if the rest of suspend works for you?

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
