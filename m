From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 3/3] pm_qos: get rid of the allocation in
	pm_qos_add_request()
Date: Mon, 5 Jul 2010 23:07:07 +0200
Message-ID: <201007052307.07655.rjw__19281.5311173492$1278364170$gmane$org@sisk.pl>
References: <1277746434.10879.191.camel@mulgrave.site>
	<s5hvd8ubfcz.wl%tiwai@suse.de>
	<1278338568.2850.1.camel@mulgrave.site>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1278338568.2850.1.camel@mulgrave.site>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
Cc: Takashi Iwai <tiwai@suse.de>, netdev@vger.kernel.org, James Bottomley <James.Bottomley@suse.de>, markgross@thegnar.org
List-Id: linux-pm@vger.kernel.org

On Monday, July 05, 2010, James Bottomley wrote:
> On Mon, 2010-07-05 at 08:41 +0200, Takashi Iwai wrote:
> > sorry for the late reply, as I've been on vacation in the last week
> > (and shut off mails intentionally :)
> 
> Envy forbids me from saying that's OK.
> 
> > At Mon, 28 Jun 2010 12:44:48 -0500,
> > James Bottomley wrote:
> > > 
> > > Since every caller has to squirrel away the returned pointer anyway,
> > > they might as well supply the memory area.  This fixes a bug in a few of
> > > the call sites where the returned pointer was dereferenced without
> > > checking it for NULL (which gets returned if the kzalloc failed).
> > > 
> > > I'd like to hear how sound and netdev feels about this: it will add
> > > about two more pointers worth of data to struct netdev and struct
> > > snd_pcm_substream .. but I think it's worth it.  If you're OK, I'll add
> > > your acks and send through the pm tree.
> > > 
> > > This also looks to me like an android independent clean up (even though
> > > it renders the request_add atomically callable).  I also added include
> > > guards to include/linux/pm_qos_params.h
> > 
> > I like the patch very well, too.
> > But, just wondering...
> > 
> > > @@ -262,6 +260,11 @@ void pm_qos_update_request(struct pm_qos_request_list *pm_qos_req,
> > >  	if (!pm_qos_req) /*guard against callers passing in null */
> > >  		return;
> > >  
> > > +	if (pm_qos_request_active(pm_qos_req)) {
> > > +		WARN(1, KERN_ERR "pm_qos_update_request() called for unknown object\n");
> > > +		return;
> > > +	}
> > > +
> > 
> > Is this correct...?  Shouldn't it be a negative check?
> 
> Yes, it should be a negative check ... I'll update the patch.

I've already fixed it in my tree.

> I guess this still means that no-one has managed to test it on a functional
> system ...

Well, it's been for a while in linux-next ...

Rafael
