From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFT] PCI changes related to wakeup (was: Re:
	ehci_hcd related S3 lockup on ASUS laptops, again)
Date: Mon, 28 May 2012 22:13:01 +0200
Message-ID: <201205282213.01560.rjw@sisk.pl>
References: <20120526223611.GF5012@belkar.wrar.name>
	<Pine.LNX.4.44L0.1205271238040.14937-100000@netrider.rowland.org>
	<20120527211714.GC4994@belkar.wrar.name>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20120527211714.GC4994@belkar.wrar.name>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andrey Rahmatullin <wrar@wrar.name>, Steven Rostedt <rostedt@goodmis.org>
Cc: ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Sunday, May 27, 2012, Andrey Rahmatullin wrote:
> On Sun, May 27, 2012 at 12:41:43PM -0400, Alan Stern wrote:
> > > > > > Andrey, Stephen,
> > > > > > 
> > > > > > We still have problems with this patch in https://bugzilla.kernel.org/show_bug.cgi?id=43278
> > > > > > so some more testing will be necessary, I'm afraid.
> > > > > > 
> > > > > > I will send a series of ACPI and PCI patches I have collected so far,
> > > > > > that I'd like you to test on top of kernel 3.4.0 with commit
> > > > > > 151b61284776 reverted.
> > > > > > 
> > > > > > Please let me know if suspend/wakeup work for you with these patches applied.
> > > > > I get the usual freeze on suspending with these patches.
> > > > 
> > > > I see.
> > > > 
> > > > Please try to unapply [4/4] and see if that helps.
> > > It helps.
> > 
> > Andrey, can you try out Rafael's patches 1-3 (with 151b... reverted)  
> > and see what happens if the EHCI controllers' power/wakeup sysfs
> > atributes are first set to "disabled"?
> It freezes.

Well, that means trying to work around this through changing the algorithm
of selecting the target state of a device wasn't a good idea after all.

Still, we've found some bugs in the process, so it was worth the effort.

Please attach the output of dmidecode from your machine.
Steven, please do that too.

Thanks,
Rafael
