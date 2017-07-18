From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v3 1/4] time: rtc-lib: Add rtc_show_time(const char
 *prefix_msg)
Date: Wed, 19 Jul 2017 00:36:49 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1707190035270.2425@nanos>
References: <20170718221607.132539-1-salyzyn@android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:41124 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751963AbdGRWg4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Jul 2017 18:36:56 -0400
In-Reply-To: <20170718221607.132539-1-salyzyn@android.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Salyzyn <salyzyn@android.com>
Cc: linux-kernel@vger.kernel.org, rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz, linux-pm@vger.kernel.org, a.zummo@towertech.it, alexandre.belloni@free-electrons.com, linux-rtc@vger.kernel.org, andy.shevchenko@gmail.com, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Mark Salyzyn <salyzyn@google.com>, Thierry Strudel <tstrudel@google.com>, John Stultz <john.stultz@linaro.org>, Josh Triplett <josh@joshtriplett.org>, Nicolas Pitre <nicolas.pitre@linaro.org>, Kees Cook <keescook@chromium.org>

On Tue, 18 Jul 2017, Mark Salyzyn wrote:

> Go directly to the rtc for persistent wall clock time and print.
> Useful if REALTIME is required to be logged in a low level power
> management function or when clock activities are suspended.  An
> aid to permit user space alignment of kernel activities.

Can you please spare the churn and wait until the discussion about the
general issues is resolved before sending out yet another set of patches,
which do not address any of the real important questions?

Thanks,

	tglx
