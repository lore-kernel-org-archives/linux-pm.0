From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 2/6] PM: Asynchronous resume of devices
Date: Sat, 29 Aug 2009 20:48:51 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0908292043500.26533-100000__45814.1695395627$1251593487$gmane$org@netrider.rowland.org>
References: <200908291449.57667.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200908291449.57667.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux PCI <linux-pci@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Sat, 29 Aug 2009, Rafael J. Wysocki wrote:

> I only wanted to say that the advantage is not really that "big". :-)
> 
> > I must agree, 14 threads isn't a lot.  But at the moment that number is 
> > random, not under your control.
> 
> It's not directly controlled, but there are some interactions between the
> async threads, the main threads and the async framework that don't allow this
> number to grow too much.
> 
> IMO it sometimes is better to allow things to work themselves out, as long as
> they don't explode, than to try to keep everything under strict control.  YMMV.

For testing purposes it would be nice to have a one-line summary for
each device containing a thread ID, start timestamp, end timestamp, and
elapsed time.  With that information you could evaluate the amount of
parallelism and determine where the bottlenecks are.  It would give a
much more detailed picture of the entire process than the total time of
your recent patch 9.

Alan Stern
