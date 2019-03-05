From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH] power: Add and use pr_fmt
Date: Mon, 04 Mar 2019 18:15:19 -0800
Message-ID: <7himwyjcco.fsf@baylibre.com>
References: <06d16c65a81d28016643d714f8aa3dfd7a2ad3ed.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <06d16c65a81d28016643d714f8aa3dfd7a2ad3ed.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joe Perches <joe@perches.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kees Cook <keescook@chromium.org>, Anton Vorontsov <anton@enomsg.org>, Colin Cross <ccross@android.com>, Tony Luck <tony.luck@intel.com>, linux-pm@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Joe Perches <joe@perches.com> writes:

> Prefix all printk/pr_<level> messages with "PM: " to make the
> logging a bit more consistent.
>
> Miscellanea:
>
> o Convert a few printks to pr_<level>
> o Whitespace to align to open parentheses
> o Remove embedded "PM: " from pr_debugs as pr_fmt adds it
>
> Signed-off-by: Joe Perches <joe@perches.com>

Reviewed-by: Kevin Hilman <khilman@baylibre.com>
