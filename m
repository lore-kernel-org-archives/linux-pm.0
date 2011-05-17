From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH v2 3/3] PM / DEVFREQ: add sysfs interface
	(including user tickling)
Date: Wed, 18 May 2011 00:41:57 +0200
Message-ID: <201105180041.57723.rjw__25527.7641852901$1305672211$gmane$org@sisk.pl>
References: <1305100723-29161-1-git-send-email-myungjoo.ham@samsung.com>
	<20110511225540.GA3492@suse.de>
	<BANLkTik__9G-DuSsT_kAc69d+5g8xcVyFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <BANLkTik__9G-DuSsT_kAc69d+5g8xcVyFg@mail.gmail.com>
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
Cc: Len Brown <len.brown@intel.com>, Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>, linux-pm@lists.linux-foundation.org, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org

On Tuesday, May 17, 2011, MyungJoo Ham wrote:
> On Thu, May 12, 2011 at 7:55 AM, Greg KH <gregkh@suse.de> wrote:
> > On Wed, May 11, 2011 at 04:58:43PM +0900, MyungJoo Ham wrote:
> >> 1. System-wide sysfs interface
> >> - tickle_all  R: number of tickle_all execution
> >>               W: tickle all devfreq devices
> >> - min_interval        R: devfreq monitoring base interval in ms
> >> - monitoring  R: shows whether devfreq monitoring is active or
> >>   not.
> >>
> >> 2. Device specific sysfs interface
> >> - tickle      R: number of tickle execution for the device
> >>               W: tickle the device
> >
> > Any sysfs file change/addition/removal needs to have a
> > Documentation/ABI/ entry as well.  Please add that to this patch instead
> > of burying it in the changelog entry, where no one will be able to find
> > it in the future.
> >
> > thanks,
> >
> > greg k-h
> >
> 
> Sure, I'll add Documentation/ABI/testing/* entries.
> 
> However, would it be appropriate for "1. System-wide sysfs interface"
> to be in "sysfs-class-power" and for "2. Device specific sysfs
> interface" to be in "sysfs-devices-devfreq"?
> 
> System-wide sysfs interface is in /sys/class/power/devfreq/* and

Hmm.  Why not to use /sys/power/ that's already there?

> Device specific sysfs interface is in /sys/...DEVICE.../devfreq/* .

Thanks,
Rafael
