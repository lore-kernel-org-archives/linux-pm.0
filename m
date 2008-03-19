From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC][PATCH 1/3] PM: Introduce new top level suspend
 and hibernation callbacks
Date: Tue, 18 Mar 2008 22:44:44 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0803182233370.10154-100000@netrider.rowland.org>
References: <200803190204.07592.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200803190204.07592.rjw@sisk.pl>
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
Cc: LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Alexey Starikovskiy <astarikovskiy@suse.de>
List-Id: linux-pm@vger.kernel.org

On Wed, 19 Mar 2008, Rafael J. Wysocki wrote:

> In the meantime I had an IRC chat with Ben, who wanted a couple of quite
> substantial changes to be made to this patch.
> 
> First, Ben thinks that ->prepare() should be called in a separate loop for
> all devices, before any of them is suspended, so that drivers can assume the
> availability of the other devices during ->prepare() (for example, so that they
> can use GFP_KERNEL memory allocations).  Accordingly, ->complete() would
> be called in a separate loop after calling ->resume() for all devices.

In order to make this work, you would have to prevent new children from
being registered starting from the time just after prepare() returns,
rather than from the time just before suspend() is called.  Nothing is
wrong with that, but it requires a redesign of the new flags.  (It's 
worth mentioning that drivers will want to have a flag that gets set 
just _before_ prepare() -- just _after_ is too late.)

In the other direction, it ought to be okay to allow new children to 
be registered during resume().  There's no need to wait for complete().

> Next, he wants the number of noirq callbacks to be reduced.

I agree.  For example, there isn't much point in having prepare() and
complete() entries for noirq.

> Both of the above things make sense, so I'll rework the patch (or maybe even
> all three patches) to implement them and we'll see how they will look like.

Alan Stern
