From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] Longhaul - call suspend(PMSG_FREEZE) before
	and resume() after
Date: Sun, 28 May 2006 07:16:22 +0000
Message-ID: <20060528071622.GA4108@ucw.cz>
References: <4478D319.2030707@interia.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <4478D319.2030707@interia.pl>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Rafa Bilski <rafalbilski@interia.pl>, kernel list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> I posted this to Dave Jones, but:
> > This really should also get posted to linux-kernel, though I don't
> > think people are going to be particularly enthusiastic about exposing
> > these innards to modules.
> So I'm posting this patch here too. I'm not subscribed to this list.
> If You wish email me.
> Minor change: preempt_disabled() goto_sleep_pci() and wakeup_pci() =

> causes "sheduling while atomic". So in this patch below it isn't
> preempt_disabled(). But I think that this should be protected
> in some way. =


Well, suspend/resume is normally called during system suspend/resume,
so it has 'interesting' locking requirements.

> How it works:
> 1. Call suspend(PMSG_FREEZE) for each block device.
> 2. Call suspend(PMSG_FREEZE) for each PCI device.
> 3. Change CPU frequency.
> 4. Call resume() for each PCI device.
> 5. Call resume() for each block device.
> =

> Result: No more broken DMA transfers caused by frequency change.

Result: system hang if userspace tries to do request at the same time
-- PCI drivers probably were not designed for _that_... but we
probably want to fix them, anyway, so this is probably ok (but expect
to do some driver debugging).

But you should really add that preempt_disable and not try this on smp
system...
						Pavel

-- =

Thanks for all the (sleeping) penguins.
