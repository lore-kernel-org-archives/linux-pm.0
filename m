From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Wed, 4 Jul 2007 11:42:03 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0707041139100.25704-100000@netrider.rowland.org>
References: <E1I63Nv-0006Z9-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <E1I63Nv-0006Z9-00@dorka.pomaz.szeredi.hu>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Paul Mackerras <paulus@samba.org>
Cc: mjg59@srcf.ucam.org, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Kernel development list <linux-kernel@vger.kernel.org>, Miklos Szeredi <miklos@szeredi.hu>
List-Id: linux-pm@vger.kernel.org

On Wed, 4 Jul 2007, Miklos Szeredi wrote:

> And we won't know if drivers are OK until we remove the freezer,
> catch-22.
> 
> So I think we need to disable the freezer at least in -mm and/or
> optionally in -linus.
> 
> I applied Matthew's patch, and suspend did in fact stop working
> (thinkpad t60), but there was nothing catastrophic.  Here's the dmesg
> if somebody is interested:
> 
> Suspending console(s)
> usb_endpoint usbdev5.3_ep83: PM: suspend 0->2, parent 5-2:1.0 already 2
> usb_endpoint usbdev5.3_ep02: PM: suspend 0->2, parent 5-2:1.0 already 2
> usb_endpoint usbdev5.3_ep81: PM: suspend 0->2, parent 5-2:1.0 already 2
> hub 2-0:1.0: suspend error -16
> suspend_device(): usb_suspend+0x0/0x1c() returns -16
> Could not suspend device usb2: error -16
> usb_endpoint usbdev5.3_ep81: PM: resume from 0, parent 5-2:1.0 still 2
> usb_endpoint usbdev5.3_ep02: PM: resume from 0, parent 5-2:1.0 still 2
> usb_endpoint usbdev5.3_ep83: PM: resume from 0, parent 5-2:1.0 still 2
> Some devices failed to suspend

Remember what I wrote a few minutes ago about khubd and ksuspend_usbd
wanting to resume devices during a system suspend transition?  This is
exactly what happens when those threads aren't frozen.

Alan Stern
