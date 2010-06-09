From: James Bottomley <James.Bottomley@suse.de>
Subject: Re: [RFC] pm_qos: reimplement using plists
Date: Wed, 09 Jun 2010 10:03:07 -0400
Message-ID: <1276092187.4343.207.camel@mulgrave.site>
References: <1275760688.7227.10.camel@mulgrave.site>
	<20100606213954.GD8610@gvim.org>
	<1275879906.7227.582.camel@mulgrave.site>
	<20100609083809.0581fbc3@schatten.dmk.lab>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100609083809.0581fbc3@schatten.dmk.lab>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Florian Mickler <florian@mickler.org>
Cc: Linux PM <linux-pm@lists.linux-foundation.org>, markgross@thegnar.org
List-Id: linux-pm@vger.kernel.org

On Wed, 2010-06-09 at 08:38 +0200, Florian Mickler wrote:
> On Sun, 06 Jun 2010 23:05:06 -0400
> James Bottomley <James.Bottomley@suse.de> wrote:
> 
> > On Sun, 2010-06-06 at 14:39 -0700, mark gross wrote:
> > > > @@ -251,22 +244,27 @@ void pm_qos_update_request(struct pm_qos_request_list *pm_qos_req,
> > > >  	unsigned long flags;
> > > >  	int pending_update = 0;
> > > >  	s32 temp;
> > > > +	struct pm_qos_object *o;
> > > >  
> > > > -	if (pm_qos_req) { /*guard against callers passing in null */
> > > > -		spin_lock_irqsave(&pm_qos_lock, flags);
> > > > -		if (new_value == PM_QOS_DEFAULT_VALUE)
> > > > -			temp = pm_qos_array[pm_qos_req->pm_qos_class]->default_value;
> > > > -		else
> > > > -			temp = new_value;
> > > > +	if (!pm_qos_req) /*guard against callers passing in null */
> > > > +		return;
> > > 
> > > need a better test to see if the pm_qos_req is in the plist or not as we
> > > move to a caller allocated design.
> > 
> > This is a guard against callers passing in NULL ... which is probably
> > unnecessary ... I think oopsing on a NULL deref would be just fine for
> > that, since it would represent a programming error.
> 
> That is bad in the general case because you then depend on
> mmap_min_addr to be sufficiently large.
> 
> I would advocate for not making the attack surface that big.

I think you're thinking this is the userspace API?  It isn't, it's the
kernel, so we want to catch abusers hard usually with either warn on or
bug on ... ideally at build time, but that's not entirely possible in
this case.

James
