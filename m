From: Tobias Jakobi <liquid.acid@gmx.net>
Subject: Re: [PATCH v3 00/16] thermal: exynos: Thermal code rework to
 use device tree
Date: Tue, 20 Jan 2015 00:29:59 +0100
Message-ID: <54BD9377.30606@gmx.net>
References: <1412872737-624-1-git-send-email-l.majewski@samsung.com> <1421242874-3425-1-git-send-email-l.majewski@samsung.com> <54B8549F.60707@gmx.net> <20150116092946.38860303@amdc2363>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.21]:60603 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751552AbbASXaI (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 19 Jan 2015 18:30:08 -0500
In-Reply-To: <20150116092946.38860303@amdc2363>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lukasz Majewski <l.majewski@samsung.com>
Cc: Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Thomas Abraham <thomas.ab@samsung.com>, tomasz.figa@gmail.com

Hello!

Lukasz Majewski wrote:
> We all know that this code is floating around - early version of this
> work was posted in the Q3 2013.
> 
> To be fair - this code is both needed and welcome, but new problems
> with it are found (please search for recent comment from Kevin
> Hilman).
> 
> From my side, I focus on the code which is in Eduardo Valentin's next
> (3.19-rc3), since I don't know when and if eventually cpufreq rework
> would be merged.
I'm sorry, my wording wasn't the best here. I'm not critizing the work
done here, merely voicing my concern (and also interest!) about how the
new stuff interacts with code that may eventually get merged.
You're aware of it, that's enough for me to know.


> The code which touches exynos-cpufreq.c is around 30 LOC, only for
> preserving cpu cooling functionality.
> 
> Is it worth to wait for code developed for so long to happily apply 30
> LOC and delay removal of around 400 LOC in other subsystem (thermal)?
No, of course not. That was pretty stupid of me :(


> I rise my hand as a volunteer to fix any thermal related issues which
> show up after cpufreq rework code applying to Exynos.
That's certainly good to hear!


> This series is NOT providing any NEW functionality. It in fact
> preserves functionality, which allows using CPU frequency as a mean to
> cool the device.
I've got a question concerning this. Is this only needed for
exynos-cpufreq, or does cpufreq-dt also need something like that.

The point is that I'm still working with a rather old version of the
cpufreq series, a version which still had the Exynos4x12 code in it
(this was removed later, if I remember correctly because of problems
with how to properly describe boost configuration in DT).


Anyway, to not get completly off-topic here, I noticed some small issue
with v3 of the thermal series. I've enabled CONFIG_THERMAL_HWMON so that
I can use lm_sensors to query temperature of the board. However while
the thermal_zone is created, there is no hwmon node to be found. This
was working properly without the thermal series.


With best wishes,
Tobias

