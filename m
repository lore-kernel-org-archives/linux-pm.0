From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: RE: [PATCH 1/6] devfreq: add basic fileds supporting suspend
 functionality
Date: Mon, 26 Nov 2018 17:14:27 +0900
Message-ID: <20181126081427epcms1p8801d251017da40b59d7e8391ee247fdb@epcms1p8>
References: <1542823301-23563-2-git-send-email-l.luba@partner.samsung.com>
        <1542823301-23563-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20181121180201eucas1p1f1f96941c3d16a96722e65d5c21bfe80@epcms1p8>
Reply-To: myungjoo.ham@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1542823301-23563-2-git-send-email-l.luba@partner.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lukasz Luba <l.luba@partner.samsung.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Cc: "tjakobi@math.uni-bielefeld.de" <tjakobi@math.uni-bielefeld.de>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "len.brown@intel.com" <len.brown@intel.com>, "pavel@ucw.cz" <pavel@ucw.cz>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "keescook@chromium.org" <keescook@chromium.org>, "anton@enomsg.org" <anton@enomsg.org>, "ccross@android.com" <ccross@android.com>, "tony.luck@intel.com" <tony.luck@intel.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "kgene@kernel.org" <kgene@kernel.org>, "krzk@kernel.org" <krzk@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-pm@vger.kernel.org

>The patch prepares devfreq device for handling suspend/resume functionality.
>The new fields will store needed information during this process.
>Devfreq framework handles opp-suspend DT entry and there is no need of
>modyfications in the drivers code.
>
>The patch draws on Tobias Jakobi's work posted ~2 years ago, who tried to
>solve issue with devfreq device's frequency during suspend/resume.
>During the discussion on LKML some corner cases and comments appeared
>related to the design. This patch address them keeping in mind suggestions
>from Chanwoo Choi.
>
>Suggested-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
>Suggested-by: Chanwoo Choi <cw00.choi@samsung.com>
>Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>

When you add new elements in a common struct (i.e., struct devfreq),
please describe kindly in the doxygen entries so that developers
may understand before reading all places where the new elements are
used.

You have added three new elements and there is no explanations on them.


Cheers,
MyungJoo
