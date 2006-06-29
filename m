From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Wed, 28 Jun 2006 17:48:36 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606281743420.12404@g5.osdl.org>
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
	<20060629003736.GA6001@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060629003736.GA6001@kroah.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Greg KH <greg@kroah.com>
Cc: David Brownell <david-b@pacbell.net>, linux-pm@lists.osdl.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org



On Wed, 28 Jun 2006, Greg KH wrote:
> =

> I now have a patch in my quilt tree for the network core that moves all
> network devices to be class_devices.  With this (2 small driver core
> patches are needed to get this to build and work properly, look in the
> tree if you're really interested), when we walk the devices, the
> subsystem devices get called on the list before the "real" devices (that
> are attached to a bus.)
> =

> For example, on my box, I now have:
> $ tree /sys/class/net/
> /sys/class/net/
> |-- eth0 -> ../../devices/pci0000:00/0000:00:02.0/0000:01:00.2/0000:03:0e=
.0/eth0
> |-- eth1 -> ../../devices/pci0000:00/0000:00:02.0/0000:01:00.2/0000:03:0c=
.0/eth1
> `-- lo -> ../../devices/lo

Ok, that looks good. =


> Now the network subsystem can stop the queue, or do whatever it wanted
> to do with no extra headaches or special cases by the driver core at
> all.
> =

> Which is what I think you are really wanting here, subsystems doing the
> work for their class of devices, which makes it much easier on all of
> the individual drivers.

Yes, that is definitely going to help.

I still want the individual drivers be able to split up their high-level =

functions ("device discovery/recovery behind this bus device") from their =

low-level functions ("power on the bus device"), exactly so that we can =

suspend/resume the actual motherboard devices as a totally separate pass =

of suspending/resuming the "rest of the system".

That's what the dpm_active <-> dpm_off <-> dpm_off_irq transitions give =

us in my patch - clearly separate stages for what happens "early", and =

what happens "late". =


			Linus
