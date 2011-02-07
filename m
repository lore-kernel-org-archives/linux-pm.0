From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PM: Hide CONFIG_PM from users
Date: Mon, 7 Feb 2011 20:46:48 +0100
Message-ID: <201102072046.48763.rjw__21072.4371173002$1297108069$gmane$org@sisk.pl>
References: <1297081335-13631-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<201102072014.04259.rjw@sisk.pl>
	<20110207193026.GT10564@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110207193026.GT10564@opensource.wolfsonmicro.com>
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
Cc: Len Brown <len.brown@intel.com>, linux-embedded@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Monday, February 07, 2011, Mark Brown wrote:
> On Mon, Feb 07, 2011 at 08:14:03PM +0100, Rafael J. Wysocki wrote:
> > On Monday, February 07, 2011, Mark Brown wrote:
> 
> > >  config PM_DEBUG
> > >  	bool "Power Management Debug Support"
> 
> > I think it would be better to simply rename CONFIG_PM_OPS into CONFIG_PM.
> 
> That still leaves the IA64 emulator to worry about

Why exactly?

> but I'm not fundamentally opposed to that, it achieves a similar effect.  The
> main thing I'm looking for here is to cut down on the configuration options
> we have to maintain.

But I must say you chose a particularly bad time for that from my point of view.

> > However, there's a number of things that I'm afraid wouldn't build correctly
> > if none of CONFIG_PM_SLEEP and CONFIG_PM_RUNTIME were set in that case.
> 
> Actually CONFIG_PM_OPS probably also wants to be on independantly of
> those two sometimes for .poweroff() which I'd expect to run even if we
> can't suspend.

If you worry about that, then add CONFIG_PM_POWEROFF and make CONFIG_PM(_OPS)
depend on it, but I don't think it really is worth it, because people
generally don't make the poweroff code depend on CONFIG_PM.

Thanks,
Rafael
