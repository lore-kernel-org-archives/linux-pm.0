From: Jean Delvare <khali@linux-fr.org>
Subject: Re: platform_bus: Allow runtime PM by default
Date: Tue, 11 May 2010 08:19:00 +0200
Message-ID: <20100511081900.0e7a1956__38920.2834609479$1273558824$gmane$org@hyperion.delvare>
References: <1269625370-17754-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<20100507132746.GA3425@sirena.org.uk>
	<20100507162028.022a737c@hyperion.delvare>
	<201005102310.55838.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201005102310.55838.rjw@sisk.pl>
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
Cc: linux-pm@lists.linux-foundation.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon, 10 May 2010 23:10:55 +0200, Rafael J. Wysocki wrote:
> On Friday 07 May 2010, Jean Delvare wrote:
> > I'm sorry, I never received Rafael's initial message. I just checked
> > through my mailbox and it isn't there.
> > 
> > The current status is that patch "i2c: Fix bus-level power management
> > callbacks" is currently queued in my i2c tree at:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/jdelvare/linux-2.6/jdelvare-i2c/i2c-fix-bus-level-power-management-callbacks.patch
> > and is scheduled to be merged in 2.6.35-rc1. If this isn't OK, we can
> > change the plan.
> > 
> > Merging a core PM patch through the i2c tree would be quite confusing,
> > I think, and might draw even more odd dependencies. So I'd rather have
> > the i2c patch moved to the PM staging tree (or whatever tree the
> > dependent patch lives in.) Just let me know and I'll drop my copy.
> 
> The patch above has been applied to suspend-2.6/linux-next along with the
> Mark's $subject patch.

OK, I've dropped it from my i2c tree.

> I have converted your sign-off into an ack, hope that's fine.

Perfectly fine, yes, thanks.

-- 
Jean Delvare
