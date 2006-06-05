From: <rasmit.ranjan@wipro.com>
Subject: Re: [linux-usb-devel] Problem in HCD resume
Date: Mon, 5 Jun 2006 09:43:45 +0530
Message-ID: <380D9721A8E2114485644D71E87C6AB201F6971E@PNE-HJN-MBX01.wipro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-class: urn:content-classes:message
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: stern@rowland.harvard.edu
Cc: linux-pm@lists.osdl.org, linux-usb-devel@lists.sourceforge.net
List-Id: linux-pm@vger.kernel.org

 =


> -----Original Message-----
> From: Alan Stern [mailto:stern@rowland.harvard.edu] =

> Sent: Friday, June 02, 2006 8:59 PM
> To: Rasmit Ranjan (WT01 - Semiconductors & Consumer Electronics)
> Cc: linux-pm@lists.osdl.org; linux-usb-devel@lists.sourceforge.net
> Subject: Re: [linux-usb-devel] Problem in HCD resume
> =

> On Fri, 2 Jun 2006 rasmit.ranjan@wipro.com wrote:
> =

> > Hi,
> > 	I was trying suspend/resume of OHCI based host =

> controller. I suspend =

> > the device interface, device/port and the roothub interface/bus =

> > selectively through sysfs.
> > According to Power Management sub-system if I resume the roothub =

> > interface the all the downsteam devices( device/port and device
> > interface) should be resumed.
> =

> This isn't true at all.  Selective resume of a device through =

> sysfs is _not_ expected to change the power state of the =

> device's children.  The fact that it does for USB devices is =

> an historical artifact.  This behavior will change in the near future.

I am using 2.6.15.4. So here if I resume the bus then the device and the
device interfaces are resumed. As far as  the power state is concerned,
for device interfaces the power state is changed to 0 but for the device
it is not changed to 0. It remains 3. =

> =

> >  That means power state file of
> > roothub,port/device,device interface should be 0. But power =

> state of =

> > the port/device remains 3.
> > 	I tried finding out the reasons. I went through the kernel code.
> > What I found out is, resuming any node is initiated through =

> > usb_generic_device API. In that API first we change the
> > dev->power.power_state.event =3D PM_EVENT_ON which is the =

> notification =

> > dev->to
> > PM sub-system that now the device is not in suspended =

> state, it is on =

> > now and the power state file of the node is changed to 0. When I =

> > traced the path for my case i.e. resuming the bus.
> > Here it goes:
> > =

> > =

> Usb_generic_resume-->hub_resume-->hcd_bus_resume-->ohci_bus_resume-->f
> > in
> > ish_device_resume.
> > =

> > Actually finish_device_resume is called from hub_resume and the =

> > parameter passed to finish_device_resume is the usb_device =

> structure =

> > representing the device connected. Then for all the =

> interfaces of the =

> > device finish_device_resume calls usb_generic_resume.
> > So it is clear that expect the device all other node`s resume is =

> > initiated from usb_generic_resume and this is the only API =

> which does
> > dev->power.power_state.event =3D PM_EVENT_ON. As for device =

> resume this =

> > dev->is
> > not done, its power state remains 3 although the device is actually =

> > resumed.
> > =

> > Is my understanding correct?
> =

> It's hard to say, since you mentioned some things that don't =

> matter and left out the big part that _does_ matter: The code =

> in hub_resume that resumes child devices doesn't call =

> usb_generic_resume.

Yes. I did not say this anywhere. I said hub_resume calls
finish_device_resume with the parameter representing the device
connected to the port and finish_device_resume calls usb_generic_resume
for resuming the device interfaces. usb_generic_resume is not called for
the device resume and usb_generic resume only changes the power state to
ON. That is the reason why the power state of the device is not changed
to 0.

> =

> >  If yes then is it a known issue ? I am using kernel 2.6.15.4.
> > So is ther any patch available for this?
> =

> No.  You can write one if you want.  Since there will soon be =

> a patch that prevents the hub driver from waking up child =

> devices, your problem probably doesn't matter.
> =

> Alan Stern
> =

> =
