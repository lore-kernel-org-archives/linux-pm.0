From: mark gross <mgross@linux.intel.com>
Subject: Re:
	[PATCH]PM_QOS-to-use-handle-based-requests-pcm-update 5/5
Date: Wed, 2 Dec 2009 13:50:08 -0800
Message-ID: <20091202215008.GA6340__15842.5562004142$1259791337$gmane$org@linux.intel.com>
References: <20091201213840.GE19688@linux.intel.com>
	<s5hiqcpy5b4.wl%tiwai@suse.de>
Reply-To: mgross@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <s5hiqcpy5b4.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-pm <linux-pm@lists.linux-foundation.org>, lkml <linux-kernel@vger.kernel.org>, alsa-devel@alsa-project.org, perex@perex.cz
List-Id: linux-pm@vger.kernel.org

On Wed, Dec 02, 2009 at 12:38:07PM +0100, Takashi Iwai wrote:
> At Tue, 1 Dec 2009 13:38:40 -0800,
> mark gross wrote:
> > 
> > --- a/sound/core/pcm_native.c
> > +++ b/sound/core/pcm_native.c
> (snip)
> > @@ -506,8 +508,8 @@ static int snd_pcm_hw_free(struct snd_pcm_substream *substream)
> >  	if (substream->ops->hw_free)
> >  		result = substream->ops->hw_free(substream);
> >  	runtime->status->state = SNDRV_PCM_STATE_OPEN;
> > -	pm_qos_remove_requirement(PM_QOS_CPU_DMA_LATENCY,
> > -		substream->latency_id);
> > +	pm_qos_remove_request(substream->latency_pm_qos_req);
> 
> The NULL check seems needed in the caller side because
> pm_qos_remove_request() doesn't do it.

ouch.  Thanks for noticing this.

> 
> Or, would you add a NULL check in pm_qos_remove_request()?
> It'd be more handy.

I can make the pm_qos_remove_request null pointer safe, its assumed to
be a slow path so it would be a good thing to do.


I'll add this to the next patch set that the e1000e guys are making me
do against linux-next.

Thanks!

--mgross

> 
> 
> thanks,
> 
> Takashi
