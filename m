From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/3] PM: Introduce new top level suspend
	and	hibernation callbacks (rev. 8)
Date: Mon, 14 Apr 2008 07:05:11 +1000
Message-ID: <1208120711.6958.52.camel@pasglop>
References: <200804040111.15255.rjw@sisk.pl>
	<20080412002302.GA27656@kroah.com> <200804131531.11650.rjw@sisk.pl>
	<200804131533.03150.rjw@sisk.pl>
Reply-To: benh@kernel.crashing.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200804131533.03150.rjw@sisk.pl>
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
Cc: Nigel Cunningham <ncunningham@crca.org.au>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Alexey Starikovskiy <astarikovskiy@suse.de>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org


On Sun, 2008-04-13 at 15:33 +0200, Rafael J. Wysocki wrote:
> + *     The PM core executes @prepare() for all devices before starting to
> + *     execute suspend callbacks for any of them, so drivers may assume all of
> + *     the other devices to be present and functional while @prepare() is being
> + *     executed.  In particular, it is safe to make GFP_KERNEL memory
> + *     allocations from within @prepare().  However, drivers may NOT assume
> + *     anything about the availability of the user space at that time and it
> + *     is not correct to request firmware from within @prepare() (it's too
> + *     late to do that).  [To work around this limitation, drivers may
> + *     register suspend and hibernation notifiers that are executed before the
> + *     freezing of tasks.]

Can you tell me why you kept that limitation with user space ?

I don't see the point... On the contrary, prepare() is the pefect place
to implement handshaking with userspace for drivers that need to do so,
such as the DRM.

Ben.
