From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 4/4] sky2: Adapt sky2 to use reworked PCI PM
Date: Sun, 20 Jul 2008 19:07:42 -0700
Message-ID: <20080720190742.84258d7e.akpm__29358.1758313396$1216606194$gmane$org@linux-foundation.org>
References: <200807191436.40726.rjw@sisk.pl> <200807191442.52759.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200807191442.52759.rjw@sisk.pl>
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
Cc: Jeff Garzik <jeff@garzik.org>, netdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Stephen@smtp1.linux-foundation.org, pm list <linux-pm@lists.linux-foundation.org>, Hemminger <shemminger@vyatta.com>
List-Id: linux-pm@vger.kernel.org

On Sat, 19 Jul 2008 14:42:51 +0200 "Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> Adapt the sky2 driver to use the reworked PCI PM.

I fixed the rejects in "[PATCH 3/4] tg3: Adapt tg3 to use reworked PCI
PM code" but this patch has too many for me to want to fix them.

As usual, please at least take a look at what's in linux-next before
going and bypassing all that queued work.

Patches 3 and 4 (which are Jeff things) depend upon patch 2, which is a
Jesse thing.  So I will attempt to not send patches 3 and 4 (assuming 4
gets fixed) to Jeff until Jesse has sent #2 into mainline.  This should
be interesting.
