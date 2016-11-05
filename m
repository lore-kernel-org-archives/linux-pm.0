From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: v4.8-rc1: thinkpad x60: running at low frequency even during
 kernel build
Date: Sat, 5 Nov 2016 16:04:58 -0200
Message-ID: <20161105180458.GB17290@khazad-dum.debian.net>
References: <20161104083849.GA32688@amd>
 <20161104085830.GA4089@amd>
 <1478268311.26953.17.camel@intel.com>
 <20161104204439.GA2581@amd>
 <20161104221600.GA7007@amd>
 <1478301649.7947.3.camel@intel.com>
 <20161105133719.GA3933@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161105133719.GA3933@amd>
Sender: linux-acpi-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "ibm-acpi-devel@lists.sourceforge.net" <ibm-acpi-devel@lists.sourceforge.net>, "ibm-acpi@hmh.eng.br" <ibm-acpi@hmh.eng.br>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sat, 05 Nov 2016, Pavel Machek wrote:
> [  825.759661] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports something is extremely hot!
> [  825.761935] thinkpad_acpi: temperatures (Celsius): 101 49 N/A 78 33 N/A 33 N/A 47 50 N/A N/A N/A N/A N/A N/A

Oh boy, that must be the second time in a decade that I see that
codepath triggering.  It is the second-level alert that the ThinkPad is
about to catch fire.

It should have logged a "is too hot!" first-level alert earlier, but
this depends on the EC and not the driver.  Maybe the temperature raised
too fast.

In Windows, the system would attempt to hibernate or shutdown.  I would
be quite happy to have thinkpad-acpi trigger such behavior as well,
patches (or guidance) are welcome ;-)

Anyway, if that temperature goes about 1~2°C higher, the EC should cut
power to your motherboard.  Apparently, the built-in thermal protection
clock modulation on the Intel processor is somehow saving your box from
that forced power-off.

-- 
  Henrique Holschuh
