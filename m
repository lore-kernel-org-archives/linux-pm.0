From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] PM: runtime PM + idle: allow usage when
 interrupts are disabled
Date: Mon, 23 Aug 2010 09:18:45 +0200
Message-ID: <20100823071845.GA5685__28307.6712782078$1282548129$gmane$org@ucw.cz>
References: <1281459261-30829-1-git-send-email-khilman@deeprootsystems.com>
	<Pine.LNX.4.44L0.1008132112090.24267-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1008132112090.24267-100000@netrider.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi!

> > When using runtime PM in combination with CPUidle, the runtime PM
> > transtions of some devices may be triggered during the idle path.
> > Late in the idle sequence, interrupts will likely be disabled when
> > runtime PM for these devices is initiated.
> > 
> > Currently, the runtime PM core assumes methods are called with
> > interrupts enabled.  However, if it is called with interrupts
> > disabled, the internal locking unconditionally enables interrupts, for
> > example:
> 
> ...
> 
> > Unconditionally enabling interrupts late in the idle sequence is not
> > desired behavior.  To fix, use the save/restore versions of the
> > spinlock API.
> > 
> > Reported-by: Partha Basak <p-basak2@ti.com>
> > Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
> > ---
> > RFC: I'm not crazy about having the 'flags' in struct dev_pm_info, but
> > since the locks are taken and released in separate functions, this
> > seems better than changing the function APIs to pass around the flags.
> 
> There are restrictions on what you're allowed to do with the flags, but 
> I don't remember exactly what they are.

There used to be 'flags must local variable, and enable/disable must
happen in same function' restriction on sparc. Not sure if it is still
present. Ask davem?
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
