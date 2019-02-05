From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2] ALSA: hda/tegra: enable clock during probe
Date: Tue, 05 Feb 2019 12:34:46 +0100
Message-ID: <4564414.Hi6AUZdI4M@aspire.rjw.lan>
References: <1548414418-5785-1-git-send-email-spujar@nvidia.com> <e7597220-2be7-ca29-50b7-c515c06cbed7@nvidia.com> <80a45aa3-8a22-959c-0c73-03ad2d6b1f8c@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <80a45aa3-8a22-959c-0c73-03ad2d6b1f8c@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Sameer Pujar <spujar@nvidia.com>, Thierry Reding <thierry.reding@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Takashi Iwai <tiwai@suse.de>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Jaroslav Kysela <perex@perex.cz>, "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, mkumard@nvidia.com, rlokhande@nvidia.com, sharadg@nvidia.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-tegra@vger.kernel.org, Linux PM <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Monday, February 4, 2019 11:04:50 AM CET Jon Hunter wrote:
> 
> On 04/02/2019 08:16, Sameer Pujar wrote:
> 
> ...
> 
> > Objective is to have things working with or without CONFIG_PM enabled.
> > From previous comments and discussions it appears that there is mixed
> > response
> > for calling hda_tegra_runtime_resume() or runtime PM APIs in probe()
> > call. Need
> > to have consensus regarding the best practice to be followed, which
> > would eventually
> > can be used in other drivers too.
> > 
> > Rafael is suggesting to use CONFIG_PM check to do manual setup or
> > runtime PM setup in probe,
> > which would bring back the earlier above mentioned concern.
> > 
> > if (IS_ENABLED(CONFIG_PM)) {
> > do setup based on pm-runtime
> > } else {
> >     do manual setup
> > }
> > Both if/else might end up doing the same here.
> > Do we really need CONFIG_PM check here?
> > 
> > Instead does below proposal appear fine?
> > 
> > probe() {
> >     hda_tegra_enable_clock();
> > }
> > 
> > probe_work() {
> >     /* hda setup */
> >     . . .
> >     pm_runtime_set_active(); /* initial state as active */
> >     pm_runtime_enable();
> >     return;
> > }
> 
> I believe that this still does not work, because if there is a
> power-domain that needs to be turned on, this does not guarantee this.
> So I think that you need to call pm_runtime_get ...
> 
>  probe() {
>  	if (!IS_ENABLED(CONFIG_PM))
>  		hda_tegra_enable_clock();
>  }
> 

But alas, there are no PM domains with CONFIG_PM unset.

CONFIG_PM unset means that the *driver* has to know how to turn on the
device and that has to be sufficient.

Which basically is my point when I'm saying that this information is
not available to the core and it cannot do anything to handle this
case without the extra knowledge.

Thanks,
Rafael
