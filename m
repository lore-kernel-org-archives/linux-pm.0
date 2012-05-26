From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFT] PCI changes related to wakeup (was: Re:
	ehci_hcd related S3 lockup on ASUS laptops, again)
Date: Sun, 27 May 2012 00:59:03 +0200
Message-ID: <201205270059.04166.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.1205261839180.3174-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1205261839180.3174-100000@netrider.rowland.org>
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
Cc: Andrey Rahmatullin <wrar@wrar.name>, linux-pm@lists.linux-foundation.org, Steven Rostedt <rostedt@goodmis.org>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sunday, May 27, 2012, Alan Stern wrote:
> On Sun, 27 May 2012, Andrey Rahmatullin wrote:
> 
> > On Sun, May 27, 2012 at 12:06:01AM +0200, Rafael J. Wysocki wrote:
> > > > > Andrey, Stephen,
> > > > > 
> > > > > We still have problems with this patch in https://bugzilla.kernel.org/show_bug.cgi?id=43278
> > > > > so some more testing will be necessary, I'm afraid.
> > > > > 
> > > > > I will send a series of ACPI and PCI patches I have collected so far,
> > > > > that I'd like you to test on top of kernel 3.4.0 with commit
> > > > > 151b61284776 reverted.
> > > > > 
> > > > > Please let me know if suspend/wakeup work for you with these patches applied.
> > > > I get the usual freeze on suspending with these patches.
> > > 
> > > I see.
> > > 
> > > Please try to unapply [4/4] and see if that helps.
> > It helps.
> 
> Trying to follow the ACPI spec too closely may be a bad idea.  We 
> should try to copy what Windows does (whatever that is!).

Well, that's why I made it a separate patch, among other things. :-)

So, do you think we should apply [1/4] and [2/4] and try to work around the
BIOS bug from https://bugzilla.kernel.org/show_bug.cgi?id=43278 (I suppose
we can do that by double checking if the target state returned by ACPI is
in agreement with the capabilities returned by the PCI layer)?

Rafael
