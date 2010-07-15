From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Warnings from PM QoS plist usage
Date: Thu, 15 Jul 2010 18:58:46 +0200
Message-ID: <201007151858.47087.rjw@sisk.pl>
References: <20100714093510.GC5933@sirena.org.uk>
	<1279174378.21982.52.camel@mulgrave.site>
	<20100715162811.GA17100@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100715162811.GA17100@rakim.wolfsonmicro.main>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, James Bottomley <James.Bottomley@suse.de>
Cc: linux-pm@lists.linux-foundation.org, mark gross <markgross@thegnar.org>
List-Id: linux-pm@vger.kernel.org

On Thursday, July 15, 2010, Mark Brown wrote:
> On Thu, Jul 15, 2010 at 08:12:58AM +0200, James Bottomley wrote:
> > On Wed, 2010-07-14 at 10:35 +0100, Mark Brown wrote:
> 
> > > > I've not looked at the PM QoS code at all so I don't know what the
> > > > appropriate place to fix this is - do we perhaps want to fix the debug
> > > > code to cope with no locks?  Looking at the plist.h code it seems fairly
> > > > clear that there's currently no expectation that users should use
> > > > _PLIST_INIT_HEAD() directly.
> 
> > Sorry ... I just wasn't sure what it wanted without reading through the
> > plist code more ... and also that debug item is hidden by
> > CONFIG_DEBUG_RT_MUTEXES, which is why I couldn't enable it.
> 
> Ah, yes - I missed the existing spinlock.
> 
> > This should fix the warning.
> 
> It does indeed - thanks!
> 
> Tested-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Thanks for testing.

James, I hope it's appropriate to add your sign-off to the patch?

Rafael
