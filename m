From: Anshuman Gupta <anshuman.gupta@intel.com>
Subject: Re: [PATCH] [sound] hdac-codec runtime suspended at
	PM:Suspend.
Date: Wed, 14 Mar 2018 16:08:16 +0530
Message-ID: <37904.6940747232$1521023864@news.gmane.org>
References: <1520853467-31653-1-git-send-email-anshuman.gupta@intel.com>
 <CAJZ5v0hyk=jto8Wt0er==YmKEsgvfvZhO2wDbGOhxZaWWCNgBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hyk=jto8Wt0er==YmKEsgvfvZhO2wDbGOhxZaWWCNgBg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Mar 12, 2018 at 12:26:53PM +0100, Rafael J. Wysocki wrote:
> On Mon, Mar 12, 2018 at 12:17 PM, Anshuman Gupta
> <anshuman.gupta@intel.com> wrote:
> > Keep hdac-codec to be in runtime suspended while entering to suspend.
> > If hdac-codec is already in runtime suspend state skip its power down
> > sequence in prepare, power up sequence in complete phase.
> >
> > Avoid resuming hdac controller PCI device 00:1f.3 from runtime suspend
> > state in case  hdac-codec already in runtime-suspend state, this is
> > unnecessary and block the direct complete even for hdac controller
> > PCI device 00:1f.3.
> >
> > This enabled direct complete path for hdac-codec and PCI device 00:1f.3.
> >
> > Signed-off-by: Anshuman Gupta <anshuman.gupta@intel.com>
> > ---
> >  sound/soc/codecs/hdac_hdmi.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
> > index f3b4f4d..810a8a6 100644
> > --- a/sound/soc/codecs/hdac_hdmi.c
> > +++ b/sound/soc/codecs/hdac_hdmi.c
> > @@ -1852,6 +1852,8 @@ static int hdmi_codec_prepare(struct device *dev)
> >         struct hdac_ext_device *edev = to_hda_ext_device(dev);
> >         struct hdac_device *hdac = &edev->hdac;
> >
> > +       if (pm_runtime_status_suspended(dev))
> > +               return 1;
> 
> This is racy in principle, because the runtime PM status can still
> change after you've checked here.
  Will using pm_runtime_disable/pm_runtime_enable for safe check of runtime 
  status avoids this race?	
> 
> But even if it isn't racy in practice, the following
> pm_runtime_get_sync() becomes redundant after it, doesn't it?
  I have no idea but if there can be a case that PCI 00:1f.3 (hdac controller)
  is runtime suspended and hdac hdmi codec is active, in that case it may be 
  required to use pm_runtime_get_sync() for hdac controller as it is parent of
  hdac hdmi codec.			
> 
> >         pm_runtime_get_sync(&edev->hdac.dev);
> >
> >         /*
> > @@ -1873,6 +1875,8 @@ static void hdmi_codec_complete(struct device *dev)
> >         struct hdac_hdmi_priv *hdmi = edev->private_data;
> >         struct hdac_device *hdac = &edev->hdac;
> >
> > +       if (pm_runtime_status_suspended(dev))
> > +               return;
> 
> That, again, is somewhat fragile from the concurrency perspective.
> 
> >         /* Power up afg */
> >         snd_hdac_codec_read(hdac, hdac->afg, 0, AC_VERB_SET_POWER_STATE,
> >                                                         AC_PWRST_D0);
> > --
> > 2.7.4
> >

-- 
Thanks,
Anshuman
