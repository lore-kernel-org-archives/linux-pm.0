From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATH] i915: Read outside array bounds
Date: Wed, 29 Jul 2009 23:06:14 +0200
Message-ID: <200907292306.15195.rjw__33014.0569633388$1248901825$gmane$org@sisk.pl>
References: <4A6B8C3E.7060501@gmail.com>
	<20090728145003.be5399d1.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090728145003.be5399d1.akpm@linux-foundation.org>
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
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: airlied@linux.ie, linux-pm@lists.linux-foundation.org, dri-devel@lists.sourceforge.net, Roel Kluin <roel.kluin@gmail.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday 28 July 2009, Andrew Morton wrote:
> (cc jbarnes)
> 
> On Sun, 26 Jul 2009 00:50:38 +0200
> Roel Kluin <roel.kluin@gmail.com> wrote:
> 
> > dev_priv->saveSWF1 is a 16 element array, but this reads up to index 22
> > 
> > Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
> > ---
> > save_state does not do this addition, can it be removed? please review.
> > 
> > diff --git a/drivers/gpu/drm/i915/i915_suspend.c b/drivers/gpu/drm/i915/i915_suspend.c
> > index 9e1d16e..1d04e19 100644
> > --- a/drivers/gpu/drm/i915/i915_suspend.c
> > +++ b/drivers/gpu/drm/i915/i915_suspend.c
> > @@ -598,7 +598,7 @@ int i915_restore_state(struct drm_device *dev)
> >  
> >  	for (i = 0; i < 16; i++) {
> >  		I915_WRITE(SWF00 + (i << 2), dev_priv->saveSWF0[i]);
> > -		I915_WRITE(SWF10 + (i << 2), dev_priv->saveSWF1[i+7]);
> > +		I915_WRITE(SWF10 + (i << 2), dev_priv->saveSWF1[i]);
> >  	}
> >  	for (i = 0; i < 3; i++)
> >  		I915_WRITE(SWF30 + (i << 2), dev_priv->saveSWF2[i]);
> 
> This looks rather correct and the original code looked rather wrong.
> 
> Someone please tell me that this might fix one of our splendid number
> of i915 bugs :(

Hmm, Jesse, what's your opinion about this one?  It looks correct to me.

Rafael
