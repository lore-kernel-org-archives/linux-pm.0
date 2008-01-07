From: Yi Yang <yi.y.yang@intel.com>
Subject: Re: [PATCH] base: Change power/wakeup output from "" to
	"unsupported" if wakeup feature isn't supported by a device
Date: Mon, 07 Jan 2008 10:05:45 +0800
Message-ID: <1199671545.3551.16.camel__27052.8803150684$1199672571$gmane$org@yangyi-dev.bj.intel.com>
References: <1199441414.19185.9.camel@yangyi-dev.bj.intel.com>
	<20080104160933.B01D81FBAB5@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
	<1199669879.19185.20.camel@yangyi-dev.bj.intel.com>
	<200801070257.58884.rjw@sisk.pl>
Reply-To: yi.y.yang@intel.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200801070257.58884.rjw@sisk.pl>
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
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon, 2008-01-07 at 02:57 +0100, Rafael J. Wysocki wrote:
> On Monday, 7 of January 2008, Yi Yang wrote:
> > On Fri, 2008-01-04 at 08:09 -0800, David Brownell wrote:
> > > > > This patch changes empty output to "unsupported" in order that a user knows
> > > > > wakeup feature isn't supported by this device when he/she
> > > > > 'cat /sys/devices/.../power/wakeup', please consider to apply,
> > > > > thanks.
> > > >
> > > > What about simply removing "wakuep" file if wakeup is not supported?
> > > 
> > > It may not *stay* unsupported, so I think changing it in either
> > > of those permanent ways would be confusing/misleading.
> > > 
> > > For example, USB devices have multiple states ... minimally, an
> > > unconfigured state, and a configured state.  Some have multiple
> > > configurations.  Only configured states can be wakeup-capable.
> > > So a given device might have three states, but support wakeup
> > > except in one of them...
> > If so, we can change "unsupported" to "unconfigurable" or "inoperable"
> > which can cover the states "unconfigured", "unsupported" and other
> > unknown states. :-).
> 
> The main problem with your patch is that is changes a documented behavior
> visible by the user space.  That should be done very cautiously.
Which applications are using this interface? if they assume "\n" means
the unconfigurable or unavailable state, this is very fragile.
> 
> Thanks,
> Rafael
