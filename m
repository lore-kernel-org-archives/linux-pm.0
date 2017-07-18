From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 1/4] rtc-lib: Add rtc_show_time(const char *prefix_msg)
Date: Tue, 18 Jul 2017 20:46:39 +0300
Message-ID: <CAHp75VfZN45E2bXiaNgEfM_=NVhPhtER-8rN4PxeGsLoBQ-2Cg@mail.gmail.com>
References: <20170718172525.114514-1-salyzyn@android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170718172525.114514-1-salyzyn@android.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Salyzyn <salyzyn@android.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Brown, Len" <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-rtc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, Jul 18, 2017 at 8:25 PM, Mark Salyzyn <salyzyn@android.com> wrote:
> Go directly to the rtc for persistent wall clock time and print.
> Useful if REALTIME is required to be logged in a low level power
> management function or when clock activities are suspended.  An
> aid to permit user space alignment of kernel activities.
>
> Feature activated by CONFIG_RTC_SHOW_TIME.

What's wrong with procfs device nodes for that?

-- 
With Best Regards,
Andy Shevchenko
