From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFT] PCI changes related to wakeup (was: Re: [linux-pm]
 ehci_hcd related S3 lockup on ASUS laptops, again)
Date: Fri, 01 Jun 2012 13:01:57 -0400
Message-ID: <1338570117.13348.469.camel@gandalf.stny.rr.com>
References: <Pine.LNX.4.44L0.1206011157570.1610-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.1206011157570.1610-100000@iolanthe.rowland.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, "Oleksij Rempel (fishor)" <bug-track@fisher-privat.net>, =?ISO-8859-1?Q?D=E2niel?= Fraga <fragabr@gmail.com>, Andrey Rahmatullin <wrar@wrar.name>, linux-pm@lists.linux-foundation.org, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, 2012-06-01 at 11:59 -0400, Alan Stern wrote:
>  
> > I even plugged in a USB keyboard, suspended, and tried to wake it up
> > with that. That did not work. I even enabled what you stated above, with
> > no effect (with keyboard or usb storage).
> 
> This suggests that the original version of the patch is superior.  
> There's not point in saying the controller is wakeup-capable and trying 
> to enable wakeup if it's not going to work.

I would point out that I have yet to get wakeup via usb to work with any
patch.

Maybe I missed a patch, which one is suppose to work?

-- Steve


