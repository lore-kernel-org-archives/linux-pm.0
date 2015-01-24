From: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
Subject: Re: [PATCH v3 00/16] thermal: exynos: Thermal code rework to
 use device tree
Date: Sat, 24 Jan 2015 02:00:09 +0100
Message-ID: <54C2EE99.6070108@math.uni-bielefeld.de>
References: <1412872737-624-1-git-send-email-l.majewski@samsung.com> <1421242874-3425-1-git-send-email-l.majewski@samsung.com> <54B8549F.60707@gmx.net> <20150116092946.38860303@amdc2363> <54BD9377.30606@gmx.net> <20150120091729.3d01a0cf@amdc2363> <54C04D02.90405@gmx.net> <20150121090802.GC13468@developer.hsd1.ca.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20150121090802.GC13468@developer.hsd1.ca.comcast.net>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Lukasz Majewski <l.majewski@samsung.com>, Zhang Rui <rui.zhang@intel.com>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Thomas Abraham <thomas.ab@samsung.com>, tomasz.figa@gmail.com
List-Id: linux-pm@vger.kernel.org

Eduardo Valentin wrote:
> The reason is that hwmon sensor device drivers also register via
> of-thermal. So, adding hwmon interface by default will create a
> cyclic problem.
Hmm, I see. Would it still be possible to flag some thermal zones so
that hwmon nodes are created for them?


With best wishes,
Tobias
