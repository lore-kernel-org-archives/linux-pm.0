From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Bug in PCI core
Date: Fri, 13 Oct 2006 16:59:45 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0610131657540.8377-100000@iolanthe.rowland.org>
References: <20061013191854.GF11633@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20061013191854.GF11633@parisc-linux.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Matthew Wilcox <matthew@wil.cx>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-pci@atrey.karlin.mff.cuni.cz, Linux-pm mailing list <linux-pm@lists.osdl.org>, Kernel development list <linux-kernel@vger.kernel.org>, Adam Belay <abelay@MIT.EDU>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Fri, 13 Oct 2006, Matthew Wilcox wrote:

> On Fri, Oct 13, 2006 at 01:57:48PM -0400, Alan Stern wrote:
> > Would it be okay for pci_block_user_cfg_access() to use its own cache, =
so =

> > it doesn't interfere with data previously cached by pci_save_state()?
> =

> My suggestion is just to require that the callers have previously called
> pci_save_state().  The PCI PM stack already has, and it's a one-line
> change to the IPR driver.

Okay.  Would you like to write a patch with that fix?  Be sure to add a =

comment explaining the need for a previous call to pci_save_state().

At least it will get things going for now, even if it isn't perfectly
correct in the long run.

Alan Stern
