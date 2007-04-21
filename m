From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] s2ram: add arch irq disable/enable hooks
Date: Sat, 21 Apr 2007 10:06:58 -0700
Message-ID: <200704211006.58857.david-b@pacbell.net>
References: <1176980411.6141.83.camel@johannes.berg>
	<200704210955.11351.david-b@pacbell.net>
	<1177174861.5941.26.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1177174861.5941.26.camel@johannes.berg>
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
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Saturday 21 April 2007, Johannes Berg wrote:
> On Sat, 2007-04-21 at 09:55 -0700, David Brownell wrote:
> 
> > Or maybe arch_suspend_disable_irqs() ... there are PM
> > operations that don't involve system suspend states.
> 
> Yeah, probably better and I'm fine with that, but the crowd who screamed
> when I noted that CONFIG_SOFTWARE_SUSPEND had nothing to do with suspend
> states might be confused... It should be obvious that this isn't called
> for suspend to disk.

Yeah, but SOFTWARE_SUSPEND is also a misnomer.  It's more of a
system checkpoint/restore framework.  And even userspace makes
that distinction clear, calling it "Hibernate" not "Suspend".

I feel a Kconfig patch coming on ... ;)

- Dave
