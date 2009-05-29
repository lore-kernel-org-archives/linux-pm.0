From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH 00/04][RFC] PM: Runtime platform device PM
Date: Fri, 29 May 2009 18:17:42 +0900
Message-ID: <aec7e5c30905290217s651e5785s2ceaebbe1856d120__41435.6991219849$1243588803$gmane$org@mail.gmail.com>
References: <20090527100625.29671.43166.sendpatchset@rx1.opensource.se>
	<877i01p2t8.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <877i01p2t8.fsf@deeprootsystems.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: paul@pwsan.com, linux-sh@vger.kernel.org, gregkh@suse.de, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Fri, May 29, 2009 at 2:14 AM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> Magnus Damm <magnus.damm@gmail.com> writes:
>> I propose adding the following simple platform device functions:
>> =A0- platform_device_wakeup()
>> =A0- platform_device_idle()

> A couple comments/questions:
>
> Wouldn't the 'wakeup' hook be better named platform_device_enable().
> The _wakeup name seems to imply that the call will perform some sort
> of wakeup, but all it's really doing is enabling it by turning it on
> or taking it out of idle.

The names platform_device_enable() and platform_device_disable() were
my first pick. Similar to pci_enable_device() and
pci_disable_device(). People may mixup platform_device_wakeup() and
pci_enable_wake() so avoiding using wakeup as name may be a good plan.
Not sure what would be a better name though.

Now why I didn't go with enable() and disable() was that dev_pm_ops
callbacks may be called for a device that has been "disabled". This
seems a bit strange to me. Making the interface clear and show that
this is not a normal enable() and disable() interface may be a good
idea.

Or maybe it's perfectly acceptable that a "disabled" device may get
it's dev_pm_ops callbacks exercised?

> In the process of discussing a similar interface for OMAP, we dicussed
> that having 3 states would be more useful. =A0Specifically, and
> _enable(), _idle() and _disable() hook. =A0The _enable() and _idle()
> hooks being exactly what you proposed above, but with the addition of
> a _disable() hook which says not only can the device go idle, but that
> the driver is really finished with the device. =A0In this case, more
> aggresive PM measures could be taken, such as turning of regulators
> that may have long latencies that may not be appropriate to turn off
> in idle.

Hm.. I wonder when the driver is really finished with the device
though. Only when the module is unloaded? If so then we could deal
with the hard disable using platform bus notifiers (like in [04/04]).

Or is it common that the driver does disable() at some point and
depending on the work load may have to perform a enable() soon again?

disable() seems like a more heavy weight clk_disable()? Maybe we can
let i2c drivers use enable() and disable() in their ->master_xfer()
callback. So the natural state of the i2c master device is off, and
enable() is called before data transfer in ->master_xfer(), followed
by a disable(). I do exactly this but with the clock framework in
i2c-sh_mobile.c.

The problem with the i2c example above is that the driver writer has
no clue about the frequency of the enable() and disable() calls. So
maybe disable() should be replaced with idle()? But if so when is the
real use for disable(). I'd say that the runtime PM core should decide
which state to enter, and the driver can can help out by giving
latency requirements as input. That's it.

So I'm not really sure when we need this hard disable(). Do you have
any special case in mind?

> I'm interested in any thoughts there because the line between _idle()
> and _disable() remains a little fuzzy to me still. =A0For exmaple, maybe
> the _idle() call in combination with latency constraints in PM QoS
> could do effectively the same thing as _disable().

Aren't two functions (wakeup()/idle() or enable()/disable()) together
with PM QoS latency enough?

Yeah, the fuzzy line is interesting. =3D)

/ magnus
