From: Shaohua Li <shaohua.li@intel.com>
Subject: Re: [RFC] dynamic device power management proposal
Date: Wed, 21 Mar 2007 09:34:48 +0800
Message-ID: <1174440888.29722.15.camel@sli10-conroe.sh.intel.com>
References: <1174295302.31250.1.camel@sli10-conroe.sh.intel.com>
	<20070320183022.GC2670@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070320183022.GC2670@elf.ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-pm <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 2007-03-21 at 02:30 +0800, Pavel Machek wrote:
> Hi!
> =

> > Runtime device power management or dynamic device power management
> > (dpm).
> >
> > Why dpm:
> >      1. put an idle device into low power state to save power
> >      2. speed up S3/S4. In resume time, we could resume devices only
> as
> >         the devices are used. In suspend time, we could skip
> suspended
> >         devices. (suspend/resume a device equals to change device
> state)
> >
> > Basically we need device driver support, a kernel framework and a
> policy
> > (determine when to change a device???s power state).
> =

> So far so good, but please use ascii ' for '.
> =

> > I think we need answer below questions:
> > 1. How to present device???s power info/control interface to policy.
> ...
> =

> Depends on bus, I'm afraid. We do not want to do this in generic code.
Agree it depends on bus. But it's better a framework can abstract the
interface

> > 2. How to handle devices dependences. For example, for a PCI
> endpoint
> ...
> =

> USB gets the dependencies right, just copy that.
Does USB include all kinds of dependence, eg non parent-children
dependence?

> > 3. How to detect if a device is idle.
> =

> USB gets this right. It is driver specific, but core can provide some
> helpers.
Sure, this doesn't conflict with my idea.

> > int foo() //all service routines of the driver should do
> > {
> >             //wakeup the device if it???s suspended
> >             dpm_active_device();
> =

> No, we do not want this kind of interface. It should be something like
> mod_timer(my_timer, HZ+10);
1. the device might suspend already here, we should resume it.
2. mod_timer is a bad idea. It's too heavy, if the routine is called
very frequently, mod_timer will be a big overload. That's why I use a
timestamp. Updating a timestamp hasn't any overload.

> We can talk about generic device attribute "powerdown_timeout" in
> sysfs... but I'd prefer few more drivers that do powersave before we
> do that.
Using this you will have a timer in the driver, and the timer's callback
will suspend the device. This approach has some issues. 1. it's better
driver doesn't handle device dependence. This approach requires driver
handle dependence. 2. It's better a userspace policy to directly suspend
a device and driver just provides control interface. A userspace is
definitely flexible and make driver simpler.

> > We consider two type devices:
> > 1. for soundcard, policy does:
> > a. Setup a timer, the timer polls soundcard???s busy_timestamp sysfs
> file.
> > b. if the timer found soundcard is idle for a long time, write the
> > device???s state sysfs file, and sound card to low power state.
> > c. policy does nothing to resume soundcard. Soundcard driver???s
> service
> > routine will call ???dpm_active_device??? to resume the device
> =

> No, that's not how it works; look at hda_audio, it already has
> powersave. Just power down audio card 5 seconds after its control file
> is closed.
It's another case of doing policy in a driver.

Thanks,
Shaohua
