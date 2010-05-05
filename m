From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: s2ram slow (radeon) / failing (usb)
Date: Wed, 5 May 2010 17:35:31 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1005051724260.1885-100000__36149.6128178716$1273096210$gmane$org@iolanthe.rowland.org>
References: <alpine.LNX.2.00.1005052255350.9849@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LNX.2.00.1005052255350.9849@pobox.suse.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Oliver Neukum <oneukum@suse.de>, list <linux-usb@vger.kernel.org>, Kernel development list <linux-kernel@vger.kernel.org>, =?ISO-8859-15?Q?Bruno_Pr=E9mont?= <bonbons@linux-vserver.org>, linux-pm@lists.linux-foundation.org, jslaby@suse.cz
List-Id: linux-pm@vger.kernel.org

On Wed, 5 May 2010, Jiri Kosina wrote:

> > > Ok, I've been digging some further...
> > > 
> > > The hid_device_probe properly returns -ENODEV, but:
> > > 
> > > Call trace:
> > > [ 3228.866146]  [<ffffffffa01a00e6>] hid_device_probe+0xd6/0x1f0 [hid]
> > >     return -ENODEV
> > > [ 3228.874594]  [<ffffffff8130995a>] driver_probe_device+0xaa/0x1d0
> > >     calls inlined really_probe from drivers/base/dd.c
> > >     which ALLWAYS returns 0:
> > >      dd.c:147 /*
> > >           148  * Ignore errors returned by ->probe so that the next driver can try
> > >           149  * its luck.
> > >           150  */
> > >           151 ret = 0;
> > >      and has on line 139 (under same failure label):
> > >               dev->driver = NULL;
> > > [ 3228.882758]  [<ffffffff81309b20>] ? __device_attach+0x0/0x50
> > > [ 3228.890555]  [<ffffffff81309b6b>] __device_attach+0x4b/0x50
> > >      lets 0 bubble up
> > > [ 3228.898272]  [<ffffffff81308d28>] bus_for_each_drv+0x68/0x90
> > >      lets 0 bubble up
> > > [ 3228.906080]  [<ffffffff81309c3b>] device_attach+0x8b/0xa0
> > >      lets 0 bubble up
> > > [ 3228.913603]  [<ffffffff81308b15>] bus_probe_device+0x25/0x40
> > >      returns void and does WARN_ON(device_attach() < 0)
> > > [ 3228.921356]  [<ffffffff81307166>] device_add+0x3d6/0x610
> > >      returns 0 here as there was no local error
> > > [ 3228.928772]  [<ffffffffa019fc53>] hid_add_device+0x183/0x1e0 [hid]
> > > [ 3228.937098]  [<ffffffffa01b4a77>] usbhid_probe+0x287/0x420 [usbhid]
> > > [ 3228.945535]  [<ffffffffa005006d>] usb_probe_interface+0x14d/0x230 [usbcore]
> > > ...
> > > 
> > > So IMHO in hid_add_device() we should also check for hdev->dev.driver
> > > when device_add() returns 0 and consider that one being NULL as a
> > > (possible) error.

Note that it is perfectly normal for devices to be registered on a bus 
without a driver.  Perhaps the usbhid core doesn't expect this, though, 
or perhaps it doesn't make sense for HID devices.  Regardless, I don't 
see how this could cause the problem.

Earlier, Bruno said that the hang occurs in hid_cancel_delayed_stuff(), 
presumably during one of its cancel_work_sync() calls, and presumably 
because the workqueue has been frozen.  But as far as I can tell, 
cancel_work_sync() should work just fine if the workqueue has been 
frozen.  Maybe this should be investigated more closely.

Bruno, can you confirm that the hang occurs during one of those 
cancel_work_sync() calls?

Alan Stern
