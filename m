From: Tobias Jakobi <liquid.acid@gmx.net>
Subject: Re: [PATCH v3 00/16] thermal: exynos: Thermal code rework to
 use device tree
Date: Thu, 22 Jan 2015 02:06:10 +0100
Message-ID: <54C04D02.90405@gmx.net>
References: <1412872737-624-1-git-send-email-l.majewski@samsung.com> <1421242874-3425-1-git-send-email-l.majewski@samsung.com> <54B8549F.60707@gmx.net> <20150116092946.38860303@amdc2363> <54BD9377.30606@gmx.net> <20150120091729.3d01a0cf@amdc2363>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20150120091729.3d01a0cf@amdc2363>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Lukasz Majewski <l.majewski@samsung.com>
Cc: Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Thomas Abraham <thomas.ab@samsung.com>, tomasz.figa@gmail.com
List-Id: linux-pm@vger.kernel.org

Hello!


Lukasz Majewski wrote:
>> The point is that I'm still working with a rather old version of the
>> cpufreq series, a version which still had the Exynos4x12 code in it
>> (this was removed later, if I remember correctly because of problems
>> with how to properly describe boost configuration in DT).
> 
> Is your board Odroid-U3/Trats2 ?
It's an Odroid-X2, so pretty similar to the U3, except that it doesn't
have any active cooling device.


>> Anyway, to not get completly off-topic here, I noticed some small
>> issue with v3 of the thermal series. I've enabled
>> CONFIG_THERMAL_HWMON so that I can use lm_sensors to query
>> temperature of the board. However while the thermal_zone is created,
>> there is no hwmon node to be found. 
> 
> I'm not surprised, that some use cases (about which I wasn't even
> aware) show up. 
> I've already fixed issues reported by Abhilash (with v5 and a following
> patch) and look closer into the THERMAL_HWMON.
The problem seems to be that of_parse_thermal_zones always sets
'no_hwmon' to true, so that thermal_zone_device_register never registers
a hwmon device when the underlaying thermal zone is setup through DT. I
don't understand the rationale behind this, even with the comment ('No
hwmon because there might be hwmon drivers registering').


> I've also done some work regarding FAN controlled by hwmon for Odroid
> U3.
> Could you look on following series:
> http://www.spinics.net/lists/linux-samsung-soc/msg40471.html
> 
> I can only guess that your board might need similar entries for your
> DTS file(s).

Like I said, the X2 only has a passive heatsink, so no fan controlling here.


With best wishes,
Tobias
