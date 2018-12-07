From: Quentin Perret <quentin.perret@arm.com>
Subject: Re: [RFC/RFT,v7] cpuidle: New timer events oriented governor for
 tickless systems
Date: Fri, 7 Dec 2018 09:37:53 +0000
Message-ID: <20181207093751.io5hhmg53camwpzh@queper01-lin>
References: <2047881.s5VBHReNGT@aspire.rjw.lan>
 <20181207075840.5881-1-hu1.chen@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181207075840.5881-1-hu1.chen@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Chen, Hu" <hu1.chen@intel.com>
Cc: rjw@rjwysocki.net, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Chen,

On Friday 07 Dec 2018 at 15:58:35 (+0800), Chen, Hu wrote:
> From: Chen Hu <hu1.chen@intel.com>
> 
> Hi Rafael,
> 
> I run several popular Android performance benchmarks on teov7, using kernel
> 4.19.0 as my baseline because I happen to work on it. To backport teov7 to
> kernel 4.19.0, I also backport patch 5f26bdc: "cpuidle: menu: Fix wakeup
> statistics updates for polling state". The teov7 doesn't show regressions on
> such perf KPIs.
> 
> Compare "4.19 + 5f26bdc" and "4.19 + 5f26bdc + teov7" on Android with Intel
> Apollo Lake SoC:
> 
> Test Case                               Diff after appling teov7
> Antutu_6                                0.51%
> GFX5_openGL_Car_Chase                   0.43%
> GFX5_openGL_Car_Chase_offscreen	        0.25%
> GFX5_openGL_Manhattan31	                0.75%
> GFX5_openGL_Manhattan31_1080_offscreen  -0.10%
> Geekbench3.3                            -0.13%
> H264_1080P_60FPS                        0.00%
> H264_2160P_60FPS                        0.00%
> H265_2K_10bit                           0.00%
> H265_2K_8bit                            0.00%
> Resume_time                             1.31%
> full_boot                               -0.39%

That's really nice that you guys are able to get good test results on
Android 4.19 that early after the release :-)

Do you happen to run interactive use-cases as well ? I think Jankbench
is one of the workload most folk care about for example. Also, did you
manage to measure energy numbers for the above tests ?

FWIW, I'd like to give a go to TEO on an Arm-based setup when I can.

Thanks,
Quentin
