From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [Suspend-devel] Suspending to SD card on an Asus EEE
	PC
Date: Sun, 3 Feb 2008 22:37:01 +0100
Message-ID: <200802032237.02078.rjw__5505.34214494309$1202074850$gmane$org@sisk.pl>
References: <20080129065648.GA28550@sfu.ca>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080129065648.GA28550@sfu.ca>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Max Whitney <mwhitney@sfu.ca>
Cc: suspend-devel@lists.sourceforge.net, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday, 29 of January 2008, Max Whitney wrote:
> I've been trying to use Uswsusp to suspend to disk on my Asus EEE PC using an
> SD card as the resume device. The suspend program appears to run successfully
> with no errors, but the resume program doesn't do anything besides print the
> message that says it's running. On further examination, the Uswsusp signature
> is not on the disk after suspending and rebooting.    
> 
> The problem seems to be that the two calls to fsync in the write_image() function
> in suspend.c fail, leaving errno set to 5 and perror reporting "Input/output error". 
> 
> I'm not sure if this is a Uswsusp problem or just my configuration, but I'm
> not sure what to try now. Is suspending to a removable device (I think it's
> a USB device internally) just a bad idea? Any advice, or ideas on how to
> continue debugging?

Actually, this is a kernel problem.

In short, the kernel disconnects removable storage devices before putting them
into low power states and this cannot be fixed totally cleanly, AFAICS.

If this is a USB device, you may try to set CONFIG_USB_PERSIST in the kernel
config (this is not a safe option, though).

Thanks,
Rafael
