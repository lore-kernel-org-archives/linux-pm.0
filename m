From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH 1/3] PM: Introduce new top level suspend
	and hibernation callbacks (rev. 4)
Date: Thu, 27 Mar 2008 00:59:13 +0100
Message-ID: <200803270059.14417.rjw__16307.7611513019$1206576066$gmane$org@sisk.pl>
References: <200803262353.30566.rjw@sisk.pl> <200803270003.51570.rjw@sisk.pl>
	<47EADBD0.6040400@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <47EADBD0.6040400@suse.de>
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
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thursday, 27 of March 2008, Alexey Starikovskiy wrote:
> Rafael J. Wysocki wrote:
> > This is the 4th revision of the patch.
> > + * struct pm_noirq_ops - device PM callbacks executed with interrupts disabled
> > + *
> > + * The following callbacks included in 'struct pm_noirq_ops' are executed with
> > + * the nonboot CPUs switched off and with interrupts disabled on the only
> > + * functional CPU.  They also are executed with the PM core list of devices
> > + * locked, so they must NOT unregister any devices.
> > + *
> > + * @suspend_noirq: Complete the operations of ->suspend() by carrying out any
> > + *	actions required for suspending the device that need interrupts to be
> > + *	disabled
> IMHO, no need to add _noirq in both struct and struct members.
> pm_noirq->suspend_noirq does not look good...

I added the _noirq part to the names of the callbacks, since otherwise the
second struct looks confusingly similar to the first one.

I also could have put the _noirq callbacks into the first struct, but that
would have been wasteful, since device types and device classes don't
use them.  Also, the majority of bus types won't use them and the vast majority
of drivers won't use them as well.

Thanks,
Rafael
