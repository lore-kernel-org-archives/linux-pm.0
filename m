From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: PM / suspend / s2idle: avoiding splats on RT
Date: Fri, 25 May 2018 12:05:31 +0200
Message-ID: <CAJZ5v0j9hjASBOyrkCQ1CxF812THJZOHahJwpcmyC3XC4Fr6xA@mail.gmail.com>
References: <20180525094648.15464-1-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180525094648.15464-1-bigeasy@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Thomas Gleixner <tglx@linutronix.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, May 25, 2018 at 11:46 AM, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
> Patch #1 is a repost with the s2idle bits included. I tested via
>         echo s2idle > mem_sleep && echo mem > state
>
> and I woke up the machine via the power on button. Patches #2+ were
> additionally required with s2idle.

I quite don't like the first one for reasons explained in the reply to it.

The others are fine by me and I can queue them up if you want me to do that.

Thanks,
Rafael
