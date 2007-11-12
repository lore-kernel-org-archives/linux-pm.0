From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC] powermac: proper sleep management
Date: Tue, 13 Nov 2007 07:24:01 +1100
Message-ID: <1194899041.18185.55.camel@pasglop>
References: <1194523729.6294.18.camel@johannes.berg>
	<1194814773.6510.23.camel@pasglop>
	<1194885177.5229.45.camel@johannes.berg>
Reply-To: benh@kernel.crashing.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1194885177.5229.45.camel@johannes.berg>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev list <linuxppc-dev@ozlabs.org>, linux-pm <linux-pm@lists.linux-foundation.org>, David Woodhouse <dwmw2@infradead.org>
List-Id: linux-pm@vger.kernel.org


On Mon, 2007-11-12 at 17:32 +0100, Johannes Berg wrote:
> > Looks good to me, +/- a couple of things:
> > 
> >  - We _REALLY_ want the freezer to be optional and not enabled by
> > default on PowerPC. Maybe make it a compile option ?
> 
> Well, Alan is going to tell you that USB will break. If we need
> confirmation for that I can do the test he suggested to you or Paul a
> while ago.

Then USB is broken today on powermacs and need to be fixed. We had a
clear agreement at KS this year that the freezer was at best a band-aid
and that drivers -had- to be fixed to cope regardless.

> Obviously. I don't have any of that. I'd appreciate if somebody could
> test on a 3400 powerbook to see if that pci config space save/restore
> stuff is really necessary or even interferes with the regular stuff.

Might not be that necessary anymore nowadays, the generic code ought to
do it, but I'll give a go, I have one of those (paulus old one) though
last I tried, the HD was dead.

Ben.
