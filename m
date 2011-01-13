From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] i2c: Factor out runtime suspend checks from
	PM operations
Date: Thu, 13 Jan 2011 21:28:57 +0100
Message-ID: <201101132128.57839.rjw__44999.4080969647$1294950712$gmane$org@sisk.pl>
References: <1293712813-4090-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<201101050928.53979.rjw@sisk.pl>
	<20110113211751.62e878d8@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110113211751.62e878d8@endymion.delvare>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jean Delvare <khali@linux-fr.org>
Cc: Abhijeet Dharmapurikar <adharmap@codeaurora.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thursday, January 13, 2011, Jean Delvare wrote:
> Hi Rafael,
> 
> On Wed, 5 Jan 2011 09:28:53 +0100, Rafael J. Wysocki wrote:
> > On Wednesday, January 05, 2011, Mark Brown wrote:
> > > On Tue, Jan 04, 2011 at 03:07:37PM -0800, Abhijeet Dharmapurikar wrote:
> > > > Mark Brown wrote:
> > > 
> > > >> device op. The PM core provides pm_generic_ functions implementing this
> > > >> behaviour - use them to reduce coupling with future PM updates.
> > > 
> > > > pm_generic_suspend() and others needs to be externed in linux/pm_runtime.h?
> > > 
> > > Yes, there's a patch in -next for this already so this patch would need
> > > to either wait for later in the merge window or go in via the PM tree
> > > with the preceeding one (the original version of this patch was posted
> > > as part of a series with the export patch).
> > 
> > I would take it, but I'm still waiting for a word from Jean.
> 
> Sorry for the long silence, I was on vacation. I've just applied this
> patch, and I will send it to Linus tomorrow.

Great, thanks!

Rafael
