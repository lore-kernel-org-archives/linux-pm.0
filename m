From: Adam Belay <ambx1@neo.rr.com>
Subject: Re: [PATCH] PCI: Add pci shutdown ability
Date: Mon, 25 Apr 2005 16:24:55 -0400
Message-ID: <20050425202454.GE27771@neo.rr.com>
References: <Pine.LNX.4.44L0.0504251128070.5751-100000@iolanthe.rowland.org>
	<20050425182951.GA23209@kroah.com>
	<SVLXCHCON1syWVLEFN00000099e@SVLXCHCON1.enterprise.veritas.com>
	<20050425185113.GC23209@kroah.com>
	<20050425190606.GA23763@kroah.com>
	<20050425200825.GA3951@neo.rr.com>
	<20050425201949.GA24695@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============52050261687757349=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20050425201949.GA24695@kroah.com>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Greg KH <greg@kroah.com>
Cc: akpm@osdl.org, Amit Gud <gud@eth.net>, USB development list <linux-usb-devel@lists.sourceforge.net>, Pavel Machek <pavel@ucw.cz>, Linux-pm mailing list <linux-pm@lists.osdl.org>, linux-pci@atrey.karlin.mff.cuni.cz, jgarzik@pobox.com, linux-kernel@vger.kernel.org, cramerj@intel.com
List-Id: linux-pm@vger.kernel.org

--===============52050261687757349==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 25, 2005 at 01:19:49PM -0700, Greg KH wrote:
> On Mon, Apr 25, 2005 at 04:08:25PM -0400, Adam Belay wrote:
> > I think this could be important for any type of device, so the power
> > management subsystem and driver core should handle it.  I'm not really
> > sure if it's useful in pci alone, as it lacks the necessary ordering and
> > coordination.
> 
> The driver core today _does_ handle this properly, and in the correct
> order.  I'm just allowing pci drivers access to that functionality, as
> today they can not take advantage of it.  That's all this patch does.

sorry, I didn't notice this after a quick glance :)

> +       drv->driver.shutdown = pci_device_shutdown,

Ok, great.  I understand.

> 
> > I'm currently developing an interface for quieting devices without turning
> > them off in my Power Management model.  Pavel seems to also have plans along
> > those lines:
> 
> <snip>

I think the intention here may have been to use PM_FREEZE via *suspend.  It
isn't currently supported though.

> 
> Great, then it will tie into the current driver model code, which will
> then call the proper pci driver code, and everyone will be happy :)
> 
> thanks,
> 
> greg k-h

Thanks,
Adam

--===============52050261687757349==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============52050261687757349==--
