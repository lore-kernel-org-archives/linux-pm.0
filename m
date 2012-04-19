From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: ehci_hcd related S3 lockup on ASUS laptops, again
Date: Thu, 19 Apr 2012 12:06:47 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1204191205540.2070-100000@iolanthe.rowland.org>
References: <20120419155309.GA11484@belkar.wrar.name>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20120419155309.GA11484@belkar.wrar.name>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andrey Rahmatullin <wrar@wrar.name>
Cc: jrnieder@gmail.com, linux-pm@lists.linux-foundation.org, USB list <linux-usb@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 19 Apr 2012, Andrey Rahmatullin wrote:

> On Thu, Apr 19, 2012 at 09:43:45AM -0400, Alan Stern wrote:
> > But before going any farther, I'd like to test if USB wakeup works.  
> > So after booting with this patch, make sure that the power/wakeup file
> > says "enabled" in the sysfs path for each controller as well as the
> > usb1, usb2, 1-2, and 2-2 paths under /sys/bus/usb/devices/.
> Also, I don't have [12]-2 there:
> 
> 1-0:1.0 -> ../../../devices/pci0000:00/0000:00:1a.0/usb1/1-0:1.0
> 1-1 -> ../../../devices/pci0000:00/0000:00:1a.0/usb1/1-1
> 1-1.1 -> ../../../devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.1
> 1-1.1:1.0 -> ../../../devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.1/1-1.1:1.0
> 1-1.1:1.1 -> ../../../devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.1/1-1.1:1.1
> 1-1.2 -> ../../../devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.2
> 1-1.2:1.0 -> ../../../devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.2/1-1.2:1.0
> 1-1.2:1.1 -> ../../../devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.2/1-1.2:1.1
> 1-1:1.0 -> ../../../devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1:1.0
> 2-0:1.0 -> ../../../devices/pci0000:00/0000:00:1d.0/usb2/2-0:1.0
> 2-1 -> ../../../devices/pci0000:00/0000:00:1d.0/usb2/2-1
> 2-1:1.0 -> ../../../devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1:1.0
> usb1 -> ../../../devices/pci0000:00/0000:00:1a.0/usb1
> usb2 -> ../../../devices/pci0000:00/0000:00:1d.0/usb2

My apologies, I meant 1-1 and 2-1.  (The number following the '-' is a 
port number, not a device address.)

Alan Stern
