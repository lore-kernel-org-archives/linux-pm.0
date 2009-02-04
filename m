From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH 00/11] Android PM extensions
Date: Wed, 4 Feb 2009 14:29:35 +0100
Message-ID: <20090204132934.GB1218@ucw.cz>
References: <d6200be20902021510k104f2da9ha89fa00baff3910a@mail.gmail.com>
	<Pine.LNX.4.44L0.0902022207440.27307-100000@netrider.rowland.org>
	<d6200be20902022018k7fda9120yb7321f5341050ce8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <d6200be20902022018k7fda9120yb7321f5341050ce8@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Arve Hj?nnev?g <arve@android.com>
Cc: Brian Swetland <swetland@google.com>, linux-pm@lists.linux-foundation.org, Uli Luckas <u.luckas@road.de>, Nigel Cunningham <ncunningham@crca.org.au>
List-Id: linux-pm@vger.kernel.org


> > For example, if one process tries to start an auto-suspend, and at the
> > same time another process writes "mem" to /sys/power/state?  Then the
> > second process should take precedence and the system should go into
> > suspend.  When it wakes up again, the first process would still be
> > waiting for an auto-suspend to occur.  I suppose the details don't
> > matter much because it's not likely to crop up often.
> 
> I'll make a change to make any write to /sys/power/state disable
> wakelocks. I'll probably also add a config option to remove
> /sys/power/state.
> 
> Before I post another patch series I have a few questions:
> - Should I merge the wakelock and early-suspend api patches with their
> implementations? (I initially implemented the api on top of the old
> android_power driver, but we not longer use this)

I think so.

> - Once wakelocks are disabled by writing to /sys/power/state, is there
> any demand for re-enabling wakelock support?

I do not think wakelocks should be disabled. They should probably be
ignored for echo mem > state, but disabling them sounds wrong.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
