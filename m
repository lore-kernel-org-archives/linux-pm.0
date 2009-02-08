From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 02/13] PM: Add early suspend api.
Date: Sun, 8 Feb 2009 21:59:52 +0100
Message-ID: <20090208205952.GD6369@elf.ucw.cz>
References: <1233802226-23386-1-git-send-email-arve@android.com>
	<1233802226-23386-2-git-send-email-arve@android.com>
	<1233802226-23386-3-git-send-email-arve@android.com>
	<200902072153.30076.rjw@sisk.pl>
	<d6200be20902071534j711d7c36x49180b6af9739c0b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <d6200be20902071534j711d7c36x49180b6af9739c0b@mail.gmail.com>
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

> > My understanding of the 'early suspend' idea is that it is a mechanism allowing
> > us to place some devices selectively into low power states before the actual
> > suspend happens.  However, this is exactly the same as runtime power
> > management on demand, with an interface allowing user space to put devices into
> > low power states.
> 
> The main point is to have a single entrypoint from user-space. We do
> not have a list of devices to suspend in user-space.

I guess "single entrypoint" is not worth all the effort. ... plus,
different machines will likely need different "single entrypoints".

Can we get working "runtime suspend", instead?
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
