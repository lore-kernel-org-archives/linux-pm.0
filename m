From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] PM: Hide CONFIG_PM from users
Date: Tue, 8 Feb 2011 12:12:55 +0000
Message-ID: <20110208121254.GE29850__16332.9081995927$1297169255$gmane$org@opensource.wolfsonmicro.com>
References: <1297081335-13631-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<201102072046.48763.rjw@sisk.pl>
	<20110207201803.GU10564@opensource.wolfsonmicro.com>
	<201102072215.59921.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201102072215.59921.rjw@sisk.pl>
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
Cc: Len Brown <len.brown@intel.com>, linux-embedded@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Feb 07, 2011 at 10:15:59PM +0100, Rafael J. Wysocki wrote:

> I really think we should do things that makes sense rather that worry about
> who's going to like or dislike it (except for Linus maybe, but he tends to like
> things that make sense anyway).  At this point I think the change I suggested
> makes sense, because it (a) simplifies things and (b) follows the quite common
> practice which is to make PM callbacks depend on CONFIG_PM.

So, part of the issue here is that it's not clear if having the ifdefs
in the drivers is really something that makes sense.  It's not at all
clear that anyone is actually making active use of them on real systems
rather than just doing build coverage testing, it really feels like the
ifdefs that people are currently using are just being cargo culted
around.

The reason it's come up for me is that dev_pm_ops changes things a bit
as you've got to decide how to handle the struct itself and there's no
clear decision on what the best way forward for that is (is it OK to
leave the struct if it's empty?) so you end up with the approach you
need to take varying between maintainers which is annoying.

> I'd appreciate it if people could review/test it and drop their comments.

Looks good to me:

Reviewed/Tested-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
