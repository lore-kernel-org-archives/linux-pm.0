From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] PM / Runtime: Correct documentation of
	pm_runtime_irq_safe()
Date: Wed, 24 Aug 2011 16:45:41 -0700
Message-ID: <87wre25q6y.fsf__44666.9624340304$1314229794$gmane$org@ti.com>
References: <201108242246.41574.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201108242246.41574.rjw@sisk.pl> (Rafael J. Wysocki's message of
	"Wed, 24 Aug 2011 22:46:41 +0200")
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
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

"Rafael J. Wysocki" <rjw@sisk.pl> writes:

> From: Rafael J. Wysocki <rjw@sisk.pl>
>
> The description of pm_runtime_irq_safe() has to be updated to follow
> the code after commit 02b2677 (PM / Runtime: Allow _put_sync() from
> interrupts-disabled context).

oops, missed updating that part of the doc.

> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

Acked-by: Kevin Hilman <khilman@ti.com>
