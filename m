From: John Stultz <john.stultz@linaro.org>
Subject: Re: [PATCH 2/2] timekeeping: Cap array access in timekeeping_debug to
 protect against invalid sleep times
Date: Tue, 23 Aug 2016 19:54:25 -0700
Message-ID: <CALAqxLUrB1ZwBRk2-Ajkquhsa6_ztV8uXPq+-f7nBb1GnBd3Og@mail.gmail.com>
References: <1471993702-29148-1-git-send-email-john.stultz@linaro.org>
 <1471993702-29148-3-git-send-email-john.stultz@linaro.org> <20160824005830.GA16827@sharon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20160824005830.GA16827@sharon>
Sender: stable-owner@vger.kernel.org
To: Chen Yu <yu.c.chen@intel.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Janek Kozicki <cosurgi@gmail.com>, Xunlei Pang <xpang@redhat.com>, Zhang Rui <rui.zhang@intel.com>, Linux PM list <linux-pm@vger.kernel.org>, stable <stable@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Aug 23, 2016 at 5:58 PM, Chen Yu <yu.c.chen@intel.com> wrote:
> Hi John, some small typos below, others should be OK.

Thanks. I realize you mailed me before on this, but I forgot to
integrate the changes. Apologies.

I've now integrated the changes and updated the git branch.  The HEAD
for the pull request is now: 4efd3c8faf189674eeafb0c14ff4c556ed6adcf7.

I'll send an updated v2 patch here shortly.

thanks
-john
