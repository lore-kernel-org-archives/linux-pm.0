From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: ehci_hcd related S3 lockup on ASUS laptops, again
Date: Thu, 12 Apr 2012 13:14:56 -0400
Message-ID: <1334250896.23924.340.camel@gandalf.stny.rr.com>
References: <Pine.LNX.4.44L0.1204121247430.1496-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1204121247430.1496-100000@iolanthe.rowland.org>
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

On Thu, 2012-04-12 at 13:06 -0400, Alan Stern wrote:

> > Where do I read out the dev info?
> 
> It should appear in the dmesg log after the system returns from the 
> suspend test.

That's what I thought. I didn't see any message there so I had to ask.


> Maybe that's the problem here.  Steve and Andrey, does it make any 
> difference to the behavior if you do
> 
> 	echo on >/sys/bus/pci/devices/0000:00:1a.0/power/control
> 
> (and likewise for 1d.0) before starting the system suspend?

The two files already are set to "on" (without me doing anything)

-- Steve
