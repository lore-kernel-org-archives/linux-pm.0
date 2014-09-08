From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 00/15] PM / Domains: Cleanups and remove superfluous APIs
Date: Tue, 09 Sep 2014 01:07:14 +0200
Message-ID: <2208348.uMLR68bVng@vostro.rjw.lan>
References: <1409741551-16437-1-git-send-email-ulf.hansson@linaro.org> <7ha96eyt9f.fsf@paris.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <7ha96eyt9f.fsf@paris.lan>
Sender: linux-sh-owner@vger.kernel.org
To: Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, Daniel Lezcano <daniel.lezcano@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Stephen Boyd <sboyd@codeaurora.org>, Philipp Zabel <philipp.zabel@gmail.com>, Mark Brown <broonie@kernel.org>
List-Id: linux-pm@vger.kernel.org

On Friday, September 05, 2014 08:35:56 AM Kevin Hilman wrote:
> Ulf Hansson <ulf.hansson@linaro.org> writes:
> 
> > This patchset has a bit of a history and some parts of it has been posted
> > earlier.
> > http://lists.infradead.org/pipermail/linux-arm-kernel/2014-June/262725.html
> >
> > The intent is to simplify code for the generic power domain and also some of
> > the machine specific code that uses the generic power domain.
> >
> > Do note, there are dependencies through this patchset, especially related to
> > the ARM SoC changes, thus they all need to be kept together.
> 
> Reviewed-by: Kevin Hilman <khilman@linaro.org>

My understanding is that this is for the whole series.

Which I'm queuing up for 3.18, thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
