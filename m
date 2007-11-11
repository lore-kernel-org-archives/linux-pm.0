From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC] powermac: proper sleep management
Date: Mon, 12 Nov 2007 07:59:33 +1100
Message-ID: <1194814773.6510.23.camel@pasglop>
References: <1194523729.6294.18.camel@johannes.berg>
Reply-To: benh@kernel.crashing.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1194523729.6294.18.camel@johannes.berg>
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


> Just thought I'd send out the patch again, it has changed quite a bit
> since last time because I cleaned up the code, made it depend on
> CONFIG_SUSPEND, made the ioctl backward compatibility optional and some
> other bits.
> 
> The feared freezer vs. fuse sync deadlock is no longer present in 2.6.24
> because the sync is done before the freezer so maybe the patch stands a
> chance now.
> 
> Scott: FYI, here's the use case for the ppc_md irq suspend/resume hooks.

Looks good to me, +/- a couple of things:

 - We _REALLY_ want the freezer to be optional and not enabled by
default on PowerPC. Maybe make it a compile option ?

 - Don't remove the pmu_polled_request() debug code. It's very useful
for debugging and I don't want to have to re-invent it.

Plus I also need to test it on some exotic hardware :-)

Cheers,
Ben.
