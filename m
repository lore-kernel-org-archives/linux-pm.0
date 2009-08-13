From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH 0/3] PM: Asynchronous suspend and resume
Date: Thu, 13 Aug 2009 20:28:52 +0200
Message-ID: <200908132028.53094.rjw__46046.535348478$1250188687$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0908131031060.2940-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0908131031060.2940-100000@iolanthe.rowland.org>
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
> On Wed, 12 Aug 2009, Rafael J. Wysocki wrote:
> 
> > I have an idea.
> > 
> > Every such dependency involves two devices, one of which is a "master"
> > and the second of which is a "slave", meaning that the "slave" have to be
> > suspended before the "master" and cannot be resumed before it.  In principle
> > we could give each device two lists of "dependency objects", one containing
> > "dependency objects" where the device is the "master" and the other containing
> > "dependency objects" where the device is the "slave".  Then, each "dependency
> > object" could be represented as
> > 
> > struct pm_connection {
> >     struct device *master;
> >     struct list_head master_hook;
> >     struct device *slave;
> >     struct list_head slave_hook;
> > };
> > 
> > Add some locking, helpers for adding / removing "dependency objects" etc.
> > and it should work.  Instead of checking the parent, walk the list of
> > "masters", instead of walking the list of children, walk the list of "slaves".
> 
> If the set of pm_connection objects is reasonably small then the
> master_hook and slave_hook aren't needed; you can just read through the
> entire list.  Leaving out parent-child connections, which we already
> know, would help shrink the set.

Do you mean a global list for the entire system?  I'm not sure if that wouldn't
hurt performance (please note that it also affects runtime PM).

We could use counters of "suspended slaves" and "active masters" to optimize
things, but still updating these counters could take time (one has to find all
devices dependent on given one and update a counter for each of them).

> The layout of the pm_connection objects could then be improved
> slightly.  Each object could contain a variable-sized array of device
> pointers together with two integers, M and S.  The first M pointers
> would be masters and the remaining S pointers would be slaves.  This
> could be useful when, for example, a large number of devices all depend
> on one particular power device.

I'm not sure.  If we use the coutners, this case will be quite easy to handle.

Thanks,
Rafael
