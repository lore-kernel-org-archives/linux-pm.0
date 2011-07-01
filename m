From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] PM / Runtime: Update documentation regarding
	driver removal
Date: Fri, 01 Jul 2011 15:49:45 -0700
Message-ID: <8739ipsjjq.fsf__27855.8333790444$1309560633$gmane$org@ti.com>
References: <Pine.LNX.4.44L0.1107011711370.1624-100000@iolanthe.rowland.org>
	<201107020012.29661.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201107020012.29661.rjw@sisk.pl> (Rafael J. Wysocki's message of
	"Sat, 2 Jul 2011 00:12:29 +0200")
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
Cc: linux-pm@lists.linux-foundation.org, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

"Rafael J. Wysocki" <rjw@sisk.pl> writes:

> From: Rafael J. Wysocki <rjw@sisk.pl>
>
> Commit e1866b33b1e89f077b7132daae3dfd9a594e9a1a (PM / Runtime: Rework
> runtime PM handling during driver removal) forgot to update the
> documentation in Documentation/power/runtime_pm.txt to match the new
> code in drivers/base/dd.c.  Update that documentation to match the
> code it describes.
>
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

Reviewed-by: Kevin Hilman <khilman@ti.com>

Thanks, it's clear now.

Kevin
