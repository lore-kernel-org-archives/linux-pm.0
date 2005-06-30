From: Greg KH <greg@kroah.com>
Subject: Re: [RFC] firmware leaves device in D3hot at boot
Date: Thu, 30 Jun 2005 10:10:10 -0700
Message-ID: <20050630171010.GD11369@kroah.com>
References: <20050623191451.GA20572@tuxdriver.com>
	<20050624022807.GF28077@tuxdriver.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============87771739873202392=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20050624022807.GF28077@tuxdriver.com>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linux-pm <linux-pm@lists.osdl.org>, linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

--===============87771739873202392==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 23, 2005 at 10:28:07PM -0400, John W. Linville wrote:
> On Thu, Jun 23, 2005 at 03:14:52PM -0400, John W. Linville wrote:
> 
> > This issue regarding D3hot->D0 state transitions seems like a piece
> > of minutiae that we should not force individual drivers to address.
> 
> After some thought, I'm inclined to think that the patch below is
> the right one.  It unconditionally saves and restores the PCI config
> registers when pci_enable_device is called.  Although this is often
> (usually?) unnecessary, it seems like a safe thing to do and it should
> not be a performance-sensitive path.  The code to check for whether
> or not this is necessary would be a little harder to read IMHO,
> so I think this is warranted.

But how does this solve your problem with the state change?

> The comment block at the head of pci_enable_device says "Initialize
> device before it's used by a driver" which implies that saving and
> restoring the PCI config should be safe if the function is used
> as intended.

All pci drivers must call pci_enable_device() before they start to use
it.

thanks,

greg k-h

--===============87771739873202392==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============87771739873202392==--
