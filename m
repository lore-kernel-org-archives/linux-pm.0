From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH 0/3] PM: Asynchronous suspend and resume
Date: Wed, 12 Aug 2009 23:43:20 +0200
Message-ID: <200908122343.20554.rjw__10435.8690827668$1250113418$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0908121702520.23954-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0908121702520.23954-100000@iolanthe.rowland.org>
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

On Wednesday 12 August 2009, Alan Stern wrote:
> On Wed, 12 Aug 2009, Rafael J. Wysocki wrote:
> 
> > Hi,
> > 
> > The following patches introduce a mechanism allowing us to execute device
> > drivers' suspend and resume callbacks asynchronously during system sleep
> > transitions, such as suspend to RAM.  The idea is explained in the [1/1] patch
> > message.
> > 
> > Comments welcome.
> 
> I get the idea.  Not bad.

Thanks!

> Have you tried it in a serious way?  For example, turning on the
> async_suspend flag for every device?

No, I've only tested it with a few selected drivers.  I'm going to try the
"async everyone" scenario, though.

> In one way it isn't as efficient as it could be.  You fire off a bunch
> of async threads and then make many of them wait for parent or child
> devices.  They could be doing useful work instead.

I kind of agree, but then the patches would be more complicated.

> It would be interesting to invent a way of representing explicitly the 
> non-tree dependencies -- assuming there aren't too many of them!  (I 
> can just hear the TI guys hollering about power and timer domains...)

I have an idea.

Every such dependency involves two devices, one of which is a "master"
and the second of which is a "slave", meaning that the "slave" have to be
suspended before the "master" and cannot be resumed before it.  In principle
we could give each device two lists of "dependency objects", one containing
"dependency objects" where the device is the "master" and the other containing
"dependency objects" where the device is the "slave".  Then, each "dependency
object" could be represented as

struct pm_connection {
    struct device *master;
    struct list_head master_hook;
    struct device *slave;
    struct list_head slave_hook;
};

Add some locking, helpers for adding / removing "dependency objects" etc.
and it should work.  Instead of checking the parent, walk the list of
"masters", instead of walking the list of children, walk the list of "slaves".

The core could create those objects for parent-child relationships
automatically, the other ones would have to be added by platforms / bus types /
drivers etc.

This approach has a problem that it's prone to adding circular dependencies by
mistake, but then I think it would apply to any other approach just as well.

Best,
Rafael
