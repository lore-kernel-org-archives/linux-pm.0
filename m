From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v11 8/8] interconnect: sdm845: Fix build failure after
 cmd_db API change
Date: Fri, 7 Dec 2018 13:29:43 -0800
Message-ID: <CAD=FV=VxgeTw5KMY75h487WMGuJxAHCbXMoSm00LBqSh_PdTYA@mail.gmail.com>
References: <20181207152917.4862-1-georgi.djakov@linaro.org>
 <20181207152917.4862-9-georgi.djakov@linaro.org>
 <20181207162733.pdd62qvqzd6xk4nr@queper01-lin>
 <fb5d11cd-6729-5521-c828-9bfeedba9ce0@linaro.org>
 <20181207171437.qmtacurmqg53zzkl@queper01-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20181207171437.qmtacurmqg53zzkl@queper01-lin>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: quentin.perret@arm.com
Cc: Mark Rutland <mark.rutland@arm.com>, sanjayc@nvidia.com, maxime.ripard@bootlin.com, Michael Turquette <mturquette@baylibre.com>, daidavid1@codeaurora.org, Bjorn Andersson <bjorn.andersson@linaro.org>, Saravana Kannan <skannan@codeaurora.org>, abailon@baylibre.com, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, seansw@qti.qualcomm.com, Kevin Hilman <khilman@baylibre.com>, Evan Green <evgreen@chromium.org>, ksitaraman@nvidia.com, devicetree@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-pm@vger.kernel.org, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Andy Gross <andy.gross@linaro.org>, Rob Herring <robh+dt@kernel.org>, linux-tegra@vger.kernel.org, Linux ARM <linux-arm-kernel@lists.infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi,

On Fri, Dec 7, 2018 at 9:14 AM Quentin Perret <quentin.perret@arm.com> wrote:
>
> On Friday 07 Dec 2018 at 18:47:22 (+0200), Georgi Djakov wrote:
> > Hi Quentin,
> >
> > On 12/7/18 18:27, Quentin Perret wrote:
> > > Hi Georgi,
> > >
> > > On Friday 07 Dec 2018 at 17:29:17 (+0200), Georgi Djakov wrote:
> > >> Recently the cmd_db_read_aux_data() function was changed to avoid using
> > >> memcpy and return a pointer instead. Update the code to the new API and
> > >> fix the build failure.
> > >>
> > >> Fixes: ed3cafa79ea7 ("soc: qcom: cmd-db: Stop memcpy()ing in cmd_db_read_aux_data()")
> > >> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> > >> ---
> > >>  drivers/interconnect/qcom/sdm845.c | 26 ++++++++++++++------------
> > >
> > > IIUC this file is introduced by patch 5. Should the fix be squashed
> > > into patch 5 directly ? Just to keep things bisectable.
> >
> > The reason why i have split it as a separate change is because as a
> > separate change it would be easier to review & test for the people who
> > are already familiar with the rest of the series.
> >
> > Another minor reason is that a separate patch will also make the life a
> > bit easier for some people who are back-porting this to kernels using
> > the older version of the cmd_db API.
> >
> > The commit that changed the cmd_db API is not yet in mainline, but in
> > linux-next. I am not sure what is preferred in this case?
>
> Not sure either but I guess that will depend who gets merged first ...
> If that's the cmd_db change, then you'll need to squash your fix in
> patch 5. If your series goes first, then the fix needs to be applied to
> the cmb_db change.
>
> I personally don't mind either way as long as we don't break bisection :-)

My $0.02 is that anyone downstream picking this will also be picking
the cmd db change, so I'd suggest squashing as suggested by Quentin.
Maybe you can do that and post a v12?  Since it sounded like Greg was
about ready to land [1] maybe we shouldn't wait too long till doing
it?

...unfortunately I guess we need to figure out how this will actually
land.  Greg can't pick the series up directly since it won't compile
without the cmd-db change.  ...so we need to do one of the following:

1. Feed it through a tree that goes through arm-soc (Andy's tree or
arm-soc directly) so you'll have commit ed3cafa79ea7 ("soc: qcom:
cmd-db: Stop memcpy()ing in cmd_db_read_aux_data()").

2. Greg could also merge in Andy's pull request
(https://patchwork.kernel.org/patch/10710447/), but you'll get some
unrelated patches too.

3. Wait until next year and we have the next -rc1 to get this merged.

...it seems like #1 would be the least painful option, but obviously
others would have to be OK w/ it.


[1] https://lkml.kernel.org/r/20181206145547.GA7884@kroah.com


-Doug
