From: Yi Yang <yi.y.yang@intel.com>
Subject: Re: [PATCH] base: Change power/wakeup output from "" to
	"unsupported" if wakeup feature isn't supported by a device
Date: Mon, 07 Jan 2008 09:51:32 +0800
Message-ID: <1199670692.3551.5.camel__4334.06745219163$1199671073$gmane$org@yangyi-dev.bj.intel.com>
References: <1199441414.19185.9.camel@yangyi-dev.bj.intel.com>
	<20080104163101.EDC02115203@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
Reply-To: yi.y.yang@intel.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080104163101.EDC02115203@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Fri, 2008-01-04 at 08:31 -0800, David Brownell wrote:
> > This patch changes empty output to "unsupported" in order that a user knows
> > wakeup feature isn't supported by this device when he/she
> > 'cat /sys/devices/.../power/wakeup', please consider to apply, thanks.
> 
> I don't much like this patch.  Not just for the technical reasons
> mentioned in my previous note ... but also because it doesn't update
> the documention at the top, which clearly states that "\n" is
> returned for "temporary or permanent inability to issue wakeup".
> And then it gives the example I gave before ...
> 
> Though I suppose a patch that changes the *entire* userspace interface,
> (which includes its documentation, and all out-of-tree users) would have
> shown more clearly why it wasn't a good idea.  ;)
Really, "\n" should be changed to show that change.
Anyway, "\n" isn't a good indicator for that state. :-)
> 
> 
> > --- a/drivers/base/power/sysfs.c	2008-01-04 16:50:54.000000000 +0800
> > +++ b/drivers/base/power/sysfs.c	2008-01-04 17:14:42.000000000 +0800
> > @@ -49,7 +49,7 @@ wake_show(struct device * dev, struct de
> >  {
> >  	return sprintf(buf, "%s\n", device_can_wakeup(dev)
> >  		? (device_may_wakeup(dev) ? enabled : disabled)
> > -		: "");
> > +		: "unsupported");
> >  }
> >  
> >  static ssize_t
> >
> >
