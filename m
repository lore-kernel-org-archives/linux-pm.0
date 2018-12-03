From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 3/5] PM / Domains: Save OPP table pointer in genpd
Date: Mon, 3 Dec 2018 12:27:11 +0530
Message-ID: <20181203065711.lugbr3a7uqtasmli@vireshk-i7>
References: <cover.1543219386.git.viresh.kumar@linaro.org>
 <f95b514f7b3b3ab6ac00c9871e91513c9c3a09a3.1543219386.git.viresh.kumar@linaro.org>
 <CAPDyKFrUBwagtfwCezqw2ujPBVVtQNqz4rKgAG0Yyy18FZv+wA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFrUBwagtfwCezqw2ujPBVVtQNqz4rKgAG0Yyy18FZv+wA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Vincent Guittot <vincent.guittot@linaro.org>, Rajendra Nayak <rnayak@codeaurora.org>, Niklas Cassel <niklas.cassel@linaro.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 30-11-18, 09:53, Ulf Hansson wrote:
> On Mon, 26 Nov 2018 at 09:10, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > We will need these going forward in hotpath, i.e. from within
> > dev_pm_genpd_set_performance_state().
> 
> Well, as for patch2, please try to be a bit more descriptive of why
> and what this patch does.

    PM / Domains: Save OPP table pointer in genpd
    
    dev_pm_genpd_set_performance_state() will be required to call
    dev_pm_opp_xlate_performance_state() going forward to translate from
    performance state of a sub-domain to performance state of its master.
    And dev_pm_opp_xlate_performance_state() needs pointers to the OPP
    tables of both genpd and its master.
    
    Lets fetch and save them while the OPP tables are added. Fetching the
    OPP tables should never fail as we just added the OPP tables and so add
    a WARN_ON() for such a bug instead of full error paths.
    
    Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>


Good enough ?

-- 
viresh
