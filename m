From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFT] PCI changes related to wakeup (was: Re: [linux-pm]
 ehci_hcd related S3 lockup on ASUS laptops, again)
Date: Fri, 01 Jun 2012 13:23:55 -0400
Message-ID: <1338571435.13348.470.camel@gandalf.stny.rr.com>
References: <Pine.LNX.4.44L0.1206011313560.1610-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.1206011313560.1610-100000@iolanthe.rowland.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, "Oleksij Rempel (fishor)" <bug-track@fisher-privat.net>, =?ISO-8859-1?Q?D=E2niel?= Fraga <fragabr@gmail.com>, Andrey Rahmatullin <wrar@wrar.name>, linux-pm@lists.linux-foundation.org, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, 2012-06-01 at 13:17 -0400, Alan Stern wrote:
>  
> > Maybe I missed a patch, which one is suppose to work?
> 
> No, I think it's more likely that USB wakeup simply can't be made to
> work on your computer.  Whatever caused the original suspend problem
> also interferes with wakeup.

OK, that's what I thought, as it doesn't even work with Windows.

-- Steve


