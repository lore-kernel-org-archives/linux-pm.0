From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC][PATCH 1/3] PM: Introduce new top level suspend
	and	hibernation callbacks (rev. 4)
Date: Thu, 27 Mar 2008 11:06:43 +1100
Message-ID: <1206576403.6926.62.camel@pasglop>
References: <200803262353.30566.rjw@sisk.pl> <47EADBD0.6040400@suse.de>
	<1206574982.6926.53.camel@pasglop>  <200803270054.58546.rjw@sisk.pl>
Reply-To: benh@kernel.crashing.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200803270054.58546.rjw@sisk.pl>
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


> > There is absolutely no point getting a second struct anymore.
> 
> I obviously disagree with that opinion, so please elaborate.

Well, what does it bring you ? Why can't it be one struct ? To save
space in the data area ? I don't think it makes things much cleaner. But
I won't fight a war for it, now that they are clearly named differently
and things like prepare/complete are no longer in "noirq", it's
semantically the same thing as having the fields in one structure, so
it's mostly cosmetic.

Ben.
