From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: v4.8-rc1: thinkpad x60: running at low frequency even during
 kernel build
Date: Sat, 5 Nov 2016 15:46:12 -0200
Message-ID: <20161105174612.GA17290@khazad-dum.debian.net>
References: <20161104083849.GA32688@amd>
 <20161104085830.GA4089@amd>
 <1478268311.26953.17.camel@intel.com>
 <20161104204439.GA2581@amd>
 <1478293976.1268.15.camel@intel.com>
 <20161105084248.GA664@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161105084248.GA664@amd>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "ibm-acpi-devel@lists.sourceforge.net" <ibm-acpi-devel@lists.sourceforge.net>, "ibm-acpi@hmh.eng.br" <ibm-acpi@hmh.eng.br>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sat, 05 Nov 2016, Pavel Machek wrote:
> Hmm, thanks for the pointer. But it seems like I'll have to build my
> own, as /proc/acpi/ibm does not follow the usual infrastructure...

/proc/acpi/ibm has been deprecated for years.  99% of the functionality
is available through more modern, standard interfaces.

thinkpad-acpi is supposed to export standard hwmon temperature sensors
as well.  Try them instead, please.

Also, thinkpad-acpi will report the EC thermal sensors.  They don't need
to (and most often won't) match whatever you read from the processor
core(s).

-- 
  Henrique Holschuh
