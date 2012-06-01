From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFT] PCI changes related to wakeup (was: Re:
 ehci_hcd related S3 lockup on ASUS laptops, again)
Date: Fri, 1 Jun 2012 12:33:09 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1206011231300.1610-100000@iolanthe.rowland.org>
References: <20120601160106.GD4879@belkar.wrar.name>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20120601160106.GD4879@belkar.wrar.name>
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
Cc: =?iso-8859-1?Q?D=E2niel?= Fraga <fragabr@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, "Oleksij Rempel (fishor)" <bug-track@fisher-privat.net>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Fri, 1 Jun 2012, Andrey Rahmatullin wrote:

> > I applied the patch, it suspends and resumes fine, but still no wakeup.
> > 
> > I even plugged in a USB keyboard, suspended, and tried to wake it up
> > with that. That did not work. I even enabled what you stated above, with
> > no effect (with keyboard or usb storage).
> The same here, and the keyboard LEDs turn off on suspending.

The LEDs are expected to turn off during suspend; that's normal.  
Otherwise they would use up unnecessary electrical power.

Alan Stern
