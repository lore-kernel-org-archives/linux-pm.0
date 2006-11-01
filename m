From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: 2.6.19-rc <-> ThinkPads
Date: Wed, 1 Nov 2006 11:52:52 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0611011148130.25218@g5.osdl.org>
References: <Pine.LNX.4.64.0610312123320.25218@g5.osdl.org>
	<200611011825.47710.ak@suse.de>
	<Pine.LNX.4.64.0611011003270.25218@g5.osdl.org>
	<200611012034.06128.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200611012034.06128.ak@suse.de>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-pm@osdl.org, Ernst Herzberg <earny@net4u.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Adrian Bunk <bunk@stusta.de>, linux-acpi@vger.kernel.org, "Michael S. Tsirkin" <mst@mellanox.co.il>, Hugh Dickins <hugh@veritas.com>, Martin Lorenz <martin@lorenz.eu.org>
List-Id: linux-pm@vger.kernel.org



On Wed, 1 Nov 2006, Andi Kleen wrote:
> =

> Fix race in IO-APIC routing entry setup.
> =

> Interrupt could happen between setting the IO-APIC entry
> and setting its interrupt data.

This doesn't fix anything at all.

The interrupt can come in on another CPU, and if we end up having an =

affinity change due to that, we then have "set_ioapic_affinity_irq()" =

called on that other irq, and it might get to mess with the cpumask =

because we dropped the ioapic_lock.

In other words, the problem is not that interrupts were re-enabled, the =

problem is literally that the locking is _wrong_. =


It's a small window, but we simply should not release the ioapic_lock in =

between setting the routing and doing the "set_native_irq_info()" call.

So I think doing the locking inside "ioapic_write_entry()" is simply =

fundamentally wrong. When you did the cleanup, your commit message talked =

about how it might add a few more lock/unlock things:

    In a few cases the IO APIC lock is taken more often now, but this
    isn't a problem because it's all initialization/shutdown only
    slow path code.

but the point is, this is not about "performance". It's about =

_correctness_.

			Linus
