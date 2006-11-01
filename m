From: Andi Kleen <ak@suse.de>
Subject: Re: 2.6.19-rc <-> ThinkPads
Date: Wed, 1 Nov 2006 22:15:51 +0100
Message-ID: <200611012215.51459.ak@suse.de>
References: <Pine.LNX.4.64.0610312123320.25218@g5.osdl.org>
	<200611012034.06128.ak@suse.de>
	<Pine.LNX.4.64.0611011148130.25218@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0611011148130.25218@g5.osdl.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-pm@osdl.org, Ernst Herzberg <earny@net4u.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Adrian Bunk <bunk@stusta.de>, linux-acpi@vger.kernel.org, "Michael S. Tsirkin" <mst@mellanox.co.il>, Hugh Dickins <hugh@veritas.com>, Martin Lorenz <martin@lorenz.eu.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday 01 November 2006 20:52, Linus Torvalds wrote:
> =

> On Wed, 1 Nov 2006, Andi Kleen wrote:
> > =

> > Fix race in IO-APIC routing entry setup.
> > =

> > Interrupt could happen between setting the IO-APIC entry
> > and setting its interrupt data.
> =

> This doesn't fix anything at all.
> =

> The interrupt can come in on another CPU, =


Only BP should be active at this point. At least not until
we implement IO-APIC hotplug, but so far that isn't there.

Ok in theory the BIOS could have put the other CPUs into
weird states where they are still doing something and causing
interrupts, but that would be a BIOS bug.

I suppose it could happen with kexec, but that has still
other problems anyways.

The common case of no kexec shouldn't be affected at least.

-Andi
