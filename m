From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: RE: [PATCH v2] PM / devfreq: Stop the governor before
 device_unregister()
Date: Thu, 27 Sep 2018 14:20:36 +0900
Message-ID: <20180927052036epcms1p15fb2970f4ddc0256096d674d6932aabd@epcms1p1>
References: <1537544432-34712-1-git-send-email-vincent.donnefort@arm.com>
        <5B8901D7.5040301@samsung.com>
        <CGME20180921154052epcas1p4d4ba6b7435a50f1f77ae85ceda594b69@epcms1p1>
Reply-To: myungjoo.ham@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1537544432-34712-1-git-send-email-vincent.donnefort@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "john.reitan@arm.com" <john.reitan@arm.com>, "beata.michalska@arm.com" <beata.michalska@arm.com>, Vincent Donnefort <vincent.donnefort@arm.com>
List-Id: linux-pm@vger.kernel.org

> From: Vincent Donnefort <vincent.donnefort@arm.com>
> 
> device_release() is freeing the resources before calling the device
> specific release callback which is, in the case of devfreq, stopping
> the governor.
> 
> It is a problem as some governors are using the device resources. e.g.
> simpleondemand which is using the devfreq deferrable monitoring work. If it
> is not stopped before the resources are freed, it might lead to a use after
> free.
> 
> Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>
> Reviewed-by: John Einar Reitan <john.reitan@arm.com>
> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>


Cheers,
MyungJoo
