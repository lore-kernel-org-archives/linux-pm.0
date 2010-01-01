From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PCI / PM: Use per-device D3 delays
Date: Fri, 1 Jan 2010 19:55:27 +0100
Message-ID: <201001011955.27407.rjw__16935.1670578637$1262372171$gmane$org@sisk.pl>
References: <20100101170729.GA22252@rhlx01.hs-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100101170729.GA22252@rhlx01.hs-esslingen.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andreas Mohr <andi@lisas.de>
Cc: Linux PCI <linux-pci@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, pm list <linux-pm@lists.linux-foundation.org>, Stephen Hemminger <shemminger@linux-foundation.org>, "Maciej J. Woloszyk" <mat@esi.com.pl>
List-Id: linux-pm@vger.kernel.org

On Friday 01 January 2010, Andreas Mohr wrote:
> Hi,
> 
> While the bug report mentions "So it's just quirky hardware.",
> the implementation of your patch makes it seem like this delay attribute is
> totally "norm"al behaviour - I'm missing some more aggressive wording.

That's because it works both ways (please look at the changelog).

I know of a few devices that don't need the PCI-prescribed 10 ms wait when
going from D3 to D0 and their drivers may use the d3_delay field to actually
set a _shorter_ delay.

> Perhaps rename d3_delay to d3_delay__quirk or add something to the
> comment, like "D3->D0 transition time in ms (out-of-spec PCI device quirk)"?
> Or maybe something like
> "custom D3->D0 transition time in ms (for quirky hardware violating the PCI spec's <= 100ms)".
> 
> Thanks for your ongoing great PCI efforts,

You're welcome.

Rafael
