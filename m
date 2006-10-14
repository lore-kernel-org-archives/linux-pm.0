From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Bug in PCI core
Date: Fri, 13 Oct 2006 22:33:04 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0610132229230.22133-100000@netrider.rowland.org>
References: <1160780425.4792.275.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1160780425.4792.275.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Matthew Wilcox <matthew@wil.cx>, linux-pci@atrey.karlin.mff.cuni.cz, Linux-pm mailing list <linux-pm@lists.osdl.org>, Kernel development list <linux-kernel@vger.kernel.org>, Adam Belay <abelay@MIT.EDU>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Sat, 14 Oct 2006, Benjamin Herrenschmidt wrote:

> Well, we have two different things here.
> =

> One is short term block. For example, PM transitions, or BIST. In that
> case, I reckon it might be worth just making the user space PCI config
> space accessors block in the kernel during the transition (a wait
> queue ?)

That seems like a reasonable thing to do.  (BTW, can anyone explain =

quickly what "BIST" means?)

> One is long term block: the device is off. That's where it becomes
> tricky. For D3, I suppose it's actually correct to return cached infos
> provided that those do actually cache the PM capability indicating D3
> state (that is we need to update the cache after the transition). And
> it's correct to prevent writes too I suppose.
> =

> Then there are problems with things like embedded or some Apple ASICs
> where we toggle power/clock lines of devices but not directly using PCI
> PM (in fact, those devices might not even have PCI PM capability
> exposed). Returning cached info is fine, but we can't tell userland
> about the powered off (or unclocked) state of the device that way.

Now you're starting to tread in the dangerous waters of runtime PM
userspace APIs.  So far nobody has figured out a good general way of
exposing internal power states to userspace.  There may not even be such a =

thing.

Alan Stern
