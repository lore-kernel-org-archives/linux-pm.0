From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: Regression in 4.8 - CPU speed set very low
Date: Mon, 26 Sep 2016 14:26:30 -0700
Message-ID: <1474925190.35049.120.camel@linux.intel.com>
References: <f89dffb9-cc78-9849-9539-74ce89e773cd@lwfinger.net>
         <3919370.SGLjGupePs@vostro.rjw.lan>
         <075788ab-34e0-803c-f2b4-3f370ecc6b14@lwfinger.net>
         <2477506.olat0BX4ex@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2477506.olat0BX4ex@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Larry Finger <Larry.Finger@lwfinger.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 2016-09-26 at 23:06 +0200, Rafael J. Wysocki wrote:
> On Monday, September 26, 2016 11:15:45 AM Larry Finger wrote:

[...]

> > I have been reluctant to post my entire .config on the list. It is
> > available at 
> > http://pastebin.com/aMZaAKwL.
> 
> If the governor is ondemand, the driver is acpi-cpufreq, most likely.
> 
> How do you measure the frequency?
> 
Also
When you get into this situation, please dump:
# cat /sys/devices/system/cpu/cpufreq/policy?/scaling_max_freq
# cat /sys/devices/system/cpu/intel_pstate/*


Thanks,
Srinivas
