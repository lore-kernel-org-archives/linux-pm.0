From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC][PATCH] PM: Introduce new top level suspend
	and	hibernation callbacks (rev. 6)
Date: Tue, 01 Apr 2008 19:27:40 +1100
Message-ID: <1207038460.10388.214.camel@pasglop>
References: <200803292317.50218.rjw@sisk.pl>
	<200803292320.38378.rjw@sisk.pl> <200803300454.26318.rjw@sisk.pl>
	<200803312329.03455.rjw@sisk.pl>
	<1207037741.23143.81.camel@nigel-laptop>
Reply-To: benh@kernel.crashing.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1207037741.23143.81.camel@nigel-laptop>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Nigel Cunningham <ncunningham@crca.org.au>
Cc: LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Alexey Starikovskiy <astarikovskiy@suse.de>
List-Id: linux-pm@vger.kernel.org


On Tue, 2008-04-01 at 19:15 +1100, Nigel Cunningham wrote:
> > + *   However, drivers may NOT assume anything about the availability of the
> > + *   user space at that time and it is not correct to request firmware from
> > + *   within @prepare() (it's too late to do that).
> 
> That doesn't sound good. It would be good to be able to get drivers to
> request firmware early in the process.

Agreed. Prepare() should still allow request_firmware and full userspace
communication / helper usage.

> > + * @complete: Undo the changes made by @prepare().  This method is executed for
> > + *   all kinds of resume transitions, following one of the resume callbacks:
> > + *   @resume(), @thaw(), @restore().  Also called if the state transition
> > + *   fails before the driver's suspend callback (@suspend(), @freeze(),
> > + *   @poweroff()) can be executed (e.g. if the suspend callback fails for one
> > + *   of the other devices that the PM core has unsucessfully attempted to

Ben.
