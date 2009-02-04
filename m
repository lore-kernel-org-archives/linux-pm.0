From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH 00/11] Android PM extensions
Date: Wed, 4 Feb 2009 14:25:13 +0100
Message-ID: <20090204132513.GA1218@ucw.cz>
References: <Pine.LNX.4.44L0.0902021005050.2550-100000@iolanthe.rowland.org>
	<1233611258.21871.101.camel@nigel-laptop>
	<d6200be20902021521q6a855f78m88413869eb7e2da6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <d6200be20902021521q6a855f78m88413869eb7e2da6@mail.gmail.com>
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
Cc: Brian Swetland <swetland@google.com>, Nigel Cunningham <ncunningham@crca.org.au>, Uli Luckas <u.luckas@road.de>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi!

> <ncunningham@crca.org.au> wrote:
> > It sounds to me like all of this stuff is just power management of
> > individual devices, which should be done through the sysfs interface and
> > completely unrelated to /sys/power/state.
> 
> It is easier for us to add a hook to the individual drivers than to
> maintain a list of devices in user-space. Also, last time I checked,
> the only way to disable individual devices was through a deprecated
> interface. Is there a new way to do this?

No, but we need one, sooner or later. I'd say that implementing nice
device power management would be better than early-suspend hack.

> > That said, if suspend to ram is what they really want for 'auto-mem',
> > what you're suggesting sounds good to me.
> 
> Suspend gives us two advantages over idle. All threads are frozen
> which means that an app that is using too much cpu time no longer
> drains the battery. And, the monotonic clock stops.

SIGSTOP should be the right tool if some application uses too much
cycles...


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
