From: Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH] PM / devfreq: Fix handling of min/max_freq == 0
Date: Fri, 18 May 2018 10:49:54 -0700
Message-ID: <20180518174954.GC29467@google.com>
References: <CGME20180517223318epcas3p2c4bf4ef6d2c1c4b097df92c309adafa6@epcas3p2.samsung.com>
 <20180517223255.211918-1-mka@chromium.org>
 <5AFE0FFB.6050408@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5AFE0FFB.6050408@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Brian Norris <briannorris@chromium.org>, Douglas Anderson <dianders@chromium.org>
List-Id: linux-pm@vger.kernel.org

On Fri, May 18, 2018 at 08:27:55AM +0900, Chanwoo Choi wrote:
> Hi,
> 
> Please resend the patch with related other patches.
> It is hard to check the dependency/sequence of your patches.

The three patches (excluding the RFC) I sent in the past days are
independent from each other and can be applied individually in no
particular order.

I encountered and fixed the issues one after another, when I sent the
first or second patch I didn't know there would be another
one. Anyway, I'll resend as a series together with other patches,
unless some of the patches get applied before.

Thanks

Matthias
