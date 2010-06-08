From: mark gross <640e9920@gmail.com>
Subject: Re: [PATCH v3] pm_qos: make update_request callable from
 interrupt context
Date: Mon, 7 Jun 2010 21:13:41 -0700
Message-ID: <20100608041340.GA23473@gvim.org>
References: <1275920448.2849.31.camel@mulgrave.site>
	<1275924869-3811-1-git-send-email-florian@mickler.org>
	<1275927581.13772.10.camel@mulgrave.site>
Reply-To: markgross@thegnar.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1275927581.13772.10.camel@mulgrave.site>
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
Cc: florian@mickler.org, pm list <linux-pm@lists.linux-foundation.org>, markgross@thegnar.org
List-Id: linux-pm@vger.kernel.org

On Mon, Jun 07, 2010 at 12:19:41PM -0400, James Bottomley wrote:
> On Mon, 2010-06-07 at 17:34 +0200, florian@mickler.org wrote:
> > We use the spinlocked notifier chain variant (struct
> > atomic_notifier_head) and add an __might_sleep() to the chain for
> > constraints which have non-atomic notifiers. This way we catch all
> > interrupt-context-update-sites at runtime.
> 
> Actually, I'm afraid we can't really call blocking notifiers through the
> atomic chain because we might end up with a contested chain call and a
> huge busy wait in the spinlock (especially if one of the notifiers is
> sleeping).
> 
> I think the pm_qos_object still needs the two notifier chains ... it's
> just that when set up, one must either fill an atomic or a blocking
> chain (leaving the other NULL).  We use the NULL to check to decide what
> chain to add notifiers to, and if the blocking chain is null, we refuse
> to add blocking notifiers (with a BUG). If the blocking chain is
> non-null, we register the might_sleep() notifier (actually, given the
> argument mismatch, you'll have to wrapper that).
> 
> James
Can't we just requiere that all notifier callbacks be atomic context
safe and not fart around with 2 classes of notifiers?

--mgross
