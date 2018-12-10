From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3] cpuidle: big.LITTLE: add of_node_put()
Date: Mon, 10 Dec 2018 12:31:37 +0100
Message-ID: <3143453.Hr4lRPQaf4@aspire.rjw.lan>
References: <20181120161451.21149-1-tiny.windzz@gmail.com> <CAEExFWtiqTgQmMLwvMhx8UvfU9o75jsZkAjBgyHhAOwuemJdNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAEExFWtiqTgQmMLwvMhx8UvfU9o75jsZkAjBgyHhAOwuemJdNw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Frank Lee <tiny.windzz@gmail.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, lorenzo.pieralisi@arm.com, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Sunday, December 9, 2018 7:20:26 AM CET Frank Lee wrote:
> On Wed, Nov 21, 2018 at 12:14 AM Yangtao Li <tiny.windzz@gmail.com> wrote:
> >
> > of_find_node_by_path() acquires a reference to the node
> > returned by it and that reference needs to be dropped by its caller.
> > bl_idle_init() doesn't do that, so fix it.
> >
> > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > ---
> > Changes in v3:
> > -update changelog
> > ---
> >  drivers/cpuidle/cpuidle-big_little.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/cpuidle/cpuidle-big_little.c b/drivers/cpuidle/cpuidle-big_little.c
> > index db2ede565f1a..650f063ef809 100644
> > --- a/drivers/cpuidle/cpuidle-big_little.c
> > +++ b/drivers/cpuidle/cpuidle-big_little.c
> > @@ -174,8 +174,12 @@ static int __init bl_idle_init(void)
> >         /*
> >          * Initialize the driver just for a compliant set of machines
> >          */
> > -       if (!of_match_node(compatible_machine_match, root))
> > +       if (!of_match_node(compatible_machine_match, root)){
> > +               of_node_put(root);
> >                 return -ENODEV;
> > +       }
> > +
> > +       of_node_put(root);
> >
> >         if (!mcpm_is_available())
> >                 return -EUNATCH;
> > --
> > 2.17.0
> >
> ping......

I've been waiting for the maintainers of this driver to speak up.

I'll pick up the patch later today or tomorrow unless there are objections.

Thanks,
Rafael
