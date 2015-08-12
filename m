From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: linux-next: build failure after merge of the clk tree
Date: Wed, 12 Aug 2015 01:23:13 -0700
Message-ID: <20150812082313.GM26614@codeaurora.org>
References: <20150812171912.03110efc@canb.auug.org.au>
 <CAMuHMdUQEVbyhnOBBgjKqBoFNc9FSCU68uoLg0XNWMFFxWAOdQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdUQEVbyhnOBBgjKqBoFNc9FSCU68uoLg0XNWMFFxWAOdQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Mike Turquette <mturquette@baylibre.com>, Linux-Next <linux-next@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Rajendra Nayak <rnayak@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

On 08/12, Geert Uytterhoeven wrote:
> On Wed, Aug 12, 2015 at 9:19 AM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > After merging the clk tree, today's linux-next build (x86_64 allmodconfig)
> > failed like this:
> >
> > ERROR: "pm_genpd_init" [drivers/clk/qcom/clk-qcom.ko] undefined!
> >
> > Caused by commit
> >
> >   0c4172846b0b ("clk: qcom: Add support for GDSCs")
> >
> > I have used the clk tree from next-20150810 for today.
> 
> Missing EXPORT_SYMBOL_GPL(pm_genpd_init)?
> 
> However, having modular PM Domain drivers may cause unpleasant surprises...
> 

Curious what sort of surprises those would be? I suppose
something like power domains being removed from the system would
need some more work to start failing the suspend/resume of
devices in the power domains or possibly unbind the drivers that
are using the power domains provided. And we probably need to
sprinkle some try_module_get()/module_put() too so that the
module isn't easily removed if it's in use by some other drivers.

I hope it's not something that we think is impossible to do
though because we've been able to support the clk driver as
entirely modular on qcom platforms and I'd like to keep it that
way. BTW, it seems that we export __of_genpd_add_provider() so
there's at least some precedence for modular genpd code, albeit a
small one.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
