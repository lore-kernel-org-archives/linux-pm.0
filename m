From: Florian Mickler <florian@mickler.org>
Subject: Re: [PATCH v3] pm_qos: make update_request callable from
 interrupt context
Date: Wed, 9 Jun 2010 09:18:39 +0200
Message-ID: <20100609091839.6b34f8e7@schatten.dmk.lab>
References: <1275920448.2849.31.camel@mulgrave.site>
	<1275924869-3811-1-git-send-email-florian@mickler.org>
	<1275927581.13772.10.camel@mulgrave.site>
	<20100608041340.GA23473@gvim.org>
	<1275998764.9953.1.camel@mulgrave.site>
	<20100609085427.3a819e35@schatten.dmk.lab>
	<20100609091330.77427fb9@schatten.dmk.lab>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100609091330.77427fb9@schatten.dmk.lab>
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
Cc: pm list <linux-pm@lists.linux-foundation.org>, James Bottomley <James.Bottomley@suse.de>, markgross@thegnar.org
List-Id: linux-pm@vger.kernel.org

On Wed, 9 Jun 2010 09:13:30 +0200
Florian Mickler <florian@mickler.org> wrote:

> On Wed, 9 Jun 2010 08:54:27 +0200
> Florian Mickler <florian@mickler.org> wrote:
> 
>  > > On Mon, Jun 07, 2010 at 12:19:41PM -0400, James Bottomley wrote:
> > > > > On Mon, 2010-06-07 at 17:34 +0200, florian@mickler.org wrote:
> > > > > > We use the spinlocked notifier chain variant (struct
> > > > > > atomic_notifier_head) and add an __might_sleep() to the chain for
> > > > > > constraints which have non-atomic notifiers. This way we catch all
> > > > > > interrupt-context-update-sites at runtime.
> > > > > 
> > > > > Actually, I'm afraid we can't really call blocking notifiers through the
> > > > > atomic chain because we might end up with a contested chain call and a
> > > > > huge busy wait in the spinlock (especially if one of the notifiers is
> > > > > sleeping).
> 	
> Actually, I just checked and __atomic_notifier_call_chain()
> uses an rcu_read_lock() to protect the chain from removal of
> notifiers while going through it. 
> 	
> So I (now again) think this patch (with queuing the  might_sleep() for
> the network notifier) might be enough.
> 
> Cheers,
> Flo

Oh, wow. I changed my mind again after reading up on RCU :|.

 * It is illegal to block while in an RCU read-side critical section.

(from include/linux/rcupdate.h)

Cheers,
Flo

p.s.: so, back to my original plan. 
