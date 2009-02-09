From: Brian Swetland <swetland@google.com>
Subject: Re: [PATCH 05/13] PM: Add option to disable
	/sys/power/state	interface
Date: Mon, 9 Feb 2009 05:31:18 -0800
Message-ID: <20090209133118.GA26322@bulgaria.corp.google.com>
References: <1233802226-23386-1-git-send-email-arve@android.com>
	<200902090040.22364.rjw@sisk.pl>
	<d6200be20902081558r272e13b1q28692eaba758878b@mail.gmail.com>
	<200902090126.17899.rjw@sisk.pl>
	<d6200be20902081735l734ac6c9h811b8ad6f40e2562@mail.gmail.com>
	<20090209015333.GC24119@bulgaria.corp.google.com>
	<20090209085854.GA28794@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20090209085854.GA28794@atrey.karlin.mff.cuni.cz>
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
Cc: ncunningham@crca.org.au, u.luckas@road.de, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

[Pavel Machek <pavel@ucw.cz>]
> > [Arve Hj?nnev?g <arve@android.com>]
> > > 
> > > Yes we need access to wakelocks from user space. We also allow third
> > > party apps to use wakelocks if they request the right permission. This
> > > could include a music player keeping the device on while playing a
> > > song, or an pop email client using an alarm to download email every
> > > hour.
> > 
> > To expand on this a bit: We don't allow arbitrary apps to directly grab
> > wakelocks with the sys interface -- instead a system service in
> > userspace manages wakelock requests on behalf of apps needing them.
> 
> So in fact single wakelock for userspace would be enough for you?
> 
> Cool, that certainly makes user<->kernel interface easier.
> 
> OTOH "gcc now has to talk to system service" requirement is quite ugly.

I think we'd still want multiple entities to hold wakelocks from
userspace -- in the Android case, the daemon that handles low level
telephony state also has its own wakelock.  I was speaking more from a
permission standpoint that there may not need to be a 1:1 between
userspace entities needing to keep the system from sleeping and a
wakelock in the kernel.

Arve has a prototype of a driver interface instead of the sysfs
interface where one opens /dev/wakelock to obtain a wakelock (via fd)
which can be cleaned up automatically on app exit, etc.

I don't think you'd actually want to have plain 'ol commandline tools
like gcc and so on to be modified to be aware of wakelocks.  Instead,
I'd imagine you'd setup a general "run x while keeping the system awake"
tool, or maybe modify just the shell you're using.

Brian
