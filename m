From: Greg KH <greg@kroah.com>
Subject: Re: Bug in PCI core
Date: Fri, 13 Oct 2006 22:34:48 -0700
Message-ID: <20061014053448.GA8105@kroah.com>
References: <Pine.LNX.4.44L0.0610111632240.6353-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0610111632240.6353-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-pci@atrey.karlin.mff.cuni.cz, Linux-pm mailing list <linux-pm@lists.osdl.org>, Kernel development list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Oct 11, 2006 at 04:41:22PM -0400, Alan Stern wrote:
> When a PCI device is suspended, its driver calls pci_save_state() so that
> the config space can be restored when the device is resumed.  Then the
> driver calls pci_set_power_state().
> =

> However pci_set_power_state() calls pci_block_user_cfg_access(), and that =

> routine calls pci_save_state() again.  This overwrites the saved state =

> with data in which memory, I/O, and bus master accesses are disabled.  As =

> a result, when the device is resumed it doesn't work.
> =

> Obviously pci_block_user_cfg_access() needs to be fixed.  I don't know th=
e =

> right way to fix it; hopefully somebody else does.

Yeah, I'm just going to drop the patch from Matthew that added this.
Andrew also noted that it causes bad things to happen on his laptop.

Thanks for pointing it out.

I gotta get suspend working on a machine here so I can test these things
better...

thanks,

greg k-h
