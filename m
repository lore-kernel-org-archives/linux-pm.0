From: Santosh <santosh.shilimkar@ti.com>
Subject: [POWER DOMAIN suspend callbacks] Observation.
Date: Tue, 23 Aug 2011 19:49:40 +0530
Message-ID: <4E53B6FC.8030507__41333.4166551524$1314109267$gmane$org@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Kevin Hilman <khilman@ti.com>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org
Cc: Govindraj R <govindraj.raja@ti.com>
List-Id: linux-pm@vger.kernel.org

Rafael, Kevin,

On latest kernel( V3.1-rc1+), the subsystem(driver) suspend
callbacks are not getting called because power domain callbcaks
are populated.

And as per commit 4d27e9dc{PM: Make power domain callbacks take
precedence over subsystem ones}, it's expected bahavior.

Who is suppose to call the driver suspend callback?
Some drivers/subsystem would have state machine which needs to
be suspended.

Is the power domain suspend callback, suppose to take care of
it ? If yes, then that seems to be missing for OMAP.

Thanks for clarification.

Regards
Santosh
