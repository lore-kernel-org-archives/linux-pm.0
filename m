From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: RE: [RFC PATCH v2 6/7] typec: tcpm: Represent source supply through
 power_supply class
Date: Mon, 27 Nov 2017 16:54:08 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A0337014C1B15A4@SW-EX-MBX01.diasemi.com>
References: <cover.1510657748.git.Adam.Thomson.Opensource@diasemi.com>
 <81dd8843163c9ca193f32d54adb6fece99e5f159.1510657748.git.Adam.Thomson.Opensource@diasemi.com>
 <20171124121902.GA2403@kuha.fi.intel.com>
 <2E89032DDAA8B9408CB92943514A0337014C1B1241@SW-EX-MBX01.diasemi.com>
 <20171127141157.GC2403@kuha.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171127141157.GC2403@kuha.fi.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, Adam Thomson <Adam.Thomson.Opensource@diasemi.com>, "Sebastian Reichel (sre@kernel.org)" <sre@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Guenter Roeck <linux@roeck-us.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Yueyao Zhu <yueyao.zhu@gmail.com>, Rui Miguel Silva <rmfrfs@gmail.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Support Opensource <Support.Opensource@diasemi.com>
List-Id: linux-pm@vger.kernel.org

On 27 November 2017 14:12, Heikki Krogerus wrote:

> Hi Adam,
> 
> On Fri, Nov 24, 2017 at 02:05:27PM +0000, Adam Thomson wrote:
> > On 24 November 2017 12:19, Heikki Krogerus wrote:
> > > Is it OK to everybody that the type of the psy is changed like that?
> > > Hans?!
> > >
> > > We do have drivers that already change the type, for example
> > > drivers/power/supply/isp1704_charger.c, but what does the user space
> > > expect? The ABI for the power supply class was never documented I
> > > guess.
> > >
> >
> > Hi Heikki,
> >
> > Appreciate your time in reviewing this.
> >
> > Yes, I actually saw that as an example when I considered this approach. I didn't
> > see anything obvious for this in the ABI documentation. Any ideas Sebastian?
> > What is user-space expectation for the 'type' property of a power_supply? I
> > assume having this dynamic is ok given existing drivers can already do something
> > like this, but would be good to have clarification.
> >
> > > I'm not against changing the type, but I think that we should have an
> > > attribute file listing all supported types a psy can have if we go
> > > forward with this. Ideally the type file would just list them as space
> > > separated values, and show the current one with asterisk in front of
> > > it. The output would be similar we have with some of the other files
> > > under /sys/power, at least /sys/power/state, but that would break the
> > > ABI.
> > >
> >
> > I added this as I wanted the user to know what was connected rather than
> > blindly trying to set the 'online' property to enable PPS, even if the attached
> > source partner didn't support this. As you say, am not sure we could change the
> > 'TYPE' property as that to my knowledge has always been a single string.
> >
> > Maybe the addition of a 'SUPPORTED_TYPES' property or something similar could
> > close this gap (as you eluded to), at least by providing a RO list of all
> > supported types? Another option would be to add a type which indicates the
> > supply supports multiple types, and then based on this we can read another
> > property which does as you suggest with multiple strings and one being
> > highlighted? Am certainly open to discussion on this.
> 
> It looks like this is USB specific problem. I think the type should
> actually be just USB, and there should be an other USB only attribute
> file which should list the current and supported connection types.
> Well, maybe it does not even need to be USB only.

I believe in Android (BatteryMonitor) right now it maps the various USB
types that can be reported by a power_supply driver to an internal Android 'AC'
type (or 'USB' for 'PD_DRP') for use in upper level software, so they handle the
various USB reported types but simplify reporting. That code seems like it would
also handle changes in type as well because the type is re-read when dealing
with updates. So there is a wide spread user which already 'copes' with current
driver implementations. That's not saying it's necessarily the correct way to go
in the future but wanted to highlight current usage.

Personally what you're suggesting seems reasonable to me. I would however like
to get a general consensus on this as I guess this could potentially change
future power_supply driver implementations.

Sebastian, do you have any thoughts on this topic?
