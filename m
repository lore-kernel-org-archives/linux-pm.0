From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: s2ram slow (radeon) / failing (usb)
Date: Fri, 7 May 2010 10:29:25 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1005071028320.9849__14232.9469942071$1273221055$gmane$org@pobox.suse.cz>
References: <Pine.LNX.4.44L0.1005061426160.1708-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1005061426160.1708-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Oliver Neukum <oneukum@suse.de>, list <linux-usb@vger.kernel.org>, Kernel development list <linux-kernel@vger.kernel.org>, =?ISO-8859-15?Q?Bruno_Pr=E9mont?= <bonbons@linux-vserver.org>, linux-pm@lists.linux-foundation.org, jslaby@suse.cz
List-Id: linux-pm@vger.kernel.org

On Thu, 6 May 2010, Alan Stern wrote:

> On Thu, 6 May 2010, Bruno [UTF-8] Pr=C3=A9mont wrote:
> =

> > > Bruno, can you confirm that the hang occurs during one of those =

> > > cancel_work_sync() calls?
> > =

> > No, it's not one of the cancel_work_sync() that hangs but it's the
> > del_timer_sync() right before them that hangs!
> > (del_timer_sync() also hangs if I put it last, so the cancel_work_sync()
> > don't hang anything)
> > =

> > static void hid_cancel_delayed_stuff(struct usbhid_device *usbhid)
> > {
> > 	del_timer_sync(&usbhid->io_retry); /* this one never returns */
> > 	cancel_work_sync(&usbhid->restart_work);
> > 	cancel_work_sync(&usbhid->reset_work);
> > }
> =

> Okay, I see what the problem is.  In usbhid_start() there's a bunch of
> statements initializing parts of the usbhid structure.  When probing
> fails those statements don't get executed, so the timer and workqueue
> things aren't set up properly.
> =

> This patch should fix it.

Indeed, good catch, thanks a lot Alan!

Could you please send to me with your Signed-off-by: line and short =

changelog, so that I could apply it with proper credit being given to you?

And Bruno, thanks a lot for excellent testing efforts.

-- =

Jiri Kosina
SUSE Labs, Novell Inc.
