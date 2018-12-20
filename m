From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RESEND] PM / Domains: remove define_genpd_open_function() and define_genpd_debugfs_fops()
Date: Thu, 20 Dec 2018 22:13:33 +0100
Message-ID: <3394539.b4fEdePmXH@aspire.rjw.lan>
References: <20181215084526.27210-1-tiny.windzz@gmail.com> <CAJZ5v0hW_SFsQ-oGaHUtxTEXTdNRkDjp4ZpS_MxEp9-jTYvoew@mail.gmail.com> <CAPDyKFpZkmVOCOdkcOuF_4nGcy-mwW8BdYeE7CBR2eJH5Qn0cg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFpZkmVOCOdkcOuF_4nGcy-mwW8BdYeE7CBR2eJH5Qn0cg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Yangtao Li <tiny.windzz@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kevin Hilman <khilman@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday, December 19, 2018 10:20:22 AM CET Ulf Hansson wrote:
> On Wed, 19 Dec 2018 at 10:17, Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Wed, Dec 19, 2018 at 9:32 AM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Mon, Dec 17, 2018 at 09:19:07AM +0100, Ulf Hansson wrote:
> > > > On Sat, 15 Dec 2018 at 09:45, Yangtao Li <tiny.windzz@gmail.com> wrote:
> > > > >
> > > > > We already have the DEFINE_SHOW_ATTRIBUTE, There is no need to define
> > > > > such a macro, so remove define_genpd_open_function and
> > > > > define_genpd_debugfs_fops.
> > > > >
> > > > > Convert them to DEFINE_SHOW_ATTRIBUTE.
> > > > >
> > > > > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > > > > ---
> > > > >  drivers/base/power/domain.c | 71 +++++++++++++------------------------
> > > > >  1 file changed, 24 insertions(+), 47 deletions(-)
> > > > >
> > > > > diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> > > > > index 7f38a92b444a..10a61d6147d0 100644
> > > > > --- a/drivers/base/power/domain.c
> > > > > +++ b/drivers/base/power/domain.c
> > > > > @@ -2671,7 +2671,7 @@ static int genpd_summary_one(struct seq_file *s,
> > > > >         return 0;
> > > > >  }
> > > > >
> > > > > -static int genpd_summary_show(struct seq_file *s, void *data)
> > > > > +static int summary_show(struct seq_file *s, void *data)
> > > >
> > > > Why rename the function(s)?
> > >
> > > Because the macro requires it?
> >
> > Yeah.
> >
> > Ulf, this looks like a good cleanup to me, any objections to this one
> > given the explanation above?
> 
> It looks good to me, I just didn't go into the details of how the
> macro works. Now I know, so please add:
> 
> Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

So the patch has been applied, thanks!
