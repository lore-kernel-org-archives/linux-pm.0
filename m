From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [dm-devel] dm-crypt low performance
Date: Tue, 13 Jan 2009 15:00:59 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0901131456570.27985-100000__42322.3647092984$1231877186$gmane$org@iolanthe.rowland.org>
References: <200901140122.14374.rrs@researchut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200901140122.14374.rrs@researchut.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ritesh Raj Sarraf <rrs@researchut.com>
Cc: device-mapper development <dm-devel@redhat.com>, linux-pm@lists.linux-foundation.org, Milan Broz <mbroz@redhat.com>
List-Id: linux-pm@vger.kernel.org

On Wed, 14 Jan 2009, Ritesh Raj Sarraf wrote:

> Okay!! I think I now have the correct steps to reproduce it consistently.
...
> The above result is from a freshly booted linux with the same suspected faulty 
> USB HDD enclosure. I ran it on 2 kernels, one standard and one debug, and both 
> gave similar results.
> So shouldn't be faulty hardware.
> 
> 
> So then with my standard kernel, I booted + hibernated and then resumed and 
> then again ran the I/O. Here are the same results.
...
> So this seems to be happening on my laptop when the OS has used the 
> hibernation feature. I'm of-course doing a luksClose and USB device 
> disconnection before hibernation.

And presumably you reconnect the USB device after resuming.  That 
reconnect appears to be where the problem arises.

> Here's the usb device listing after hibernation/resume.
> 
> rrs@learner:~$ cat /tmp/lsusb.suspend
> Bus 005 Device 005: ID 046d:08c6 Logitech, Inc. QuickCam for DELL Notebooks
> Bus 005 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
> Bus 004 Device 007: ID 05e3:0702 Genesys Logic, Inc. USB 2.0 IDE Adapter
> Bus 004 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
> Bus 003 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
> Bus 002 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
> Bus 001 Device 005: ID 046d:c00c Logitech, Inc. Optical Wheel Mouse
> Bus 001 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub

Notice that the IDE Adapter is now attached to a 1.1 bus rather than a
2.0 bus.  That's why it's running so much slower.

> And here's the usb device listing after a fresh boot.
> 
> rrs@learner:~$ lsusb
> Bus 005 Device 004: ID 05e3:0702 Genesys Logic, Inc. USB 2.0 IDE Adapter
> Bus 005 Device 003: ID 046d:08c6 Logitech, Inc. QuickCam for DELL Notebooks
> Bus 005 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
> Bus 002 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
> Bus 003 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
> Bus 004 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
> Bus 001 Device 004: ID 046d:c00c Logitech, Inc. Optical Wheel Mouse
> Bus 001 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub

Try building a kernel with CONFIG_USB_DEBUG enabled, and post the dmesg 
log showing what happens during the disconnect, hibernate, resume, and 
reconnect.

You could also try the same thing with no disconnect/reconnect.  Just 
leave the IDE adapter plugged in the whole time.

Alan Stern
