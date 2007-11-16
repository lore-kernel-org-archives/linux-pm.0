From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [patch] snd hda suspend latency: shorten codec read
Date: Fri, 16 Nov 2007 14:31:39 +0100
Message-ID: <200711161431.40784.rjw__40012.116256594$1195218974$gmane$org@sisk.pl>
References: <20071115181418.GA6603@ucw.cz> <20071116124319.GA21978@elte.hu>
	<20071116125824.GA28082@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20071116125824.GA28082@elte.hu>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ingo Molnar <mingo@elte.hu>
Cc: len.brown@intel.com, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, perex@perex.cz, Mark Lord <liml@rtr.ca>, Mark Lord <lkml@rtr.ca>, Thomas Gleixner <tglx@linutronix.de>, linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Friday, 16 of November 2007, Ingo Molnar wrote:
> 
> snd hda suspend latency goes down a second via the patch below.
> 
> 	Ingo
> 
> ------------->
> Subject: snd hda suspend latency: shorten codec read
> From: Ingo Molnar <mingo@elte.hu>
> 
> not sleeping for every codec read/write but doing a short udelay and
> a conditional reschedule has cut suspend+resume latency by about 1
> second on my T60.
> 
> Signed-off-by: Ingo Molnar <mingo@elte.hu>

Acked-by: Rafael J. Wysocki <rjw@sisk.pl>

> ---
>  sound/pci/hda/hda_intel.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> Index: linux/sound/pci/hda/hda_intel.c
> ===================================================================
> --- linux.orig/sound/pci/hda/hda_intel.c
> +++ linux/sound/pci/hda/hda_intel.c
> @@ -555,7 +555,8 @@ static unsigned int azx_rirb_get_respons
>  		}
>  		if (!chip->rirb.cmds)
>  			return chip->rirb.res; /* the last value */
> -		schedule_timeout_uninterruptible(1);
> +		udelay(10);
> +		cond_resched();
>  	} while (time_after_eq(timeout, jiffies));
>  
>  	if (chip->msi) {
> 
> 



-- 
"Premature optimization is the root of all evil." - Donald Knuth
