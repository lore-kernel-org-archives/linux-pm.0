From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [discuss] [PATCH] x86_64: Save registers in
	saved_context during suspend and hibernation
Date: Tue, 14 Aug 2007 00:26:26 +0200
Message-ID: <200708140026.27519.rjw@sisk.pl>
References: <200708132347.07396.rjw@sisk.pl>
	<20070813225229.GF3406@bingen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070813225229.GF3406@bingen.suse.de>
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
To: Andi Kleen <ak@suse.de>
Cc: discuss@x86-64.org, pm list <linux-pm@lists.linux-foundation.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Tuesday, 14 August 2007 00:52, Andi Kleen wrote:
> On Mon, Aug 13, 2007 at 11:47:06PM +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> > 
> > During hibernation and suspend on x86_64 save CPU registers in the saved_context
> > structure rather than in a handful of separate variables.
> 
> Nice. These variables always annoyed me too when looking
> at that code.
> 
> >  	DEFINE(pbe_next, offsetof(struct pbe, next));
> >  	BLANK();
> > +	DEFINE(saved_context_rbx, offsetof(struct saved_context, rbx));
> 
> But is there a reason you can't just use a pt_regs and then an array
> for the crNs ? 

Hm, I think I can use pt_regs.  I'll try to redo the patch to use it.

OTOH, crNs already are members of saved_context and are accessed from C.
I wouldn't like to change that code.

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
