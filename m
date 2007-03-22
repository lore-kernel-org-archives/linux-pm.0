From: Shaohua Li <shaohua.li@intel.com>
Subject: Re: [RFC] dynamic device power management proposal
Date: Thu, 22 Mar 2007 11:09:39 +0800
Message-ID: <1174532979.2208.3.camel@sli10-conroe.sh.intel.com>
References: <1174295302.31250.1.camel@sli10-conroe.sh.intel.com>
	<20070320183022.GC2670@elf.ucw.cz>
	<1174440888.29722.15.camel@sli10-conroe.sh.intel.com>
	<20070321213909.GB6057@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070321213909.GB6057@elf.ucw.cz>
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

On Thu, 2007-03-22 at 05:39 +0800, Pavel Machek wrote:
> > > > int foo() //all service routines of the driver should do
> > > > {
> > > >             //wakeup the device if it???s suspended
> > > >             dpm_active_device();
> > >
> > > No, we do not want this kind of interface. It should be something
> like
> > > mod_timer(my_timer, HZ+10);
> > 1. the device might suspend already here, we should resume it.
> > 2. mod_timer is a bad idea. It's too heavy, if the routine is called
> > very frequently, mod_timer will be a big overload. That's why I use
> a
> > timestamp. Updating a timestamp hasn't any overload.
> =

> Heh, if mod_timer is bad idea, we'll fix mod_timer. Anyway, if you use
> timestamp, you'll have to add polling, and that means overhead even
> when idle.
No, we don't need poll the timestamp frequently (maybe 1 minute or 5
minute one time depends on your requirement)

> Anyway, we do not have to decide that at this point.
> =

> > > We can talk about generic device attribute "powerdown_timeout" in
> > > sysfs... but I'd prefer few more drivers that do powersave before
> we
> > > do that.
> > Using this you will have a timer in the driver, and the timer's
> callback
> > will suspend the device. This approach has some issues. 1. it's
> better
> > driver doesn't handle device dependence. This approach requires
> driver
> > handle dependence.
> =

> Why not?
This will make driver complex. Driver should be as simple as possible.

Thanks,
Shaohua
