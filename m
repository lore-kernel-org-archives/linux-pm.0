From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] i2c: Use generic subsystem-level power
 management callbacks
Date: Sat, 13 Mar 2010 16:34:29 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1003131627270.19476-100000__2934.68925306133$1268516147$gmane$org@netrider.rowland.org>
References: <201003132204.30905.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201003132204.30905.rjw@sisk.pl>
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
Cc: Jean Delvare <khali@linux-fr.org>, pm list <linux-pm@lists.linux-foundation.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Linux I2C <linux-i2c@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sat, 13 Mar 2010, Rafael J. Wysocki wrote:

> Please note that the "legacy" callbacks removed by this patch are already
> effectively dead, because they are not going to be called by the PM core
> anyway.  I'm not sure if this is what we want, though, so please let me know
> in case it's not.

You know, maybe we should allow bus types to use both the old and new
interfaces.  It would make life easier for other subsystems in addition
to i2c.

This doesn't mean that the core would end up calling two sets of
suspend routines.  If the bus type uses legacy routines then all the
non-runtime entries in the pm_ops structure would be empty.

The changes to the PM core necessary to do this are quite small.  Does 
it seem like a reasonable thing to do?

Alan Stern
