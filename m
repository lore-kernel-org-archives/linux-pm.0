From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: v4.8-rc1: thinkpad x60: running at low frequency even during
 kernel build
Date: Sat, 5 Nov 2016 16:21:21 -0200
Message-ID: <20161105182121.GC17290@khazad-dum.debian.net>
References: <20161104083849.GA32688@amd>
 <20161104085830.GA4089@amd>
 <20161104091037.GD3414@vireshk-i7>
 <20161104092636.GA30729@amd>
 <20161104093105.GE3414@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161104093105.GE3414@vireshk-i7>
Sender: linux-acpi-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Pavel Machek <pavel@ucw.cz>, rjw@rjwysocki.net, linux-pm@vger.kernel.org, kernel list <linux-kernel@vger.kernel.org>, rui.zhang@intel.com, linux-acpi@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Fri, 04 Nov 2016, Viresh Kumar wrote:
> On 04-11-16, 10:26, Pavel Machek wrote:
> > How would I know if it is thermal capping? There's nothing in dmesg.
> 
> I am not sure what code is responsible for doing that in case of x86, maybe
> Rafael and Rui can explain it that better.
> 
> But surely it involves userspace in this case as scaling_max_freq is getting
> changed.

Note that a X60 might limit the maximum frequency through ACPI when on
AC *and* its battery is not installed or not in working order.

The EC tries to detect the power brick type (65W, 90W), which often
doesn't work well on non-Lenovo power bricks, and signals the BIOS to
limit the maximum frequency if it thinks its only power source is a 65W
power brick.

This behavior would be readly visible by the X60 refusing to reach the
maximum clock frequency *at all* -- it is a static limit, only removed
when a sufficiently charged battery becomes available.

This indirect power draw capping should never engage if your battery is
installed and working, regardless of type and brand of power adapter,
AFAIK.  I am only mentioning it so that you are aware of this possible
behavior while debugging.


Anyway, this overheating thinkpad very, very likely needs a hardware
repair (on top of the kernel bug fixes ;-) ).

Regardless of any kernel/userspace bugs, the X60 was engineered to not
require thermal capping on reasonable indoor environmental temperature
ranges.  If it needs the kernel to do something at all to avoid
overheating just because it has been running at full CPU power, and
ambient temperature is below 28°C, it very likely has a hardware issue
(lint on the heatsink/fan, and/or cracked thermal interface between
heatsink and processor).

Every old-style ThinkPad (like the X60) that I have ever seen
overheating when running at full CPU power (after fan lint was removed)
in a cool place (say, 26°C), stopped overheating after a heatsink reseat
and thermal compound replacement (and if you're going to do it, use
non-shelf-aged Arctic Silver 5 or something better, and "cure" it
properly -- something rather easy to do on a ThinkPad X60).

-- 
  Henrique Holschuh
