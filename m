From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Wed, 28 Jun 2006 17:37:36 -0700
Message-ID: <20060629003736.GA6001@kroah.com>
References: <Pine.LNX.4.44L0.0606211219170.6700-100000@iolanthe.rowland.org>
	<200606221130.30614.david-b@pacbell.net>
	<Pine.LNX.4.64.0606221210350.5498@g5.osdl.org>
	<200606231106.46863.david-b@pacbell.net>
	<Pine.LNX.4.64.0606231216290.6483@g5.osdl.org>
	<20060623233244.GB4264@neo.rr.com>
	<Pine.LNX.4.64.0606231622580.6483@g5.osdl.org>
	<20060624024230.GB3438@neo.rr.com>
	<Pine.LNX.4.64.0606231953560.6483@g5.osdl.org>
	<Pine.LNX.4.64.0606232029200.6483@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606232029200.6483@g5.osdl.org>
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
Cc: David Brownell <david-b@pacbell.net>, linux-pm@lists.osdl.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Fri, Jun 23, 2006 at 09:07:36PM -0700, Linus Torvalds wrote:
> The sane version has a very simple sequence:
> =

>  - devices start on "dpm_active". =

> =

>  - "suspend_prepare()" is called for every device (with the semaphore =

>    held, you are _not_ allowed to try to unlink yourself in the prepare =

>    function)
> =

>  - then, we iterate over every device, and move it from "dpm_active" to =

>    "dpm_off" when calling "suspend()". The suspend function is now the =

>    subsystem suspend, followed by the device bus suspend.

Well, the driver core doesn't have to do this "ordering" anymore.

I now have a patch in my quilt tree for the network core that moves all
network devices to be class_devices.  With this (2 small driver core
patches are needed to get this to build and work properly, look in the
tree if you're really interested), when we walk the devices, the
subsystem devices get called on the list before the "real" devices (that
are attached to a bus.)

For example, on my box, I now have:
$ tree /sys/class/net/
/sys/class/net/
|-- eth0 -> ../../devices/pci0000:00/0000:00:02.0/0000:01:00.2/0000:03:0e.0=
/eth0
|-- eth1 -> ../../devices/pci0000:00/0000:00:02.0/0000:01:00.2/0000:03:0c.0=
/eth1
`-- lo -> ../../devices/lo

Those eth0 and eth1 devices will have their "suspend()" call done first
before the devices/pci0000:00/0000:00:02.0/0000:01:00.2/0000:03:0e.0
device, which is the network pci driver for that card because those
"eth0" and "eth1" devices are now on the dpm_active list in the proper
location within the tree.

Now the network subsystem can stop the queue, or do whatever it wanted
to do with no extra headaches or special cases by the driver core at
all.

Which is what I think you are really wanting here, subsystems doing the
work for their class of devices, which makes it much easier on all of
the individual drivers.

The patch is really messy as it's just a big s/class_device/device/ in
the network core, that's why I'm not posting it here.  It's on
kernel.org if you're interested.

thanks,

greg k-h
