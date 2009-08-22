From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH 1/3] PM: Asynchronous resume of devices
Date: Sat, 22 Aug 2009 23:45:24 +0200
Message-ID: <200908222345.24834.rjw__13139.1058596366$1250977726$gmane$org@sisk.pl>
References: <200908122218.13975.rjw@sisk.pl> <200908152259.18417.rjw@sisk.pl>
	<20090822092429.GC11448@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090822092429.GC11448@elf.ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

On Saturday 22 August 2009, Pavel Machek wrote:
> Hi!
> 
> > > Do we really need async for noirq handlers?
> > 
> > Yes, we do.  Specifically, for PCI.
> 
> Do noirq parts of PCI handling really so long that we need to make
> them async?

I think so.  It may get 10 ms to handle a PCI device at this stage usually
and this is all waiting.  If you multiply that by the number of PCI devices ...

> Async in normal paths looks pretty much okay to me, but in noirq
> parts, locking is tricky, etc...

The locking is actually simpler in that case.

Thanks,
Rafael
