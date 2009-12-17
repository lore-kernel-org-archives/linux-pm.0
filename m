From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [GIT PULL] PM updates for 2.6.33
Date: Fri, 18 Dec 2009 10:28:19 +1100
Message-ID: <1261092499.6682.44.camel__20696.9837229282$1261092784$gmane$org@pasglop>
References: <Pine.LNX.4.44L0.0912060953190.4442-100000@netrider.rowland.org>
	<1260158279.27069.181.camel@rzhang1-desktop>
	<alpine.LFD.2.00.0912062122460.3560@localhost.localdomain>
	<alpine.LFD.2.00.0912062204431.3560@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.00.0912062204431.3560@localhost.localdomain>
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
Cc: LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Sun, 2009-12-06 at 22:15 -0800, Linus Torvalds wrote:
> 
> The same is true of the prepare_suspend/suspend split I'm proposing:
> I 
> suspect that for something like USB, it would make most sense to just
> do 
> normal node suspend in prepare_suspend, which would do everything 
> asynchronously. Only USB hub devices would get involved at the later 
> 'suspend()' phase.

Wasn't part of the goal with prepare_suspend() vs. suspend() to handle
the problem of backing store vs the VM ?

IE. Once any device potentially in the VM path is suspended, things like
kmalloc() or gfp() can potentially stall until resume or did we address
that recently ?

Iirc, part of the idea behind prepare_* is that it's safe vs. the above.
Now if you start suspending USB devices at prepare() then you break that
assumption since those could be mass storage with dirty mmap'ed pages on
them.

Now, I'm all for fixing it at the VM/allocator level (if we didn't
already) turning pretty much everything into NO_IO once we start
suspending devices but that's a whole different matter :-)

Cheers,
Ben.
