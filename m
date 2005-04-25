From: Adam Belay <ambx1@neo.rr.com>
Subject: Re: [PATCH] PCI: Add pci shutdown ability
Date: Mon, 25 Apr 2005 16:11:33 -0400
Message-ID: <20050425201133.GB3951@neo.rr.com>
References: <Pine.LNX.4.44L0.0504251128070.5751-100000@iolanthe.rowland.org>
	<20050425182951.GA23209@kroah.com>
	<SVLXCHCON1syWVLEFN00000099e@SVLXCHCON1.enterprise.veritas.com>
	<20050425185113.GC23209@kroah.com>
	<20050425190606.GA23763@kroah.com> <426D439D.6080705@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============32407841688763606=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <426D439D.6080705@pobox.com>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: akpm@osdl.org, Amit Gud <gud@eth.net>, USB development list <linux-usb-devel@lists.sourceforge.net>, Pavel Machek <pavel@ucw.cz>, linux-pci@atrey.karlin.mff.cuni.cz, ". Linux-pm mailing list" <linux-pm@lists.osdl.org>, linux-kernel@vger.kernel.org, cramerj@intel.com
List-Id: linux-pm@vger.kernel.org

--===============32407841688763606==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 25, 2005 at 03:23:09PM -0400, Jeff Garzik wrote:
> Greg KH wrote:
> >Well it seems that people are starting to want to hook the reboot
> >notifier, or the device shutdown facility in order to properly shutdown
> >pci drivers to make kexec work nicer.
> >
> >So here's a patch for the PCI core that allows pci drivers to now just
> >add a "shutdown" notifier function that will be called when the system
> >is being shutdown.  It happens just after the reboot notifier happens,
> >and it should happen in the proper device tree order, so everyone should
> >be happy.
> >
> >Any objections to this patch?
> 
> Traditionally the proper place -has- been
> * the reboot notifier
> * the ->remove hook (hot unplug, and module remove)
> 
> which covers all the cases.
> 
> Add a ->shutdown hook is more of a hack.  If you want to introduce this 
> facility in a systematic way, introduce a 'kexec reboot' option which 
> walks the device tree and shuts down hardware.
> 
> ->shutdown is just a piecemeal, uncoordinated effort (uncoordinated in 
> the sense that driver shutdowns occur in an undefined order).
> 
> 	Jeff

I agree, though I think "->remove" may be more than we need.  Another
potential use of this might be to prepare devices just before removing power.

Thanks,
Adam

--===============32407841688763606==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============32407841688763606==--
