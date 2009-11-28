From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Question on USB re-enumeration
Date: Sat, 28 Nov 2009 11:38:16 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0911281128430.12776-100000@netrider.rowland.org>
References: <8bf247760911272237l13cb6d4pc6636a20a90c8d3a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <8bf247760911272237l13cb6d4pc6636a20a90c8d3a@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Sriram V <vshrirama@gmail.com>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Sat, 28 Nov 2009, Sriram V wrote:

> Hi Alan,
>   We have a USB GSM externally powered connected through a external
> transceiver phy. Normal suspend-resume works.
>   When we make a call to the GSM chip while in suspend. The resume
> fails and it returns -19.
> 
>   This is coming from file : drivers/usb/core/driver.c - external usb
> resume function.

Here's the important part of the logs, starting just before the
successful and unsuccessful logs differ:

> <7>ehci-omap ehci-omap.0: GetStatus port 2 status 001803 POWER sig=j CSC CONNECT
> <7>hub 1-0:1.0: port 2: status 0501 change 0001
> <7>usb 1-2: reset-resume
> <7>ehci-omap ehci-omap.0: port 2 high speed
> <7>ehci-omap ehci-omap.0: GetStatus port 2 status 001005 POWER sig=se0
> PE CONNECT
> <6>usb 1-2: reset high speed USB device using ehci-omap and address 2
> <7>ehci-omap ehci-omap.0: port 2 high speed
> <7>ehci-omap ehci-omap.0: GetStatus port 2 status 001005 POWER sig=se0
> PE CONNECT

> <7>ehci-omap ehci-omap.0: GetStatus port 2 status 001803 POWER sig=j CSC CONNECT
> <7>hub 1-0:1.0: port 2: status 0501 change 0001
> <7>usb 1-2: reset-resume
> <7>ehci-omap ehci-omap.0: port 2 high speed
> <7>ehci-omap ehci-omap.0: GetStatus port 2 status 001005 POWER sig=se0
> PE CONNECT
> <6>usb 1-2: reset high speed USB device using ehci-omap and address 2
> <7>ehci-omap ehci-omap.0: devpath 2 ep0in 3strikes
> <7>ehci-omap ehci-omap.0: devpath 2 ep0in 3strikes
> <7>ehci-omap ehci-omap.0: devpath 2 ep0in 3strikes
> <7>ehci-omap ehci-omap.0: GetStatus port 2 status 001002 POWER sig=se0 CSC
> <7>hub 1-0:1.0: logical disconnect on port 2

The reason for this difference is that in the unsuccessful case, the
GSM chip could be not reset correctly.  It failed to respond to a
standard USB request.  Maybe it doesn't like to be reset when an
incoming call arrives.

The logs show that the chip appears to get disconnected from the USB
bus at some point during the suspend or resume.  There's no way to know
why this happens, but that is the reason for the reset.  Maybe there's
a bug in your EHCI controller or maybe there's a bug in the GSM chip.

Alan Stern
