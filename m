From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/3] PM: Introduce new top level suspend and
	hibernation callbacks (rev. 8)
Date: Sun, 13 Apr 2008 23:39:43 +0200
Message-ID: <200804132339.45280.rjw__25241.7818447158$1208122965$gmane$org@sisk.pl>
References: <200804040111.15255.rjw@sisk.pl> <200804131533.03150.rjw@sisk.pl>
	<1208120711.6958.52.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1208120711.6958.52.camel@pasglop>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: benh@kernel.crashing.org
Cc: Nigel Cunningham <ncunningham@crca.org.au>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Alexey Starikovskiy <astarikovskiy@suse.de>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sunday, 13 of April 2008, Benjamin Herrenschmidt wrote:
> 
> On Sun, 2008-04-13 at 15:33 +0200, Rafael J. Wysocki wrote:
> > + *     The PM core executes @prepare() for all devices before starting to
> > + *     execute suspend callbacks for any of them, so drivers may assume all of
> > + *     the other devices to be present and functional while @prepare() is being
> > + *     executed.  In particular, it is safe to make GFP_KERNEL memory
> > + *     allocations from within @prepare().  However, drivers may NOT assume
> > + *     anything about the availability of the user space at that time and it
> > + *     is not correct to request firmware from within @prepare() (it's too
> > + *     late to do that).  [To work around this limitation, drivers may
> > + *     register suspend and hibernation notifiers that are executed before the
> > + *     freezing of tasks.]
> 
> Can you tell me why you kept that limitation with user space ?
> 
> I don't see the point... On the contrary, prepare() is the pefect place
> to implement handshaking with userspace for drivers that need to do so,
> such as the DRM.

This _comment_ reflects the current situation, which is that we freeze tasks
before a suspend.  When it's no longer necessary to do that, I'll be happy to
change this comment.  For now, however, that's not the case.

Thanks,
Rafael
