From: Florian Mickler <florian@mickler.org>
Subject: Re: [PATCH 2/2] pm_qos: make update_request callable
 from interrupt context
Date: Wed, 9 Jun 2010 18:48:50 +0200
Message-ID: <20100609184850.2779b784__4743.27725028179$1276102194$gmane$org@schatten.dmk.lab>
References: <1276074915-26879-1-git-send-email-florian@mickler.org>
	<1276074915-26879-2-git-send-email-florian@mickler.org>
	<alpine.LFD.2.00.1006091146010.2933@localhost.localdomain>
	<1276087119.4343.52.camel@mulgrave.site>
	<20100609172714.7438db1f@schatten.dmk.lab>
	<1276097546.4343.219.camel@mulgrave.site>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1276097546.4343.219.camel@mulgrave.site>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: James Bottomley <James.Bottomley@suse.de>
Cc: markgross@thegnar.org, Frederic Weisbecker <fweisbec@gmail.com>, Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Jonathan@smtp1.linux-foundation.org, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 09 Jun 2010 11:32:26 -0400
James Bottomley <James.Bottomley@suse.de> wrote:
 
> > > @@ -302,8 +330,12 @@ int pm_qos_add_notifier(int pm_qos_class, struct notifier_block *notifier)
> > >  {
> > >  	int retval;
> > >  
> > > +	/* someone tried to register a blocking notifier to a
> > > +	 * qos object that only supports atomic ones */
> > > +	BUG_ON(!pm_qos_array[pm_qos_class]->blocking_notifiers);
> > > +
> > >  	retval = blocking_notifier_chain_register(
> > > -			pm_qos_array[pm_qos_class]->notifiers, notifier);
> > > +			pm_qos_array[pm_qos_class]->blocking_notifiers, notifier);
> > >  
> > >  	return retval;
> > >  }
> > 
> > Why not:
> > 
> > 	retval = 1;
> > 	if(pm_qos_array[pm_qos_class]->blocking_notifiers) 
> > 		retval = blocking_notifier_chain_register(..
> > 	else 
> > 		WARN();
> > 	return retval;
> > 
> > That way, the offending programmer could eventually fix it, without
> > having to reboot? 
> 
> Because there are no current users that will trip the BUG_ON ... and we
> want to keep it that way.  Code doesn't go into the kernel if it BUGs on
> boot.
> 
> The point about failing hard for an abuse of a kernel API isn't to trap
> current abusers because you fix those before you add it.  It's to
> prevent future abuse.  If your kernel BUGs under test you tend to fix
> the code, so it becomes impossible for anyone to add any users which
> abuse the API in this fashion.
> 
> James
> 

There are actually people who ignore WARN()ings when submitting code??

....thinking about it... Yes, that may be possible. 

Cheers,
Flo

--
Only two things are infinite, the universe and human stupidity, and I'm
not sure about the former. Albert Einstein 
