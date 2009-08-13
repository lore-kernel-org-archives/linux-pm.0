From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC][PATCH 0/3] PM: Asynchronous suspend and resume
Date: Thu, 13 Aug 2009 14:39:21 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0908131435490.8368-100000__33411.4018398852$1250189608$gmane$org@iolanthe.rowland.org>
References: <200908132028.53094.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200908132028.53094.rjw@sisk.pl>
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
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

On Thu, 13 Aug 2009, Rafael J. Wysocki wrote:

> > If the set of pm_connection objects is reasonably small then the
> > master_hook and slave_hook aren't needed; you can just read through the
> > entire list.  Leaving out parent-child connections, which we already
> > know, would help shrink the set.
> 
> Do you mean a global list for the entire system?  I'm not sure if that wouldn't
> hurt performance (please note that it also affects runtime PM).

It doesn't have to affect runtime PM.  That is, for runtime PM we can 
make the bus subsystems responsible for enforcing the dependencies.

> We could use counters of "suspended slaves" and "active masters" to optimize
> things, but still updating these counters could take time (one has to find all
> devices dependent on given one and update a counter for each of them).

The problem with counters is that devices can be removed in the middle 
of a suspend or resume.  That would mess up the counter values.

Alan Stern
