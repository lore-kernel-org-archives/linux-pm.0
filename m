From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: RE: [PATCH v3 1/2] trace: events: add devfreq trace event file
Date: Thu, 21 Feb 2019 13:21:38 +0900
Message-ID: <20190221042138epcms1p76259d54fecdec5093b78651573076d71@epcms1p7>
References: <1550514069-9237-2-git-send-email-l.luba@partner.samsung.com>
        <1550514069-9237-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190218182129eucas1p236fc8ccddd9a8cde25c15f7545276885@epcms1p7>
Reply-To: myungjoo.ham@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1550514069-9237-2-git-send-email-l.luba@partner.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lukasz Luba <l.luba@partner.samsung.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, "mka@chromium.org" <mka@chromium.org>, "rostedt@goodmis.org" <rostedt@goodmis.org>, "mingo@redhat.com" <mingo@redhat.com>
List-Id: linux-pm@vger.kernel.org

>The patch adds a new file for with trace events for devfreq
>framework. They are used for performance analysis of the framework.
>It also contains updates in MAINTAINERS file adding new entry for
>devfreq maintainers.
>
>Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>---
> MAINTAINERS                    |  1 +
> include/trace/events/devfreq.h | 40 ++++++++++++++++++++++++++++++++++++++++
> 2 files changed, 41 insertions(+)
> create mode 100644 include/trace/events/devfreq.h

Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>

Thanks!


Cheers,
MyungJoo
