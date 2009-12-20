From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Async suspend-resume patch w/ completions (was: Re:
 Async suspend-resume patch w/ rwsems)
Date: Sun, 20 Dec 2009 14:38:23 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0912201434340.27137-100000__39145.5734069043$1261338024$gmane$org@netrider.rowland.org>
References: <200912201910.26895.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200912201910.26895.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sun, 20 Dec 2009, Rafael J. Wysocki wrote:

> BTW, what's the right place to call device_enable_async_suspend() for USB
> devices?

For USB devices, it's in drivers/usb/core/hub.c:usb_new_device() 
anywhere before the call to usb_device_add().

For USB interfaces, it's in 
drivers/usb/core/message.c:usb_set_configuration() before the call to 
device_add().

For USB endpoints, it's in 
drivers/usb/core/endpoint.c:usb_create_ep_devs() before the call to 
device_register().

However you won't need to do it for interfaces and endpoints if you 
automatically treat as async any device without suspend/resume 
callbacks.

Alan Stern
