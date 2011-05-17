From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH v2 3/3] PM / DEVFREQ: add sysfs interface
 (including user tickling)
Date: Tue, 17 May 2011 11:32:59 -0700
Message-ID: <20110517183259.GB21217__46463.1901974373$1305657332$gmane$org@suse.de>
References: <1305100723-29161-1-git-send-email-myungjoo.ham@samsung.com>
	<1305100723-29161-3-git-send-email-myungjoo.ham@samsung.com>
	<20110511225540.GA3492@suse.de>
	<BANLkTik__9G-DuSsT_kAc69d+5g8xcVyFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
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
Cc: Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>, linux-pm@lists.linux-foundation.org, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org

On Tue, May 17, 2011 at 02:04:52PM +0900, MyungJoo Ham wrote:
> On Thu, May 12, 2011 at 7:55 AM, Greg KH <gregkh@suse.de> wrote:
> > On Wed, May 11, 2011 at 04:58:43PM +0900, MyungJoo Ham wrote:
> >> 1. System-wide sysfs interface
> >> - tickle_all =A0R: number of tickle_all execution
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 W: tickle all devfreq devices
> >> - min_interval =A0 =A0 =A0 =A0R: devfreq monitoring base interval in ms
> >> - monitoring =A0R: shows whether devfreq monitoring is active or
> >> =A0 not.
> >>
> >> 2. Device specific sysfs interface
> >> - tickle =A0 =A0 =A0R: number of tickle execution for the device
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 W: tickle the device
> >
> > Any sysfs file change/addition/removal needs to have a
> > Documentation/ABI/ entry as well. =A0Please add that to this patch inst=
ead
> > of burying it in the changelog entry, where no one will be able to find
> > it in the future.
> >
> > thanks,
> >
> > greg k-h
> >
> =

> Sure, I'll add Documentation/ABI/testing/* entries.
> =

> However, would it be appropriate for "1. System-wide sysfs interface"
> to be in "sysfs-class-power" and for "2. Device specific sysfs
> interface" to be in "sysfs-devices-devfreq"?
> =

> System-wide sysfs interface is in /sys/class/power/devfreq/* and
> Device specific sysfs interface is in /sys/...DEVICE.../devfreq/* .

That makes sense.

thanks,

greg k-h
