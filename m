From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH -mm 2/2] Freezer: Use wait queue instead
	of busy looping
Date: Tue, 31 Jul 2007 12:17:59 +0200
Message-ID: <200707311218.00512.rjw@sisk.pl>
References: <200707251401.48340.rjw@sisk.pl> <200707311139.24928.rjw@sisk.pl>
	<20070731100031.GA3462@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070731100031.GA3462@elf.ucw.cz>
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
To: Pavel Machek <pavel@ucw.cz>
Cc: Nigel Cunningham <nigel@nigel.suspend2.net>, Andres Salomon <dilinger@debian.org>, pm list <linux-pm@lists.linux-foundation.org>, Chris Ball <cjb@laptop.org>, David Woodhouse <dwmw2@infradead.org>, Oleg Nesterov <oleg@tv-sign.ru>
List-Id: linux-pm@vger.kernel.org

On Tuesday, 31 July 2007 12:00, Pavel Machek wrote:
> Hi!
> 
> > > Ok, could we just do schedule_timeout(HZ/10) or something, but when we
> > > _know_ we woke someone, wakeup() that task? No new variables, keep
> > > existing logic.
> > 
> > The logic doesn't change that much. :-)
> > 
> > > That should still get most of the benefits, and be two liner, no?
> > 
> > Well, I think we can avoid using refrigerator_called, if this is a problem, but
> > the patch won't be a two liner.
> 
> Sure? The current process is ineffective because it polls. If we add
> schedule_timeout(HZ/10), we'll have still correct freezer (and it will
> not waste power any more), but it will delay freezing by HZ/20 on
> average.
> 
> If we add wakeup() at strategic place, we should get rid of that delay...

But we'll need to know what to wake up ...

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
