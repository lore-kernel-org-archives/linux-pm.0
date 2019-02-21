From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: RE: [PATCH v3 2/2] drivers: devfreq: add tracing for scheduling
 work
Date: Thu, 21 Feb 2019 13:26:56 +0900
Message-ID: <20190221042656epcms1p1dbc8b4db8566003a8dd3ec6212343494@epcms1p1>
References: <1550514069-9237-3-git-send-email-l.luba@partner.samsung.com>
        <1550514069-9237-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190218182129eucas1p1804530445570fc73af89ed46b9a448b9@epcms1p1>
Reply-To: myungjoo.ham@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1550514069-9237-3-git-send-email-l.luba@partner.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lukasz Luba <l.luba@partner.samsung.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, "mka@chromium.org" <mka@chromium.org>, "rostedt@goodmis.org" <rostedt@goodmis.org>, "mingo@redhat.com" <mingo@redhat.com>
List-Id: linux-pm@vger.kernel.org

>This patch add basic tracing of the devfreq workqueue and delayed work.
>It aims to capture changes of the polling intervals and device state.
>
>Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>---
> drivers/devfreq/devfreq.c | 5 +++++
> 1 file changed, 5 insertions(+)
>
>diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>index 0ae3de7..660365a 100644
>--- a/drivers/devfreq/devfreq.c
>+++ b/drivers/devfreq/devfreq.c

Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>
