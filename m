From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 10] PM: Measure suspend and resume times for
	individual devices (was: Re: [PATCH 2/6] PM: Asynchronous
	resume of devices)
Date: Mon, 31 Aug 2009 18:00:49 +0200
Message-ID: <200908311800.49664.rjw__29984.2385262766$1251734446$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0908311006490.10295-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0908311006490.10295-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Linux PCI <linux-pci@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Monday 31 August 2009, Alan Stern wrote:
> On Sun, 30 Aug 2009, Rafael J. Wysocki wrote:
> 
> > > > For testing purposes it would be nice to have a one-line summary for
> > > > each device containing a thread ID, start timestamp, end timestamp, and
> > > > elapsed time.  With that information you could evaluate the amount of
> > > > parallelism and determine where the bottlenecks are.  It would give a
> > > > much more detailed picture of the entire process than the total time of
> > > > your recent patch 9.
> > > 
> > > Of course it would.  I think I'll implement it.
> > 
> > OK, below is a patch for that.  It only prints the time elapsed, because the
> > timestamps themselves can be obtained from the usual kernel timestamping.
> 
> Does that include the start timestamps?  I don't see them anywhere in
> the patch.  Without the start timestamps we have no way to know how
> much time was spent waiting for dpm_list_mtx or other resources as
> opposed to actually carrying out the operation.

If the callback in question is actually defined, there will be additional debug
printouts before executing it from which we can get the start timestamps.

If the callback is not defined, the time elapsed will be 0 anyway, which is
kind of untinteresting.

Thanks,
Rafael
