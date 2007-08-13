From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] x86_64: Save registers in saved_context
	during suspend and hibernation
Date: Tue, 14 Aug 2007 00:52:30 +0200
Message-ID: <20070813225229.GF3406@bingen.suse.de>
References: <200708132347.07396.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200708132347.07396.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: discuss@x86-64.org, pm list <linux-pm@lists.linux-foundation.org>, Andi Kleen <ak@suse.de>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Mon, Aug 13, 2007 at 11:47:06PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> During hibernation and suspend on x86_64 save CPU registers in the saved_context
> structure rather than in a handful of separate variables.

Nice. These variables always annoyed me too when looking
at that code.

>  	DEFINE(pbe_next, offsetof(struct pbe, next));
>  	BLANK();
> +	DEFINE(saved_context_rbx, offsetof(struct saved_context, rbx));

But is there a reason you can't just use a pt_regs and then an array
for the crNs ? 

-Andi
