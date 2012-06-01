From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFT] PCI changes related to wakeup (was: Re:
 ehci_hcd related S3 lockup on ASUS laptops, again)
Date: Fri, 1 Jun 2012 11:59:17 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1206011157570.1610-100000@iolanthe.rowland.org>
References: <1338565844.13348.468.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1338565844.13348.468.camel@gandalf.stny.rr.com>
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

> > > Why do you want to skip the wakeup setting in that case?
> > 
> > Because that's what the 151b61284776 commit did.  Also, the quirk marks 
> > the controller as not wakeup-capable.
> > 
> > Still, it's worth testing.  Andrey and Steve, here's an updated patch 
> > which should leave wakeup enabled on your EHCI controllers.  If you 
> > don't have a USB keyboard handy for generating a wakeup signal, you 
> > can test the wakeup functionality by doing:
> > 
> > 	echo enabled >/sys/bus/usb/devices/usb1/power/wakeup
> > 	echo enabled >/sys/bus/usb/devices/usb2/power/wakeup
> > 
> > before suspending.  (In fact you need only one of those two lines, but
> > at the moment I forget which -- probably the usb2 one.)  Then while
> > the system is asleep, either plugging or unplugging a USB device
> > directly into the computer should cause it to wake up.
> 
> I applied the patch, it suspends and resumes fine, but still no wakeup.
> 
> I even plugged in a USB keyboard, suspended, and tried to wake it up
> with that. That did not work. I even enabled what you stated above, with
> no effect (with keyboard or usb storage).

This suggests that the original version of the patch is superior.  
There's not point in saying the controller is wakeup-capable and trying 
to enable wakeup if it's not going to work.

Alan Stern
