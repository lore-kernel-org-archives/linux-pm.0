From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] PM updates for 2.6.33
Date: Mon, 7 Dec 2009 12:56:00 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0912071249390.3560__42815.8744973645$1260219674$gmane$org@localhost.localdomain>
References: <Pine.LNX.4.44L0.0912060953190.4442-100000@netrider.rowland.org>
	<200912071615.34788.rjw@sisk.pl>
	<alpine.LFD.2.00.0912070832330.3560@localhost.localdomain>
	<200912072147.13851.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200912072147.13851.rjw@sisk.pl>
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
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org



On Mon, 7 Dec 2009, Rafael J. Wysocki wrote:
> 
> So I guess the only thing we need at the core level is to call
> async_synchronize_full() after every stage of suspend/resume, right?

Yes and no.

Yes in the sense that _if_ everybody always uses "async_schedule()" (or 
whatever the call is named - I've really only written pseudo-code and 
haven't even tried to look up the details), then the only thing you need 
to do is async_synchronize_full().

But one of the nice things about using just the trivial rwlock model and 
letting any async users just depend on that is that we could easily just 
depend entirely on those device locks, and allow drivers to do async 
shutdowns other ways too.

For example, I could imagine some driver just doing an async suspend (or 
resume) that gets completed in an interrupt context, rather than being 
done by 'async_schedule()' at all. 

So in many ways it's nicer to serialize by just doing

	serialize_all_PM_events()
	{
		for_each_device() {
			down_write(dev->lock);
			up_write(dev->lock);
		}
	}

rather than depend on something like async_synchronize_full() that 
obviously waits for all async events, but doesn't have the capability to 
wait for any other event that some random driver might be using.

[ That "down+up" is kind of stupid, but I don't think we have a "wait for 
  unlocked" rwsem operation. We could add one, and it would be cheaper for 
  the case where the device never did anything async at all, and didn't 
  really need to dirty that cacheline by doing that write lock/unlock 
  pair. ]

But that really isn't a big deal. I think it would be perfectly ok to also 
just say "if you do any async PM, you need to use 'async_schedule()' 
because that's all we're going to wait for". It's probably perfectly fine.

			Linus
