From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: Bug in PCI core
Date: Fri, 13 Oct 2006 19:13:52 +0200
Message-ID: <1160759632.14815.4.camel@laptopd505.fenrus.org>
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
Cc: linux-pci@atrey.karlin.mff.cuni.cz, Matthew Wilcox <matthew@wil.cx>, Linux-pm mailing list <linux-pm@lists.osdl.org>, Kernel development list <linux-kernel@vger.kernel.org>, Adam Belay <abelay@MIT.EDU>
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

> Which is why the kernel caches the register state. =


but... it didn't USE the cache in the case we're protecting here.
Instead the hardware would just go splat.
