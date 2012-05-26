From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFT] PCI changes related to wakeup (was: Re: ehci_hcd
	related S3 lockup on ASUS laptops, again)
Date: Sat, 26 May 2012 23:16:29 +0200
Message-ID: <201205262316.30096.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.1205252157430.24286-100000@saphir.localdomain>
	<1338005001.13348.279.camel@gandalf.stny.rr.com>
	<201205262227.47442.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201205262227.47442.rjw@sisk.pl>
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

On Saturday, May 26, 2012, Rafael J. Wysocki wrote:
> On Saturday, May 26, 2012, Steven Rostedt wrote:
> > On Fri, 2012-05-25 at 22:01 -0400, Alan Stern wrote:
> > > Steve and Andrey:
> > > 
> > > It turns out that the proposed solution for your problem causes a
> > > regression on other ASUS computers (see Bugzilla 43278).  Rafael's got a
> > > proposal for a replacement.
> > > 
> > > Can you try out the patch attached to comment #61 of Bugzilla 42728?  It
> > > may even allow USB wakeup to work for you (but I wouldn't count on it!).
> > > Thanks.
> > 
> > I added the patch against 3.4 and my laptop still suspends.
> > 
> > And no, wakeup still doesn't work.
> > 
> > Tested-by: Steven Rostedt <rostedt@goodmis.org>
> 
> Thanks!
> 
> Unfortunately, I have no idea what to do to make wakeup work on the
> affected machines.

Andrey, Stephen,

We still have problems with this patch in https://bugzilla.kernel.org/show_bug.cgi?id=43278
so some more testing will be necessary, I'm afraid.

I will send a series of ACPI and PCI patches I have collected so far,
that I'd like you to test on top of kernel 3.4.0 with commit
151b61284776 reverted.

Please let me know if suspend/wakeup work for you with these patches applied.

Thanks,
Rafael
