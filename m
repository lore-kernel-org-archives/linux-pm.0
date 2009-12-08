From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Async resume patch (was: Re: [GIT PULL] PM updates
	for 2.6.33)
Date: Tue, 8 Dec 2009 15:16:44 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0912081508220.3046-100000__27343.32889454$1260303559$gmane$org@iolanthe.rowland.org>
References: <200912082044.52098.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200912082044.52098.rjw@sisk.pl>
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
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 8 Dec 2009, Rafael J. Wysocki wrote:

> Suppose we use rwsem and during suspend each child uses a down_read() on a
> parent and then the parent uses down_write() on itself.  What if, whatever the
> reason, the parent is a bit early and does the down_write() before one of the
> children has a chance to do the down_read()?  Aren't we toast?
> 
> Do we need any direct protection against that or does it just work itself out
> in a way I just don't see right now?

That's not the way it should be done.  Linus had children taking their
parents' locks during suspend, which is simple but leads to
difficulties.

Instead, the PM core should do a down_write() on each device before
starting the device's async suspend routine, and an up_write() when the
routine finishes.  Parents should, at the start of their async routine,
do down_read() on each of their children plus whatever other devices
they need to wait for.  The core can do the waiting for children part 
and the driver's suspend routine can handle any other waiting.

This is a little more awkward because it requires the parent to iterate 
through its children.  But it does solve the off-tree dependency 
problem for suspends.

Alan Stern
