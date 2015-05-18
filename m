From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/1] power: validate wakeup source before activating it.
Date: Mon, 18 May 2015 02:34 +0200
Message-ID: <6066146.sNzXFSI8Td@vostro.rjw.lan>
References: <1430951216-3003-1-git-send-email-jinqian@android.com> <1816596.LjGsP0DkBO@vostro.rjw.lan> <CA+yUs=zjdEShJ=qg15b_CVtWSA1_wMXoc+fzm5psUZRQdN6Mrg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CA+yUs=zjdEShJ=qg15b_CVtWSA1_wMXoc+fzm5psUZRQdN6Mrg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jin Qian <jinqian@android.com>
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Friday, May 15, 2015 06:28:17 PM Jin Qian wrote:
> Hi Rafael,
> 
> The latest version is in [PATCHv3 1/3] power: validate wakeup source
> before activating it. I changed WARN_ONCE back to WARN since if
> multiple drivers activating uninitialized wakeup_sources, only the
> first driver will by flagged.

Which is OK.

If you're a user, you can't fix the problem by yourself and spamming the
logs with continued warnings doesn't help here.

If you're a developer, you'll fix the first driver and then see the
warning from the second one.

> We lost alert for other drivers. The warning should really happen during
> driver development. Hope this is ok.

First, I've applied your patch already.  Second, I really think that
WARN_ON_ONCE() is better here.


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
