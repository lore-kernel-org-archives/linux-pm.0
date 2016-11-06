From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: v4.8-rc1: thinkpad x60: running at low frequency even during
 kernel build
Date: Sun, 6 Nov 2016 01:45:01 -0200
Message-ID: <20161106034501.GI17290@khazad-dum.debian.net>
References: <20161104083849.GA32688@amd>
 <20161104085830.GA4089@amd>
 <1478268311.26953.17.camel@intel.com>
 <20161104204439.GA2581@amd>
 <1478293976.1268.15.camel@intel.com>
 <20161105084248.GA664@amd>
 <20161105174612.GA17290@khazad-dum.debian.net>
 <20161105193617.GA8705@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161105193617.GA8705@amd>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "ibm-acpi-devel@lists.sourceforge.net" <ibm-acpi-devel@lists.sourceforge.net>, "ibm-acpi@hmh.eng.br" <ibm-acpi@hmh.eng.br>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sat, 05 Nov 2016, Pavel Machek wrote:
> On Sat 2016-11-05 15:46:12, Henrique de Moraes Holschuh wrote:
> > On Sat, 05 Nov 2016, Pavel Machek wrote:
> > > Hmm, thanks for the pointer. But it seems like I'll have to build my
> > > own, as /proc/acpi/ibm does not follow the usual infrastructure...
> > 
> > /proc/acpi/ibm has been deprecated for years.  99% of the functionality
> > is available through more modern, standard interfaces.
> 
> Right, I see sensors can do it these days. Would it be good to expose
> them as /sys/class/thermal/thermal_zone*, too?

I don't like the idea of touching vendor-screwup-land like thermal
zones, especially when thinkpads *already* have thermal zones and they
must come from the very same sensors...

This would need a lot of careful studying and planning.

> Is it known what various fields in /proc/acpi/ibm/thermal measure?

It varies with each model.  You can map it out with better precision by
using a cold spray while doing an "open-heart" surgery on the thinkpad.
I kid you not, that's how they were mapped for some models.

Look for information about this in thinkwiki:
http://www.thinkwiki.org/wiki/Thermal_Sensors#ThinkPad_X60

The battery-pack-related sensor that is stuck at 50°C is something the
Lenovo Yamato labs guys wouldn't be clear about.  They told me to look
at what the Windows drivers do, but that would require (1) Windows in
the first place, and (2) clean room reverse engineering protocols.

> Basically... 100C is okay for semiconductors, but I'd prefer not to
> kill the hard drive....

Well, that first sensor getting to 100°C is your CPU for sure.

> > thinkpad-acpi is supposed to export standard hwmon temperature sensors
> > as well.  Try them instead, please.
> 
> Heh, I just finished python to work with /proc/acpi/ibm. Oh well.

Hey, I *did* properly document that driver, and the documentation is
even mostly up-to-date...  Please refer to
Documentation/laptops/thinkpad-acpi.txt in the kernel tree.

-- 
  Henrique Holschuh
