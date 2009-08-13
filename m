From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH 0/3] PM: Asynchronous suspend and resume
Date: Thu, 13 Aug 2009 23:10:26 +0200
Message-ID: <200908132310.26539.rjw__43488.0571476699$1250198078$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0908131435490.8368-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0908131435490.8368-100000@iolanthe.rowland.org>
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
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

On Thursday 13 August 2009, Alan Stern wrote:
> On Thu, 13 Aug 2009, Rafael J. Wysocki wrote:
> 
> > > If the set of pm_connection objects is reasonably small then the
> > > master_hook and slave_hook aren't needed; you can just read through the
> > > entire list.  Leaving out parent-child connections, which we already
> > > know, would help shrink the set.
> > 
> > Do you mean a global list for the entire system?  I'm not sure if that wouldn't
> > hurt performance (please note that it also affects runtime PM).
> 
> It doesn't have to affect runtime PM.  That is, for runtime PM we can 
> make the bus subsystems responsible for enforcing the dependencies.

Since the runtime PM framework takes the parent-child relationships into
accout, I think it should also follow the "master"-"slave" dependencies if they
are represented at the core level.

Still, at this point the question really is how many off-tree dependencies
there are, because the best way to represent them will follow from that.

Thanks,
Rafael
