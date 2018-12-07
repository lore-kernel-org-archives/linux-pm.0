From: Quentin Perret <quentin.perret@arm.com>
Subject: Re: [PATCH v11 8/8] interconnect: sdm845: Fix build failure after
 cmd_db API change
Date: Fri, 7 Dec 2018 17:14:40 +0000
Message-ID: <20181207171437.qmtacurmqg53zzkl@queper01-lin>
References: <20181207152917.4862-1-georgi.djakov@linaro.org>
 <20181207152917.4862-9-georgi.djakov@linaro.org>
 <20181207162733.pdd62qvqzd6xk4nr@queper01-lin>
 <fb5d11cd-6729-5521-c828-9bfeedba9ce0@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <fb5d11cd-6729-5521-c828-9bfeedba9ce0@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Georgi Djakov <georgi.djakov@linaro.org>
Cc: gregkh@linuxfoundation.org, linux-pm@vger.kernel.org, rjw@rjwysocki.net, robh+dt@kernel.org, mturquette@baylibre.com, khilman@baylibre.com, vincent.guittot@linaro.org, skannan@codeaurora.org, bjorn.andersson@linaro.org, amit.kucheria@linaro.org, seansw@qti.qualcomm.com, daidavid1@codeaurora.org, evgreen@chromium.org, dianders@chromium.org, mark.rutland@arm.com, lorenzo.pieralisi@arm.com, abailon@baylibre.com, maxime.ripard@bootlin.com, arnd@arndb.de, thierry.reding@gmail.com, ksitaraman@nvidia.com, sanjayc@nvidia.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-tegra@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Friday 07 Dec 2018 at 18:47:22 (+0200), Georgi Djakov wrote:
> Hi Quentin,
> 
> On 12/7/18 18:27, Quentin Perret wrote:
> > Hi Georgi,
> > 
> > On Friday 07 Dec 2018 at 17:29:17 (+0200), Georgi Djakov wrote:
> >> Recently the cmd_db_read_aux_data() function was changed to avoid using
> >> memcpy and return a pointer instead. Update the code to the new API and
> >> fix the build failure.
> >>
> >> Fixes: ed3cafa79ea7 ("soc: qcom: cmd-db: Stop memcpy()ing in cmd_db_read_aux_data()")
> >> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> >> ---
> >>  drivers/interconnect/qcom/sdm845.c | 26 ++++++++++++++------------
> > 
> > IIUC this file is introduced by patch 5. Should the fix be squashed
> > into patch 5 directly ? Just to keep things bisectable.
> 
> The reason why i have split it as a separate change is because as a
> separate change it would be easier to review & test for the people who
> are already familiar with the rest of the series.
> 
> Another minor reason is that a separate patch will also make the life a
> bit easier for some people who are back-porting this to kernels using
> the older version of the cmd_db API.
> 
> The commit that changed the cmd_db API is not yet in mainline, but in
> linux-next. I am not sure what is preferred in this case?

Not sure either but I guess that will depend who gets merged first ...
If that's the cmd_db change, then you'll need to squash your fix in
patch 5. If your series goes first, then the fix needs to be applied to
the cmb_db change.

I personally don't mind either way as long as we don't break bisection :-)

Thanks,
Quentin
