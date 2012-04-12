From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: ehci_hcd related S3 lockup on ASUS laptops, again
Date: Thu, 12 Apr 2012 14:25:50 -0400
Message-ID: <1334255150.23924.342.camel@gandalf.stny.rr.com>
References: <Pine.LNX.4.44L0.1204121337380.1496-100000@iolanthe.rowland.org>
	<1334254672.23924.341.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1334254672.23924.341.camel@gandalf.stny.rr.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: jrnieder@gmail.com, Greg KH <greg@kroah.com>, USB list <linux-usb@vger.kernel.org>, Andrey Rahmatullin <wrar@wrar.name>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thu, 2012-04-12 at 14:17 -0400, Steven Rostedt wrote:

> And I forgot that the echo isn't enough, and I need to do a pm-suspend
> too ;-)
> 
> # dmesg | grep target
> [ 8829.427534] atl1c 0000:04:00.0: target 3 wakeup 0 error 0
> [ 8829.443524] xhci_hcd 0000:03:00.0: target 3 wakeup 1 error 0
> [ 8829.459506] iwlwifi 0000:02:00.0: target 3 wakeup 0 error 0
> [ 8829.459560] pci 0000:00:1f.3: target 0 wakeup 0 error 0
> [ 8829.459607] pci 0000:00:1f.0: target 0 wakeup 0 error 0
> [ 8829.475458] ehci_hcd 0000:00:1d.0: target 3 wakeup 1 error 0
> [ 8829.491433] ehci_hcd 0000:00:1a.0: target 3 wakeup 1 error 0
> [ 8829.507416] pci 0000:00:16.0: target 3 wakeup 0 error 0
> 

The above was without the script, with the script:

# dmesg | grep target
[ 8829.427534] atl1c 0000:04:00.0: target 3 wakeup 0 error 0
[ 8829.443524] xhci_hcd 0000:03:00.0: target 3 wakeup 1 error 0
[ 8829.459506] iwlwifi 0000:02:00.0: target 3 wakeup 0 error 0
[ 8829.459560] pci 0000:00:1f.3: target 0 wakeup 0 error 0
[ 8829.459607] pci 0000:00:1f.0: target 0 wakeup 0 error 0
[ 8829.475458] ehci_hcd 0000:00:1d.0: target 3 wakeup 1 error 0
[ 8829.491433] ehci_hcd 0000:00:1a.0: target 3 wakeup 1 error 0
[ 8829.507416] pci 0000:00:16.0: target 3 wakeup 0 error 0
[ 9419.750158] atl1c 0000:04:00.0: target 3 wakeup 0 error 0
[ 9419.766134] pci 0000:03:00.0: target 3 wakeup 1 error 0
[ 9419.782126] iwlwifi 0000:02:00.0: target 3 wakeup 0 error 0
[ 9419.782181] pci 0000:00:1f.3: target 0 wakeup 0 error 0
[ 9419.782230] pci 0000:00:1f.0: target 0 wakeup 0 error 0
[ 9419.798087] pci 0000:00:1d.0: target 3 wakeup 1 error 0
[ 9419.814064] pci 0000:00:1a.0: target 3 wakeup 1 error 0
[ 9419.830031] pci 0000:00:16.0: target 3 wakeup 0 error 0

-- Steve
