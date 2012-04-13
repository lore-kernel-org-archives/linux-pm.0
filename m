From: Steven Rostedt <rostedt-nx8X9YLhiw1AfugRpC6u6w@public.gmane.org>
Subject: Re: [linux-pm] ehci_hcd related S3 lockup on ASUS laptops, again
Date: Fri, 13 Apr 2012 11:32:28 -0400
Message-ID: <1334331148.23924.361.camel@gandalf.stny.rr.com>
References: <Pine.LNX.4.44L0.1204131008010.1185-100000@iolanthe.rowland.org>
	 <1334330949.23924.360.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1334330949.23924.360.camel-f9ZlEuEWxVcI6MkJdU+c8EEOCMrvLtNR@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: Andrey Rahmatullin <wrar-Bxt/JK/G85ezQB+pC5nmwQ@public.gmane.org>, jrnieder-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Fri, 2012-04-13 at 11:29 -0400, Steven Rostedt wrote:

> > 
> > Second, if you do
> > 
> > 	echo 0 >/sys/bus/usb/devices/usb1/bConfigurationValue
> 
> This never returned. I did the echo, and the command locked up.
> 
> (process 3077)
> 
> cat /proc/3077/wchan 
> usb_disconnect
> 

A sysrq-t gives this:

[ 4468.680789] bash            D ffff88022837d7d0     0  3077   3071 0x00000004
[ 4468.680792]  ffff88022c0f7af8 0000000000000086 0000000000000001 ffff88022837d4c0
[ 4468.680796]  ffff88022c0f7fd8 000000000000000a ffff88022c0f7fd8 ffff88022c0f7fd8
[ 4468.680800]  ffff88022837f810 ffff88022837d4c0 ffff88022837d4c0 ffff88022c0f7fd8
[ 4468.680804] Call Trace:
[ 4468.680807]  [<ffffffff813f5a3f>] schedule+0x3f/0x60
[ 4468.680810]  [<ffffffff813f6974>] __mutex_lock_slowpath+0x104/0x1a0
[ 4468.680813]  [<ffffffff813f64a2>] mutex_lock+0x22/0x40
[ 4468.680821]  [<ffffffffa00111a6>] usb_disconnect+0x96/0x140 [usbcore]
[ 4468.680830]  [<ffffffffa001118c>] usb_disconnect+0x7c/0x140 [usbcore]
[ 4468.680837]  [<ffffffffa00112b0>] hub_quiesce+0x60/0xc0 [usbcore]
[ 4468.680844]  [<ffffffffa001147c>] hub_disconnect+0x7c/0x100 [usbcore]
[ 4468.680853]  [<ffffffffa001b092>] usb_unbind_interface+0x52/0x180 [usbcore]
[ 4468.680861]  [<ffffffff812b650c>] __device_release_driver+0x7c/0xe0
[ 4468.680864]  [<ffffffff812b659c>] device_release_driver+0x2c/0x40
[ 4468.680867]  [<ffffffff812b6048>] bus_remove_device+0x78/0xb0
[ 4468.680870]  [<ffffffff812b338d>] device_del+0x12d/0x1b0
[ 4468.680878]  [<ffffffffa0018def>] usb_disable_device+0xaf/0x1d0 [usbcore]
[ 4468.680886]  [<ffffffffa0019778>] usb_set_configuration+0x278/0x6d0 [usbcore]
[ 4468.680890]  [<ffffffff8120f448>] ? sscanf+0x38/0x40
[ 4468.680898]  [<ffffffffa001e5ca>] set_bConfigurationValue+0x6a/0x90 [usbcore]
[ 4468.680901]  [<ffffffff812b24b8>] dev_attr_store+0x18/0x30
[ 4468.680905]  [<ffffffff811a81d2>] sysfs_write_file+0xe2/0x170
[ 4468.680909]  [<ffffffff81139673>] vfs_write+0xb3/0x180
[ 4468.680913]  [<ffffffff8113999a>] sys_write+0x4a/0x90
[ 4468.680916]  [<ffffffff813fe7ab>] system_call_fastpath+0x16/0x1b

-- Steve


--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
