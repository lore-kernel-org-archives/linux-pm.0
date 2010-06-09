From: James Bottomley <James.Bottomley@suse.de>
Subject: Re: [PATCH 2/2] pm_qos: make update_request callable
 from interrupt context
Date: Wed, 09 Jun 2010 11:32:26 -0400
Message-ID: <1276097546.4343.219.camel__44831.1637192548$1276097739$gmane$org@mulgrave.site>
References: <1276074915-26879-1-git-send-email-florian@mickler.org>
	<1276074915-26879-2-git-send-email-florian@mickler.org>
	<alpine.LFD.2.00.1006091146010.2933@localhost.localdomain>
	<1276087119.4343.52.camel@mulgrave.site>
	<20100609172714.7438db1f@schatten.dmk.lab>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100609172714.7438db1f@schatten.dmk.lab>
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
Cc: Jonathan Corbet <corbet@lwn.net>, Frederic Weisbecker <fweisbec@gmail.com>, markgross@thegnar.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 2010-06-09 at 17:27 +0200, Florian Mickler wrote:
> On Wed, 09 Jun 2010 08:38:39 -0400
> James Bottomley <James.Bottomley@suse.de> wrote:
> 
> > On Wed, 2010-06-09 at 11:46 +0200, Thomas Gleixner wrote:
> > > On Wed, 9 Jun 2010, florian@mickler.org wrote:
> > > 
> > > > The pm_qos framework has to guarantee atomic notifications so that
> > > > drivers can request and release constraints at all times while no races
> > > > occur.
> > > > 
> > > > In order to avoid implementing a secondary notification chain in which
> > > > listeners might sleep, we demand that every listener implements it's
> > > > notification so that it can run in interrupt context. The listener is in
> > > > a better position to know if races are harmful or not.
> > > 
> > > That breaks existing notifiers.
> > 
> > Right ... and we don't want to do that.  Which is why I think we just
> > use blocking notifiers as they are but allow for creating atomic ones
> > which may use atomic update sites.
> > 
> > This is the solution I have in my tree ... it preserves existing
> > semantics because all the update and add sites are in user context, but
> > it allows for notifiers with purely atomic semantics and will do a
> > runtime warn if anyone tries to use them in a blocking fashion (or if
> > anyone adds an atomic update to an existing blocking notifier).
> > 
> > James
> 
> 
> > 
> > @@ -302,8 +330,12 @@ int pm_qos_add_notifier(int pm_qos_class, struct notifier_block *notifier)
> >  {
> >  	int retval;
> >  
> > +	/* someone tried to register a blocking notifier to a
> > +	 * qos object that only supports atomic ones */
> > +	BUG_ON(!pm_qos_array[pm_qos_class]->blocking_notifiers);
> > +
> >  	retval = blocking_notifier_chain_register(
> > -			pm_qos_array[pm_qos_class]->notifiers, notifier);
> > +			pm_qos_array[pm_qos_class]->blocking_notifiers, notifier);
> >  
> >  	return retval;
> >  }
> 
> Why not:
> 
> 	retval = 1;
> 	if(pm_qos_array[pm_qos_class]->blocking_notifiers) 
> 		retval = blocking_notifier_chain_register(..
> 	else 
> 		WARN();
> 	return retval;
> 
> That way, the offending programmer could eventually fix it, without
> having to reboot? 

Because there are no current users that will trip the BUG_ON ... and we
want to keep it that way.  Code doesn't go into the kernel if it BUGs on
boot.

The point about failing hard for an abuse of a kernel API isn't to trap
current abusers because you fix those before you add it.  It's to
prevent future abuse.  If your kernel BUGs under test you tend to fix
the code, so it becomes impossible for anyone to add any users which
abuse the API in this fashion.

James
