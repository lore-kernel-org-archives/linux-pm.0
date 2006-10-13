From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Bug in PCI core
Date: Sat, 14 Oct 2006 09:00:25 +1000
Message-ID: <1160780425.4792.275.camel@localhost.localdomain>
References: <Pine.LNX.4.44L0.0610131024340.6460-100000@iolanthe.rowland.org>
	<1160753187.25218.52.camel@localhost.localdomain>
	<1160753390.3000.494.camel@laptopd505.fenrus.org>
	<1160755562.25218.60.camel@localhost.localdomain>
	<1160757260.26091.115.camel@localhost.localdomain>
	<1160759349.25218.62.camel@localhost.localdomain>
	<20061013164933.GD11633@parisc-linux.org>
	<1160760867.25218.77.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1160760867.25218.77.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Matthew Wilcox <matthew@wil.cx>, linux-pci@atrey.karlin.mff.cuni.cz, Linux-pm mailing list <linux-pm@lists.osdl.org>, Kernel development list <linux-kernel@vger.kernel.org>, Adam Belay <abelay@MIT.EDU>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Fri, 2006-10-13 at 18:34 +0100, Alan Cox wrote:
> Ar Gwe, 2006-10-13 am 10:49 -0600, ysgrifennodd Matthew Wilcox:
> > No it didn't.  It's undefined behaviour to perform *any* PCI config
> > access to the device while it's doing a D-state transition.  It may have
> =

> I think you missed the earlier parts of the story - the kernel caches
> the base config register state.
> =

> > happened to work with the chips you tried it with, but more likely you
> > never hit that window because X simply didn't try to do that.
> =

> Which is why the kernel caches the register state. This all came up long
> ago and the solution we currently have was the one chosen after
> considerable debate and analysis about things like locking. We preserved
> the historical reliable interface going back to the early Linux PCI
> support and used by all the apps.

Well, we have two different things here.

One is short term block. For example, PM transitions, or BIST. In that
case, I reckon it might be worth just making the user space PCI config
space accessors block in the kernel during the transition (a wait
queue ?)

One is long term block: the device is off. That's where it becomes
tricky. For D3, I suppose it's actually correct to return cached infos
provided that those do actually cache the PM capability indicating D3
state (that is we need to update the cache after the transition). And
it's correct to prevent writes too I suppose.

Then there are problems with things like embedded or some Apple ASICs
where we toggle power/clock lines of devices but not directly using PCI
PM (in fact, those devices might not even have PCI PM capability
exposed). Returning cached info is fine, but we can't tell userland
about the powered off (or unclocked) state of the device that way.

Ben.
