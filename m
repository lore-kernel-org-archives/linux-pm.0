From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: ehci_hcd related S3 lockup on ASUS laptops, again
Date: Thu, 12 Apr 2012 13:48:54 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1204121337380.1496-100000@iolanthe.rowland.org>
References: <1334250896.23924.340.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1334250896.23924.340.camel@gandalf.stny.rr.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: jrnieder@gmail.com, Greg KH <greg@kroah.com>, USB list <linux-usb@vger.kernel.org>, Andrey Rahmatullin <wrar@wrar.name>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thu, 12 Apr 2012, Steven Rostedt wrote:

> On Thu, 2012-04-12 at 13:06 -0400, Alan Stern wrote:
> 
> > > Where do I read out the dev info?
> > 
> > It should appear in the dmesg log after the system returns from the 
> > suspend test.
> 
> That's what I thought. I didn't see any message there so I had to ask.

Oh, my mistake.  This routine doesn't get called when pm_test is set to 
"devices"; you have to set it to "platform".  Sorry about that.

> > Maybe that's the problem here.  Steve and Andrey, does it make any 
> > difference to the behavior if you do
> > 
> > 	echo on >/sys/bus/pci/devices/0000:00:1a.0/power/control
> > 
> > (and likewise for 1d.0) before starting the system suspend?
> 
> The two files already are set to "on" (without me doing anything)

Okay, so that's not the reason...

Alan Stern
