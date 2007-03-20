From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC] dynamic device power management proposal
Date: Tue, 20 Mar 2007 19:30:22 +0100
Message-ID: <20070320183022.GC2670@elf.ucw.cz>
References: <1174295302.31250.1.camel@sli10-conroe.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1174295302.31250.1.camel@sli10-conroe.sh.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: linux-pm <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> Runtime device power management or dynamic device power management
> (dpm).
> =

> Why dpm: =

>      1. put an idle device into low power state to save power =

>      2. speed up S3/S4. In resume time, we could resume devices only as
>         the devices are used. In suspend time, we could skip suspended
>         devices. (suspend/resume a device equals to change device state)
> =

> Basically we need device driver support, a kernel framework and a policy
> (determine when to change a device???s power state).

So far so good, but please use ascii ' for '.

> I think we need answer below questions:
> 1. How to present device???s power info/control interface to policy.
...

Depends on bus, I'm afraid. We do not want to do this in generic code.

> 2. How to handle devices dependences. For example, for a PCI endpoint
...

USB gets the dependencies right, just copy that.

> 3. How to detect if a device is idle.

USB gets this right. It is driver specific, but core can provide some
helpers.

> int foo() //all service routines of the driver should do
> { =

>             //wakeup the device if it???s suspended
>             dpm_active_device();

No, we do not want this kind of interface. It should be something like
mod_timer(my_timer, HZ+10);

We can talk about generic device attribute "powerdown_timeout" in
sysfs... but I'd prefer few more drivers that do powersave before we
do that.

> We consider two type devices:
> 1. for soundcard, policy does:
> a. Setup a timer, the timer polls soundcard???s busy_timestamp sysfs file.
> b. if the timer found soundcard is idle for a long time, write the
> device???s state sysfs file, and sound card to low power state.
> c. policy does nothing to resume soundcard. Soundcard driver???s service
> routine will call ???dpm_active_device??? to resume the device

No, that's not how it works; look at hda_audio, it already has
powersave. Just power down audio card 5 seconds after its control file
is closed.

> 2. For keyboard or mouse, policy does:
> a. setup a timer, the timer polls keyboard???s busy_timestamp sysfs file.
> b. if the timer found keyboard is idle for a long time, write LCD???s
> state sysfs file to close LCD.
> c. After LCD is closed, policy polls keyboard???s busy_timestamp sysfs
> file.
> d. if the content changed of the file (maybe using inotify), policy will
> open LCD

This already works for usb keyboard/mice.

> This is my preliminary design, and I???d like to listen to your opinions.

"Seriously overdesigned".
									Pavel


-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
