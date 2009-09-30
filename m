From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: suspend vs usb and PS/2 ports
Date: Wed, 30 Sep 2009 23:54:55 +0200
Message-ID: <200909302354.55673.rjw@sisk.pl>
References: <4AC35F86.20405@msgid.tls.msk.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4AC35F86.20405@msgid.tls.msk.ru>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: pm list <linux-pm@lists.linux-foundation.org>, Linux-kernel <linux-kernel@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Wednesday 30 September 2009, Michael Tokarev wrote:
> Hello.
> 
> I've several PCs here which are able to wakeup -
> among others - from PS/2 and/or USB keyboard.
> Here for testing I'm using PS/2 keyboard and
> Asus M3A78-EM motherboard.
> 
> When I do poweroff from linux, the keyboard
> stays powered up as it should (according to
> the BIOS settings).  But when I do suspend,
> keyboard is NOT powered anymore, and hence
> the system can't be woken up from it but only
> by using the power button.
> 
> This happens consistently for many kernel
> versions.  To be fair, I don't even know if
> there was any kernel which does not show this
> behaviour: old versions was unable to do
> suspend/resume cycle on this platform at all.
> 
> Any hints for this please?

With USB, I think keyboard wake-up is off by default as it causes some
systems to wake up immediately after suspending.  Alan and Oliver can provide
more info about that.

I don't know about PS/2.

Can you post the contents of /proc/acpi/wakeup from one of these systems,
please?

Best,
Rafael
