From: James Bottomley <James.Bottomley@suse.de>
Subject: Re: [PATCH v3] pm_qos: make update_request callable from
 interrupt context
Date: Mon, 07 Jun 2010 12:19:41 -0400
Message-ID: <1275927581.13772.10.camel@mulgrave.site>
References: <1275920448.2849.31.camel@mulgrave.site>
	<1275924869-3811-1-git-send-email-florian@mickler.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1275924869-3811-1-git-send-email-florian@mickler.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: florian@mickler.org
Cc: pm list <linux-pm@lists.linux-foundation.org>, markgross@thegnar.org
List-Id: linux-pm@vger.kernel.org

On Mon, 2010-06-07 at 17:34 +0200, florian@mickler.org wrote:
> We use the spinlocked notifier chain variant (struct
> atomic_notifier_head) and add an __might_sleep() to the chain for
> constraints which have non-atomic notifiers. This way we catch all
> interrupt-context-update-sites at runtime.

Actually, I'm afraid we can't really call blocking notifiers through the
atomic chain because we might end up with a contested chain call and a
huge busy wait in the spinlock (especially if one of the notifiers is
sleeping).

I think the pm_qos_object still needs the two notifier chains ... it's
just that when set up, one must either fill an atomic or a blocking
chain (leaving the other NULL).  We use the NULL to check to decide what
chain to add notifiers to, and if the blocking chain is null, we refuse
to add blocking notifiers (with a BUG). If the blocking chain is
non-null, we register the might_sleep() notifier (actually, given the
argument mismatch, you'll have to wrapper that).

James
