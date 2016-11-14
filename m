From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PM / OPP: make _of_get_opp_desc_node a static function
Date: Mon, 14 Nov 2016 01:22:30 +0100
Message-ID: <2766734.vM5WhbhWxb@vostro.rjw.lan>
References: <1476945893-26998-1-git-send-email-yamada.masahiro@socionext.com> <20161020065904.GL11766@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161020065904.GL11766@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-pm@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>, linux-kernel@vger.kernel.org, Nishanth Menon <nm@ti.com>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Pavel Machek <pavel@ucw.cz>, Viresh Kumar <vireshk@kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thursday, October 20, 2016 12:29:04 PM Viresh Kumar wrote:
> On 20-10-16, 15:44, Masahiro Yamada wrote:
> > Since commit f47b72a15a96 ("PM / OPP: Move CONFIG_OF dependent code
> > in a separate file"), this function is defined and called only in
> > drivers/base/power/opp/of.c .
> > 
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > ---
> > 
> >  drivers/base/power/opp/of.c  | 2 +-
> >  drivers/base/power/opp/opp.h | 1 -
> >  2 files changed, 1 insertion(+), 2 deletions(-)
> > 
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied.

Thanks,
Rafael
