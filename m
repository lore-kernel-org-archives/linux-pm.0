From: John Stultz <john.stultz@linaro.org>
Subject: Re: [PATCH 20/20] timekeeping: Get rid of stale comment
Date: Wed, 1 Apr 2015 16:57:57 -0700
Message-ID: <CALAqxLUixFEcs7WYk8+g_QmqWXyFzFaqRZeRAnzM8ZAGRxCE_g@mail.gmail.com>
References: <2112147.0kYCHhbEJT@vostro.rjw.lan>
	<2146070.Jx8GFRJHyY@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <2146070.Jx8GFRJHyY@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Apr 1, 2015 at 3:26 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
>
> Arch specific management of xtime/jiffies/wall_to_monotonic is gone
> for quite a while. Zap the stale comment.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: John Stultz <john.stultz@linaro.org>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Acked-by: John Stultz <john.stultz@linaro.org>

thanks
-john
