From: Brian Swetland <swetland@google.com>
Subject: Re: [RFC][PATCH 00/11] Android PM extensions
Date: Fri, 30 Jan 2009 01:25:03 -0800
Message-ID: <20090130092503.GA8753@bulgaria.corp.google.com>
References: <d6200be20901142042n5aa6384al936e49f5bce8256e@mail.gmail.com>
	<Pine.LNX.4.44L0.0901151005240.2490-100000@iolanthe.rowland.org>
	<20090129130424.GA1425@ucw.cz>
	<d6200be20901291716g5b6f4542r54c2ba8672961c91@mail.gmail.com>
	<20090130090859.GA7967@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20090130090859.GA7967@atrey.karlin.mff.cuni.cz>
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
Cc: Nigel Cunningham <ncunningham@crca.org.au>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

[Pavel Machek <pavel@ucw.cz>]
> > On Thu, Jan 29, 2009 at 5:04 AM, Pavel Machek <pavel@ucw.cz> wrote:
> > > AFAICT, this is something very different. It is attempt to do
> > > autosuspend right. Imagine burning cd... right now you can suspend,
> > > and it will just stop the burn.
> > >
> > > Wakelocks code allows you to tell the machine 'feel free to suspend
> > > when you have nothing to do'... so the machine will burn the cd and
> > > then suspend.
...
> 
> I don't get it. So you are running userspace while system is
> suspended? 

The general idea is that we aggressively try to be suspended as much as
possible.  Typically this means that when the display is turned off
(after the user inactivity timeout, managed from a userspace process),
suspend is requested.

If work is being done that requires the system to keep running, a
wakelock is held, preventing suspend from happening.

If suspend happens, but we resume due to a wakeup interrupt (for
example, user pressing a key), a wakelock is typically acquired during
the interrupt handler (which is called while we're resuming) and
arranged to be held until the event is delivered to userspace.  The
userspace code which receives events acquires a wakelock before draining
the queue (after select returns, before reading, etc) so that it keeps
the system awake until the event is processed.

In many cases the system pretty rapidly drops wakelocks and returns to
suspend state.

Brian
