From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH] thermal: bcm2835: enable hwmon explicitly
Date: Wed, 7 Nov 2018 20:04:44 +0100 (CET)
Message-ID: <1393364689.141956.1541617484605@email.ionos.de>
References: <20181021215848.5827-1-matthias.bgg@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181021215848.5827-1-matthias.bgg@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: matthias.bgg@kernel.org, rui.zhang@intel.com, edubezval@gmail.com, daniel.lezcano@linaro.org
Cc: pmladek@suse.com, Matthias Brugger <mbrugger@suse.com>, eric@anholt.net, geert+renesas@glider.be, bcm-kernel-feedback-list@broadcom.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, rjui@broadcom.com, sbranden@broadcom.com, f.fainelli@gmail.com, linux-rpi-kernel@lists.infradead.org, matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Hi Rui,
hi Eduardo,
hi Daniel,

> matthias.bgg@kernel.org hat am 21. Oktober 2018 um 23:58 geschrieben:
> 
> 
> From: Matthias Brugger <mbrugger@suse.com>
> 
> By defaul of-based thermal driver do not enable hwmon.
> This patch does this explicitly, so that the temperature can be read
> through the common hwmon sysfs.
> 
> Signed-off-by: Matthias Brugger <mbrugger@suse.com>
> ---

any objections except of the missing t in default?

Stefan
