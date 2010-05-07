From: Jean Delvare <khali@linux-fr.org>
Subject: Re: platform_bus: Allow runtime PM by default
Date: Fri, 7 May 2010 16:20:28 +0200
Message-ID: <20100507162028.022a737c__19413.0052849234$1273242107$gmane$org@hyperion.delvare>
References: <1269625370-17754-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<201004231840.20041.rjw@sisk.pl> <201004232026.37114.rjw@sisk.pl>
	<201004232041.42064.rjw@sisk.pl>
	<20100507132746.GA3425@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100507132746.GA3425@sirena.org.uk>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-pm@lists.linux-foundation.org, Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Mark,

On Fri, 7 May 2010 14:27:46 +0100, Mark Brown wrote:
> On Fri, Apr 23, 2010 at 08:41:41PM +0200, Rafael J. Wysocki wrote:
> 
> > Jean, the patch we're discussing depends on the
> > "i2c: Fix bus-level power management callbacks" patch that's in your tree right
> > now.  Would it be possible to move the i2c patch to my tree, or alternatively
> > would it be acceptable for you to merge a core PM patch through your tree?
> 
> Jean, any updates on this?

I'm sorry, I never received Rafael's initial message. I just checked
through my mailbox and it isn't there.

The current status is that patch "i2c: Fix bus-level power management
callbacks" is currently queued in my i2c tree at:
ftp://ftp.kernel.org/pub/linux/kernel/people/jdelvare/linux-2.6/jdelvare-i2c/i2c-fix-bus-level-power-management-callbacks.patch
and is scheduled to be merged in 2.6.35-rc1. If this isn't OK, we can
change the plan.

Merging a core PM patch through the i2c tree would be quite confusing,
I think, and might draw even more odd dependencies. So I'd rather have
the i2c patch moved to the PM staging tree (or whatever tree the
dependent patch lives in.) Just let me know and I'll drop my copy.

-- 
Jean Delvare
