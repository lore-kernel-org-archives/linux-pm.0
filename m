From: "Chen, Hu" <hu1.chen@intel.com>
Subject: Re: [RFC/RFT,v7] cpuidle: New timer events oriented governor for tickless systems
Date: Fri,  7 Dec 2018 15:58:35 +0800
Message-ID: <20181207075840.5881-1-hu1.chen@intel.com>
References: <2047881.s5VBHReNGT@aspire.rjw.lan>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2047881.s5VBHReNGT@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net
Cc: Chen Hu <hu1.chen@intel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Chen Hu <hu1.chen@intel.com>

Hi Rafael,

I run several popular Android performance benchmarks on teov7, using kernel
4.19.0 as my baseline because I happen to work on it. To backport teov7 to
kernel 4.19.0, I also backport patch 5f26bdc: "cpuidle: menu: Fix wakeup
statistics updates for polling state". The teov7 doesn't show regressions on
such perf KPIs.

Compare "4.19 + 5f26bdc" and "4.19 + 5f26bdc + teov7" on Android with Intel
Apollo Lake SoC:

Test Case                               Diff after appling teov7
Antutu_6                                0.51%
GFX5_openGL_Car_Chase                   0.43%
GFX5_openGL_Car_Chase_offscreen	        0.25%
GFX5_openGL_Manhattan31	                0.75%
GFX5_openGL_Manhattan31_1080_offscreen  -0.10%
Geekbench3.3                            -0.13%
H264_1080P_60FPS                        0.00%
H264_2160P_60FPS                        0.00%
H265_2K_10bit                           0.00%
H265_2K_8bit                            0.00%
Resume_time                             1.31%
full_boot                               -0.39%

Thanks
Chen Hu
