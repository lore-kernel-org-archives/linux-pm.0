From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 1/3] phy: core: Move runtime PM reference counting to
 the parent device
Date: Sat, 23 Dec 2017 16:09:33 +0100
Message-ID: <CAPDyKFpHNYbf3Wz+Hq94Rm_wQGWnQkc6B2cS_RTjkmcbeeZoyw@mail.gmail.com>
References: <1513778960-10073-1-git-send-email-ulf.hansson@linaro.org>
 <1513778960-10073-2-git-send-email-ulf.hansson@linaro.org>
 <CAJZ5v0iwR1MnBokL29_QmUw2F6fgNNwzP7WLhtAL37MkMLd1xQ@mail.gmail.com> <CAJZ5v0hmSaWiy9zQPP+0FySySW4yNCm92mTtJ7ebd+rBjjqJng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0hmSaWiy9zQPP+0FySySW4yNCm92mTtJ7ebd+rBjjqJng@mail.gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

[...]

>
> So IMO the changes you are proposing make sense regardless of the
> genpd issue, because they generally simplify the phy code, but the
> additional use_runtime_pm field in struct phy represents redundant
> information (manipulating reference counters shouldn't matter if
> runtime PM is disabled), so it doesn't appear to be necessary.
>

Actually, the first version I posted treated the return codes from
pm_runtime_get_sync() according to your suggestion above.

However, Kishon pointed out that it didn't work. That's because, there
are phy provider drivers that enables runtime PM *after* calling
phy_create(). And in those cases, that is because they want to treat
runtime PM themselves.

I think that's probably something we should look into to change, but I
find it being a separate issue, that I didn't want to investigate as
part of this series.

See more about the thread here:
https://www.spinics.net/lists/linux-renesas-soc/msg21711.html

> [On a related note, I'm not sure why phy tries to intercept runtime PM
> errors and "fix up" the reference counters.  That doesn't look right
> to me at all.]
>
> That said, the current phy code is not strictly invalid.  While it
> looks more complicated than necessary, it doesn't do things documented
> as invalid in principle, so saying "The behaviour around the runtime
> PM deployment cause some issues during system suspend" in the
> changelog is describing the problem from a very specific angle.
> Simply put, pm_runtime_force_suspend() and the current phy code cannot
> work together and so using them together is a bug.  None of them
> individually is at fault, but combining them is incorrect.
>
> Fortunately enough, the phy code can be modified so that it can be
> used with pm_runtime_force_suspend() without problems, but picturing
> it as "problematic", because it cannot do that today is not entirely
> fair IMO.

Right, this makes sense. Let me clarify this in the changelog.

Kind regards
Uffe
