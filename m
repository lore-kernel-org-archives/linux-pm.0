From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC PATCH] PM: Introduce generic DVFS framework
	with device-specific OPPs
Date: Thu, 28 Apr 2011 21:19:05 +0200
Message-ID: <201104282119.05905.rjw@sisk.pl>
References: <1303807401-16350-1-git-send-email-myungjoo.ham@samsung.com>
	<201104271546.12757.rjw@sisk.pl>
	<BANLkTi==5zpS4=5zstYBC3rNX4-j2-3zDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <BANLkTi==5zpS4=5zstYBC3rNX4-j2-3zDA@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: myungjoo.ham@gmail.com
Cc: Nishanth Menon <nm@ti.com>, Len Brown <len.brown@intel.com>, Kevin Hilman <khilman@deeprootsystems.com>, Greg Kroah-Hartman <gregkh@suse.de>, Kyungmin Park <kyungmin.park@samsung.com>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thursday, April 28, 2011, MyungJoo Ham wrote:
> On Wed, Apr 27, 2011 at 10:46 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > On Wednesday, April 27, 2011, MyungJoo Ham wrote:
> >> Hello,
...
> >> Anyway, this happens with drivers/cpufreq also. We have been testing
> >> "tickling" associated with drivers/cpufreq/cpufreq.c. This has been
> >> reduced user response time significantly removing the need for tuning
> >> the threshold values.
> >
> > I think I understand the problem, but I'm not sure if there's a clean way
> > to trigger the "tickle" from the kernel level.
> 
> I'm considering the followings (and they are not mutually exclusive).
> How about them?
> 1. (the way that we've been using) Add a tickle call to input events
> at board file.

Well, first, the input events may not be the only user of that feature and
the GPU may not be the only target.  So, there should be a way to specify
multiple targets for each user and vice versa while keeping the drivers
portable between platforms.  That seems to be challenging. :-)

Second, even if the input events were the only user and the GPU were the only
possible target, it probably won't be necessary to "tickle" the GPU every
time the touchscreen is used, only when the user is "scrolling", which input
events really can't tell.  The only entity having an idea about what the
_user_ is doing is the application being used at the moment.

> 2. provide sysfs interface that triggers tickling along with devfreq sysfs.

That may be a better approach IMO, but making applications use it also will
be challenging.

Thanks,
Rafael
