From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH 00/11] Android PM extensions (version 3)
Date: Sun, 22 Feb 2009 14:48:52 +0100
Message-ID: <20090222134852.GB1436@ucw.cz>
References: <1234316955-31304-1-git-send-email-arve@android.com>
	<20090217210504.GD1433@ucw.cz>
	<d6200be20902181743i1bb36fe8m95b50c0fbd6d3c2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <d6200be20902181743i1bb36fe8m95b50c0fbd6d3c2@mail.gmail.com>
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
Cc: ncunningham@crca.org.au, u.luckas@road.de, swetland@google.com, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi!

> > earlysuspend is an ugly hack and wakelock is very wrong name at the
> > very least... as seen in previous discussion. Can we get that fixed?
> 
> I don't have a fix for earlysuspend, but it is far less important than
> wakelocks, so I can drop it from the patch series if that is
> preferred.
> 
> Regarding the name, I don't agree with your statement that wakelock is
> a very wrong name. Like I said before, you can view it as a
> reader/writer lock where the readers protect the wake state of the
> system. That said, if there is a better name that more than one person
> can agree on, I can rename the api. Here is a list of suggestions I
> have seen so far along with the api I think they dictate if the
> existing functionality is to be preserved:


> suspend_inhibitor: (from inhibit_suspend)
> - api: suspend_inhibitor_init, suspend_inhibitor_destroy,
> suspend_inhibit, suspend_inhibit_timeout, suspend_uninhibit
> - pros: The effect is more obvious than *_lock.
> - cons: Does not match android user space api (but less confusing than
> suspend/sleep_lock).

I like this one, as does rafael, so :-).

I thought you are switching to /dev based api anyway so rename should
not be a problem?
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
