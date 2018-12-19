From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [RESEND] PM / Domains: remove define_genpd_open_function() and define_genpd_debugfs_fops()
Date: Wed, 19 Dec 2018 10:17:38 +0100
Message-ID: <CAJZ5v0hW_SFsQ-oGaHUtxTEXTdNRkDjp4ZpS_MxEp9-jTYvoew@mail.gmail.com>
References: <20181215084526.27210-1-tiny.windzz@gmail.com> <CAPDyKFq5oxDc1drn-0Tj-aBJCPCXcd_AO0q=56s9sumgiY4Dpg@mail.gmail.com>
 <20181219083223.GC31670@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181219083223.GC31670@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: tiny.windzz@gmail.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Dec 19, 2018 at 9:32 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Dec 17, 2018 at 09:19:07AM +0100, Ulf Hansson wrote:
> > On Sat, 15 Dec 2018 at 09:45, Yangtao Li <tiny.windzz@gmail.com> wrote:
> > >
> > > We already have the DEFINE_SHOW_ATTRIBUTE, There is no need to define
> > > such a macro, so remove define_genpd_open_function and
> > > define_genpd_debugfs_fops.
> > >
> > > Convert them to DEFINE_SHOW_ATTRIBUTE.
> > >
> > > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > > ---
> > >  drivers/base/power/domain.c | 71 +++++++++++++------------------------
> > >  1 file changed, 24 insertions(+), 47 deletions(-)
> > >
> > > diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> > > index 7f38a92b444a..10a61d6147d0 100644
> > > --- a/drivers/base/power/domain.c
> > > +++ b/drivers/base/power/domain.c
> > > @@ -2671,7 +2671,7 @@ static int genpd_summary_one(struct seq_file *s,
> > >         return 0;
> > >  }
> > >
> > > -static int genpd_summary_show(struct seq_file *s, void *data)
> > > +static int summary_show(struct seq_file *s, void *data)
> >
> > Why rename the function(s)?
>
> Because the macro requires it?

Yeah.

Ulf, this looks like a good cleanup to me, any objections to this one
given the explanation above?
