From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC][PATCH 0/3] PM: Asynchronous suspend and resume
Date: Thu, 13 Aug 2009 10:45:57 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0908131031060.2940-100000__22526.4679910199$1250174819$gmane$org@iolanthe.rowland.org>
References: <200908122343.20554.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200908122343.20554.rjw@sisk.pl>
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

On Wed, 12 Aug 2009, Rafael J. Wysocki wrote:

> I have an idea.
> 
> Every such dependency involves two devices, one of which is a "master"
> and the second of which is a "slave", meaning that the "slave" have to be
> suspended before the "master" and cannot be resumed before it.  In principle
> we could give each device two lists of "dependency objects", one containing
> "dependency objects" where the device is the "master" and the other containing
> "dependency objects" where the device is the "slave".  Then, each "dependency
> object" could be represented as
> 
> struct pm_connection {
>     struct device *master;
>     struct list_head master_hook;
>     struct device *slave;
>     struct list_head slave_hook;
> };
> 
> Add some locking, helpers for adding / removing "dependency objects" etc.
> and it should work.  Instead of checking the parent, walk the list of
> "masters", instead of walking the list of children, walk the list of "slaves".

If the set of pm_connection objects is reasonably small then the
master_hook and slave_hook aren't needed; you can just read through the
entire list.  Leaving out parent-child connections, which we already
know, would help shrink the set.

The layout of the pm_connection objects could then be improved
slightly.  Each object could contain a variable-sized array of device
pointers together with two integers, M and S.  The first M pointers
would be masters and the remaining S pointers would be slaves.  This
could be useful when, for example, a large number of devices all depend
on one particular power device.

> The core could create those objects for parent-child relationships
> automatically, the other ones would have to be added by platforms / bus types /
> drivers etc.
> 
> This approach has a problem that it's prone to adding circular dependencies by
> mistake, but then I think it would apply to any other approach just as well.

Yes.  In theory we could detect such cycles at runtime, but it's 
probably not worth the effort.

Alan Stern
