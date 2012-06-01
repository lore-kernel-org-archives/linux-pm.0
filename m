From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFT] PCI changes related to wakeup (was: Re:
 ehci_hcd related S3 lockup on ASUS laptops, again)
Date: Fri, 1 Jun 2012 13:17:18 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1206011313560.1610-100000@iolanthe.rowland.org>
References: <1338570117.13348.469.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1338570117.13348.469.camel@gandalf.stny.rr.com>
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
Cc: ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, =?ISO-8859-1?Q?D=E2niel?= Fraga <fragabr@gmail.com>, Andrey Rahmatullin <wrar@wrar.name>, "Oleksij Rempel (fishor)" <bug-track@fisher-privat.net>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Fri, 1 Jun 2012, Steven Rostedt wrote:

> On Fri, 2012-06-01 at 11:59 -0400, Alan Stern wrote:
> >  
> > > I even plugged in a USB keyboard, suspended, and tried to wake it up
> > > with that. That did not work. I even enabled what you stated above, with
> > > no effect (with keyboard or usb storage).
> > 
> > This suggests that the original version of the patch is superior.  
> > There's not point in saying the controller is wakeup-capable and trying 
> > to enable wakeup if it's not going to work.
> 
> I would point out that I have yet to get wakeup via usb to work with any
> patch.
> 
> Maybe I missed a patch, which one is suppose to work?

No, I think it's more likely that USB wakeup simply can't be made to
work on your computer.  Whatever caused the original suspend problem
also interferes with wakeup.

Alan Stern
