From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: RE: [PATCH v4] PM / devfreq: Fix devfreq_add_device() when drivers
 are built as modules.
Date: Wed, 04 Jul 2018 09:59:18 +0900
Message-ID: <20180704005918epcms1p6c43766664c42fac3ee4d7eb7375b43eb@epcms1p6>
References: <20180703132931.14389-1-enric.balletbo@collabora.com>
        <CGME20180703132943epcas1p25b68c00ca1143d5eabcc2285c2ce27a0@epcms1p6>
Reply-To: myungjoo.ham@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180703132931.14389-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "kernel@collabora.com" <kernel@collabora.com>, Chanwoo Choi <cw00.choi@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

>+		if (!strncmp(name, DEVFREQ_GOV_SIMPLE_ONDEMAND,
>+			     DEVFREQ_NAME_LEN))
>+			err = request_module("governor_%s", "simpleondemand");
>+		else
>+			err = request_module("governor_%s", name);
>+		if (err)
>+			return NULL;

You are returning without the lock acquired..
