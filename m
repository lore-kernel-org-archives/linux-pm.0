From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: LCDC problem after commit
	794d78fea51504bad3880d14f354a9847f318f25
Date: Mon, 8 Aug 2011 01:25:34 +0200
Message-ID: <201108080125.34329.rjw__2861.4689749249$1312760858$gmane$org@sisk.pl>
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
To: Magnus Damm <magnus.damm@gmail.com>
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-sh@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi,

Unfortunately, after commit 794d78fea51504bad3880d14f354a9847f318f25
(drivers: sh: late disabling of clocks V2) the LCDC screen on my
Mackerel board goes off (late) during boot and cannot be turned on
by any way AFAICS (the backlight remains on, though).

It looks like the late disabling of clocks interacts badly with the
clock management done by PM domains.

Thanks,
Rafael
