From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: intel_pstate: Lowest frequency not reached with Intel i7-6700
Date: Thu, 13 Dec 2018 11:39:17 +0100
Message-ID: <CAJZ5v0gUDzy8vV=JajDHZJi2F0FyHUkFfYbbJhMioUa5XoKuqA@mail.gmail.com>
References: <000701d4926f$533eb270$f9bc1750$@net> <a4321c48-e9df-1a2a-cfbd-bac07a9c65d8@molgen.mpg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <a4321c48-e9df-1a2a-cfbd-bac07a9c65d8@molgen.mpg.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Doug Smythies <dsmythies@telus.net>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Dec 13, 2018 at 10:54 AM Paul Menzel <pmenzel@molgen.mpg.de> wrote:
>
> Dear Doug,
>
>
> Thank you for your reply.
>
> On 12/13/18 00:06, Doug Smythies wrote:
> > On 2018.12.12 13:40 Paul Menzel wrote:
> >
> >> Using *powersave* as P-state selection algorithm, on an idle system
> >
> > Define "idle system".
> > If your computer is running a GUI, or is even a server without a GUI
> > but with many services running, then "idle" really isn't.
> > Below is from my test server, with many services disabled, so
> > "idle" really is quite "idle"
> >
> > doug@s15:~/temp$ sudo turbostat --Summary --quiet --show Busy%,Bzy_MHz,PkgTmp,PkgWatt --interval 15
> > Busy%   Bzy_MHz PkgTmp  PkgWatt
> > 0.01    1608    27      3.71
> > 0.01    1619    27      3.71
> > 0.01    1600    28      3.71
> > 0.01    1600    28      3.70
> >
> > Note that p state 16 (1600 MHz) is the minimum for my older i7-2600k
> > processor.
>
> The thing is, on an Intel Kaby Lake laptop with Ubuntu 18.10 and GNOME
> running, it goes down to the lowest listed frequency.

Kaby Lake has hardware-managed P-states (HWP) which is a different mechanism.

> >> Shouldn’t it go down until 800 MHz?
> >
> > We would need some actual busy information, turbostat is the
> > recommended tool, to know for sure.
>
> Here you go.
>
> ```
> tools/power/x86/turbostat> sudo ./turbostat --Summary --quiet --show Busy%,Bzy_MHz,PkgTmp,PkgWatt --interval 15
> Busy%    Bzy_MHz    PkgTmp    PkgWatt
> 3.59    1167    31    1.68
> 3.21    903    31    1.34
> 3.21    906    31    1.34
> 3.27    901    31    1.35
> 8.23    2715    30    2.32  ← stopping GDM (systemctl stop gdm)
> 2.95    915    30    1.18
> 2.91    906    30    1.18
> 2.92    903    30    1.17
> 2.90    900    29    1.17
> 2.89    903    29    1.18
> 2.91    903    30    1.18
> 2.89    903    29    1.18
> 2.89    900    29    1.18
> 2.90    903    30    1.18
> 2.90    903    29    1.17
> 2.90    903    29    1.17
> 2.90    900    29    1.16
> 2.90    903    29    1.14
> 2.90    903    28    1.11
> 2.90    903    29    1.10
> 2.91    900    29    1.16
> 2.91    903    29    1.14
> 2.90    903    29    1.12
> 2.90    903    29    1.16
> 2.90    900    28    1.17
> 2.92    903    29    1.16
> 2.90    903    29    1.16
> 2.90    903    29    1.16
> ```
>
> 800 MHz should be enough to keep GDM running, shouldn’t it?

Well, depending.

> Otherwise only SSH was running.

There obviously is something that causes it to stay at 900 MHz.

Please check max_perf_pct, min_perf_pct and num_pstates under
/sys/devices/system/cpu/intel_pstate/ .

Also cpuinfo_max_freq, cpuinfo_min_freq, scaling_max_freq,
scaling_min_freq under /sys/devices/system/cpu/cpufreq/policy0/ .

However, please note that Busy% of 3 isn't particularly low.
