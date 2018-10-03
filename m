From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH RFC] cpuidle/drivers/menu: Remove get_loadavg in the
 performance multiplier
Date: Wed, 3 Oct 2018 15:05:14 +0200
Message-ID: <ba6c1dfe-d4ce-c697-3b44-992946cd5c4a@linaro.org>
References: <1537868328-13405-1-git-send-email-daniel.lezcano@linaro.org>
 <4200780.ZjVhNjpZ67@aspire.rjw.lan>
 <ab561a7d-9425-7b04-8d11-ed3e85afe971@linaro.org>
 <CAJZ5v0iRMvhZ1rW40syPRJfYBZ4=zE2-f4HcKaRQsvg18pnTcw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0iRMvhZ1rW40syPRJfYBZ4=zE2-f4HcKaRQsvg18pnTcw@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Peter Zijlstra <peterz@infradead.org>, Linux PM <linux-pm@vger.kernel.org>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>, Colin Cross <ccross@android.com>, Ramesh Thomas <ramesh.thomas@intel.com>, Alex Shi <alex.shi@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mel Gorman <mgorman@suse.de>
List-Id: linux-pm@vger.kernel.org

On 03/10/2018 13:09, Rafael J. Wysocki wrote:
> On Wed, Oct 3, 2018 at 12:25 PM Daniel Lezcano

[ ... ]

> If you send a non-RFC patch to drop get_loadavg() (but you can drop it
> altogether then, there are no other callers of it AFAICS), I'll queue
> it up after the 4.20 (or whatever it turns out to be in the end) merge
> window so all of the CIs out there have a chance to report issues (if
> any).

Sure, I can do that. There were some changes in this file, shall I base
the patch on v4.19-rc6 or linux-pm/linux-next ?


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
