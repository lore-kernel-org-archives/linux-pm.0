From: Peter De Schrijver <pdeschrijver@nvidia.com>
Subject: Re: [PATCH v7 05/16] clk: tegra: Add DFLL DVCO reset control for
 Tegra124
Date: Mon, 16 Feb 2015 11:40:01 +0200
Message-ID: <20150216094000.GD19839@tbergstrom-lnx.Nvidia.com>
References: <1420723339-30735-1-git-send-email-mikko.perttunen@kapsi.fi>
 <1420723339-30735-6-git-send-email-mikko.perttunen@kapsi.fi>
 <20150212141944.GK20811@tbergstrom-lnx.Nvidia.com>
 <54DDD447.8000404@kapsi.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <54DDD447.8000404@kapsi.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: Mikko Perttunen <mikko.perttunen@kapsi.fi>
Cc: swarren@wwwdotorg.org, thierry.reding@gmail.com, gnurou@gmail.com, rjw@rjwysocki.net, viresh.kumar@linaro.org, mturquette@linaro.org, pwalmsley@nvidia.com, vinceh@nvidia.com, pgaikwad@nvidia.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tuomas.tynkkynen@iki.fi, Tuomas Tynkkynen <ttynkkynen@nvidia.com>
List-Id: linux-pm@vger.kernel.org

On Fri, Feb 13, 2015 at 12:39:03PM +0200, Mikko Perttunen wrote:
> On 02/12/2015 04:19 PM, Peter De Schrijver wrote:
> >On Thu, Jan 08, 2015 at 03:22:08PM +0200, Mikko Perttunen wrote:
> >>From: Paul Walmsley <pwalmsley@nvidia.com>
> >>
> >>The DVCO present in the DFLL IP block has a separate reset line,
> >>exposed via the CAR IP block.  This reset line is asserted upon SoC
> >>reset.  Unless something (such as the DFLL driver) deasserts this
> >>line, the DVCO will not oscillate, although reads and writes to the
> >>DFLL IP block will complete.
> >>
> >>Thanks to Aleksandr Frid <afrid@nvidia.com> for identifying this and
> >>saving hours of debugging time.
> >>
> >
> >Should this be done as a reset driver?
> 
> Probably through the already existing CAR reset driver. This reset
> doesn't fit well with the existing numbering scheme there, though.
> Perhaps a magic high-valued constant that represents it.
> 

Indeed. Just like only the lower part of the clock IDs map have a realtion
with the hardware registers. The rest is just arbitrary numbers.

Cheers,

Peter.
