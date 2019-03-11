From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] power: Add and use pr_fmt
Date: Mon, 11 Mar 2019 13:00:45 +0100
Message-ID: <1770110.j5eI0eBPZe@aspire.rjw.lan>
References: <06d16c65a81d28016643d714f8aa3dfd7a2ad3ed.camel@perches.com> <7himwyjcco.fsf@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7himwyjcco.fsf@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kevin Hilman <khilman@baylibre.com>, Joe Perches <joe@perches.com>
Cc: Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kees Cook <keescook@chromium.org>, Anton Vorontsov <anton@enomsg.org>, Colin Cross <ccross@android.com>, Tony Luck <tony.luck@intel.com>, linux-pm@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday, March 5, 2019 3:15:19 AM CET Kevin Hilman wrote:
> Joe Perches <joe@perches.com> writes:
> 
> > Prefix all printk/pr_<level> messages with "PM: " to make the
> > logging a bit more consistent.
> >
> > Miscellanea:
> >
> > o Convert a few printks to pr_<level>
> > o Whitespace to align to open parentheses
> > o Remove embedded "PM: " from pr_debugs as pr_fmt adds it
> >
> > Signed-off-by: Joe Perches <joe@perches.com>
> 
> Reviewed-by: Kevin Hilman <khilman@baylibre.com>
> 

Patch applied, thanks!
