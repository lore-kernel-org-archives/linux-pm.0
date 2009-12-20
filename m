From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Async suspend-resume patch w/ completions (was: Re:
	Async suspend-resume patch w/ rwsems)
Date: Sun, 20 Dec 2009 20:51:01 +0100
Message-ID: <200912202051.01328.rjw__2094.62099378488$1261338655$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0912201434340.27137-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0912201434340.27137-100000@netrider.rowland.org>
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
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sunday 20 December 2009, Alan Stern wrote:
> On Sun, 20 Dec 2009, Rafael J. Wysocki wrote:
> 
> > BTW, what's the right place to call device_enable_async_suspend() for USB
> > devices?
> 
> For USB devices, it's in drivers/usb/core/hub.c:usb_new_device() 
> anywhere before the call to usb_device_add().
> 
> For USB interfaces, it's in 
> drivers/usb/core/message.c:usb_set_configuration() before the call to 
> device_add().
> 
> For USB endpoints, it's in 
> drivers/usb/core/endpoint.c:usb_create_ep_devs() before the call to 
> device_register().

Thanks!

> However you won't need to do it for interfaces and endpoints if you 
> automatically treat as async any device without suspend/resume 
> callbacks.

I don't do that right now and I need these settings just for testing at the
moment.

Rafael
