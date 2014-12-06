From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH] sound / PM: Replace CONFIG_PM_RUNTIME with
	CONFIG_PM
Date: Sat, 6 Dec 2014 01:50:46 -0800
Message-ID: <20141206095045.GA2624@Asurada>
References: <2064254.7lXiTpmK64@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <2064254.7lXiTpmK64@vostro.rjw.lan>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Brian Austin <brian.austin@cirrus.com>, alsa-devel@alsa-project.org, Kukjin Kim <kgene.kim@samsung.com>, Timur Tabi <timur@tabi.org>, Linux PM list <linux-pm@vger.kernel.org>, Takashi Iwai <tiwai@suse.de>, Xiubo Li <Li.Xiubo@freescale.com>, Liam Girdwood <lgirdwood@gmail.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>, Mark Brown <broonie@kernel.org>, Ben Dooks <ben-linux@fluff.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sat, Dec 06, 2014 at 03:46:27AM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> After commit b2b49ccbdd54 (PM: Kconfig: Set PM_RUNTIME if PM_SLEEP is
> selected) PM_RUNTIME is always set if PM is set, so #ifdef blocks
> depending on CONFIG_PM_RUNTIME may now be changed to depend on
> CONFIG_PM.
> 
> Replace CONFIG_PM_RUNTIME with CONFIG_PM everywhere under sound/.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> Note: This depends on commit b2b49ccbdd54 (PM: Kconfig: Set PM_RUNTIME if
> PM_SLEEP is selected) which is only in linux-next at the moment (via the
> linux-pm tree).
> 
> Please let me know if it is OK to take this one into linux-pm.
> 
> ---
>  sound/pci/hda/hda_controller.c |    2 +-
>  sound/pci/hda/hda_intel.c      |    5 +----
>  sound/soc/codecs/cs35l32.c     |    2 +-
>  sound/soc/codecs/cs42xx8.c     |    2 +-
>  sound/soc/codecs/max98090.c    |    2 +-
>  sound/soc/codecs/pcm512x.c     |    2 +-
>  sound/soc/codecs/tas2552.c     |    4 ++--
>  sound/soc/codecs/wm2200.c      |    2 +-
>  sound/soc/codecs/wm5100.c      |    2 +-
>  sound/soc/codecs/wm8962.c      |    2 +-
>  sound/soc/fsl/fsl_asrc.c       |    4 ++--
>  sound/soc/samsung/i2s.c        |    4 ++--
>  12 files changed, 15 insertions(+), 18 deletions(-)

For cs42xx8.c and fsl_asrc.c

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

Thank you
Nic
