From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PM / OPP: fix incorrect OPP count handling in of_init_opp_table
Date: Sat, 17 May 2014 01:03:32 +0200
Message-ID: <200048151.0RTJzuPcGp@vostro.rjw.lan>
References: <1400237477-24831-1-git-send-email-chander.kashyap@linaro.org> <CAKohpomYMcisB-UHp7TOEdxvQ9-1VzyRshQh=P-dQqYOuBz-5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAKohpomYMcisB-UHp7TOEdxvQ9-1VzyRshQh=P-dQqYOuBz-5g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Chander Kashyap <chander.kashyap@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Nishanth Menon <nm@ti.com>, Pavel Machek <pavel@ucw.cz>, "Brown, Len" <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Chander Kashyap <k.chander@samsung.com>, Inderpal Singh <inderpal.s@samsung.com>
List-Id: linux-pm@vger.kernel.org

On Friday, May 16, 2014 04:43:31 PM Viresh Kumar wrote:
> On 16 May 2014 16:21, Chander Kashyap <chander.kashyap@linaro.org> wrote:
> > In of_init_opp_table function, if a failure to add an OPP is
> > detected, the count of OPPs, yet to be added is not updated.
> > Fix this by decrementing this count on failure as well.
> >
> > Signed-off-by: Chander Kashyap <k.chander@samsung.com>
> > Signed-off-by: Inderpal Singh <inderpal.s@samsung.com>
> > ---
> >  drivers/base/power/opp.c |    4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Is this -stable material?  If so, which -stable?

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
