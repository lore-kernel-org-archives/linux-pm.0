From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] apm-emulation: Fix mutex race condition
Date: Wed, 4 May 2011 13:44:52 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1105041344050.28291@pobox.suse.cz>
References: <729677.85794.qm@web29008.mail.ird.yahoo.com>
	<201105032233.51918.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201105032233.51918.rjw@sisk.pl>
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
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Tue, 3 May 2011, Rafael J. Wysocki wrote:

> > --- On Tue, 3/5/11, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > > Hmm.  I'd rather use mutex_trylock() and call try_to_freeze() if
> > > that fails.
> > > 
> > > Is there anything wrong with this approach?
> > 
> > Well, mutex_trylock() doesn't wait if it cannot acquire the mutex, so 
> > won't the calling process enter a busy loop if it fails?
> 
> Right.  So I don't see how we could do better that in your patch at the
> moment.

Right, neither do I.

> I'm not sure if Jiri is going to take your patch.  I will if he doesn't.

I can add drivers/char/apm-emulation.c as the one maintained under the 
'APM' roof, and take this, no problem.

Rafael, I take it that I can add your Ack to this patch, right?

Thanks,

-- 
Jiri Kosina
SUSE Labs
