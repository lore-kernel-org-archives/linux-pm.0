From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH 00/15] PM / Domains: Cleanups and remove superfluous APIs
Date: Fri, 05 Sep 2014 08:35:56 -0700
Message-ID: <7ha96eyt9f.fsf@paris.lan>
References: <1409741551-16437-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1409741551-16437-1-git-send-email-ulf.hansson@linaro.org> (Ulf
	Hansson's message of "Wed, 3 Sep 2014 12:52:16 +0200")
Sender: linux-sh-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, Daniel Lezcano <daniel.lezcano@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Stephen Boyd <sboyd@codeaurora.org>, Philipp Zabel <philipp.zabel@gmail.com>, Mark Brown <broonie@kernel.org>
List-Id: linux-pm@vger.kernel.org

Ulf Hansson <ulf.hansson@linaro.org> writes:

> This patchset has a bit of a history and some parts of it has been posted
> earlier.
> http://lists.infradead.org/pipermail/linux-arm-kernel/2014-June/262725.html
>
> The intent is to simplify code for the generic power domain and also some of
> the machine specific code that uses the generic power domain.
>
> Do note, there are dependencies through this patchset, especially related to
> the ARM SoC changes, thus they all need to be kept together.

Reviewed-by: Kevin Hilman <khilman@linaro.org>

