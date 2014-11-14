From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH] PM / domains: Kconfig: always enable PM_RUNTIME when genpd enabled
Date: Fri, 14 Nov 2014 09:36:17 -0800
Message-ID: <7ha93t8z1q.fsf@deeprootsystems.com>
References: <1415917702-6742-1-git-send-email-khilman@kernel.org>
	<1415917702-6742-2-git-send-email-khilman@kernel.org>
	<CAMuHMdXB-7vBqGZ_iMaZdDWDnnzpHZa4ECkDnojbDw=ds5eTWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdXB-7vBqGZ_iMaZdDWDnnzpHZa4ECkDnojbDw=ds5eTWg@mail.gmail.com>
	(Geert Uytterhoeven's message of "Fri, 14 Nov 2014 08:29:06 +0100")
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Linux PM list <linux-pm@vger.kernel.org>, linaro-kernel <linaro-kernel@lists.linaro.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Geert Uytterhoeven <geert@linux-m68k.org> writes:

> Hi Kevin,
>
> On Thu, Nov 13, 2014 at 11:28 PM, Kevin Hilman <khilman@kernel.org> wrote:
>> It makes little sense to use generic power domains without runtime PM.
>
> Does it?
> It still powers down the PM domains on system suspend (at least on my
> boards ;-)

Sure, but your devices are also using runtime PM, so I'm not sure how
does that change my statement above?

>> Also, since the complexities of handling the !PM_RUNTIME case are
>> causing more trouble and confusion than they're worth, let's simplify
>> the world by making genpd always enable runtime PM.
>
> What do other people think?

Yes, I'm curious also.  This patch was supposed to be marked RFC.

Kevin
