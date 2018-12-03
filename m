From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 2/5] OPP: Add dev_pm_opp_xlate_performance_state()
 helper
Date: Mon, 3 Dec 2018 12:12:20 +0530
Message-ID: <20181203064220.l5pxuyhljhnpeji6@vireshk-i7>
References: <cover.1543219386.git.viresh.kumar@linaro.org>
 <8bb37fb6120221ded6abb53e69c86620aade20f6.1543219386.git.viresh.kumar@linaro.org>
 <CAPDyKFo+P0oUoPuNCJV4eumn-cqrM5_LBOvY3qQ9qy_HY5Lt2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFo+P0oUoPuNCJV4eumn-cqrM5_LBOvY3qQ9qy_HY5Lt2g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Rajendra Nayak <rnayak@codeaurora.org>, Niklas Cassel <niklas.cassel@linaro.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 30-11-18, 09:45, Ulf Hansson wrote:
> On Mon, 26 Nov 2018 at 09:10, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > Introduce a new helper dev_pm_opp_xlate_performance_state() which will
> > be used to translate from pstate of a device to another one.
> 
> I don't get this, could you please elaborate?
> 
> >
> > Initially this will be used by genpd to find pstate of a master domain
> > using its sub-domain's pstate.
> 
> I assume pstate is the performance state of a genpd that you refer to,
> no? Please try to be a bit more descriptive in your changelogs, to
> avoid confusions.

Here is the new changelog:

    OPP: Add dev_pm_opp_xlate_performance_state() helper
    
    dev_pm_genpd_set_performance_state() needs to handle performance state
    propagation going forward. Currently this routine only gets the required
    performance state of the device's genpd as an argument, but it doesn't
    know how to translate that to master genpd(s) of the device's genpd.
    
    Introduce a new helper dev_pm_opp_xlate_performance_state() which will
    be used to translate from performance state of a device (or genpd
    sub-domain) to another device (or master genpd).
    
    Normally the src_table (of genpd sub-domain) will have the
    "required_opps" property set to point to one of the OPPs in the
    dst_table (of master genpd), but in some cases the genpd and its master
    have one to one mapping of performance states and so none of them have
    the "required-opps" property set. Return the performance state of the
    src_table as it is in such cases.
    
    Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>



Hope this looks fine ?

-- 
viresh
