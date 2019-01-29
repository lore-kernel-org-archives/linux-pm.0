From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: RE: [PATCH 3/3] devfreq: add mediatek cci devfreq
Date: Tue, 29 Jan 2019 17:17:50 +0900
Message-ID: <20190129081750epcms1p41e46de569005622ad3d90f9aaa75f545@epcms1p4>
References: <1548743704-16821-4-git-send-email-andrew-sh.cheng@mediatek.com>
        <1548743704-16821-1-git-send-email-andrew-sh.cheng@mediatek.com>
        <CGME20190129063600epcas2p255b062c64f22555692ff895634ea4eb0@epcms1p4>
Reply-To: myungjoo.ham@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1548743704-16821-4-git-send-email-andrew-sh.cheng@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "srv_heupstream@mediatek.com" <srv_heupstream@mediatek.com>, "fan.chen@mediatek.com" <fan.chen@mediatek.com>, "Andrew-sh.Cheng" <andrew-sh.cheng@mediatek.com>
List-Id: linux-pm@vger.kernel.org

>From: "Andrew-sh.Cheng" <andrew-sh.cheng@mediatek.com>
>
>For big/little cpu cluster architecture,
>not only CPU frequency, but CCI frequency will also affect performance.
>
>Little cores and cci share the same buck in Mediatek mt8183 IC,
>so we add a CCI devfreq which will get notification when buck voltage
>is changed, then CCI devfreq can set cci frequency as high as possible.
>
>Signed-off-by: Andrew-sh.Cheng <andrew-sh.cheng@mediatek.com>

Please correct the coding style first in the .c file.

- empty last line?
- inconsistent indentation (line26? match the first lines for all variable declarations OR don't match them at all)
- Need proper boilerplate and try to comply with C89.

Cheers,
MyungJoo
