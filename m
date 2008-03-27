From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH 1/3] PM: Introduce new top level suspend
	and hibernation callbacks (rev. 4)
Date: Thu, 27 Mar 2008 02:23:05 +0100
Message-ID: <200803270223.06715.rjw__49427.2284712226$1206581084$gmane$org@sisk.pl>
References: <200803262353.30566.rjw@sisk.pl> <200803270054.58546.rjw@sisk.pl>
	<1206576403.6926.62.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1206576403.6926.62.camel@pasglop>
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
Cc: LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Alexey Starikovskiy <astarikovskiy@suse.de>
List-Id: linux-pm@vger.kernel.org

On Thursday, 27 of March 2008, Benjamin Herrenschmidt wrote:
> 
> > > There is absolutely no point getting a second struct anymore.
> > 
> > I obviously disagree with that opinion, so please elaborate.
> 
> Well, what does it bring you ? Why can't it be one struct ? To save
> space in the data area ?

Mostly, but not only that.

There are users of 'struct pm_ops' that aren't even supposed to define the
_noirq callbacks (device types and device classes), so I thought it would be
better to introduce a separate _noirq struct after all.

> I don't think it makes things much cleaner. But I won't fight a war for it,
> now that they are clearly named differently and things like prepare/complete
> are no longer in "noirq", it's semantically the same thing as having the
> fields in one structure, so it's mostly cosmetic.

Well, I'm not going to fight for having the two separate stuctures either.
Also, it wouldn't be difficult to rearrange thigs so that all of the callbacks
are in one structure, so if other people think it's better to do it this way,
I'll go for it.

Thanks,
Rafael
