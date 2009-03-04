From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFD] Automatic suspend
Date: Wed, 4 Mar 2009 01:49:34 +0100
Message-ID: <20090304004934.GC6280__40539.393379777$1236130084$gmane$org@elf.ucw.cz>
References: <200902192215.18365.rjw@sisk.pl> <200903020017.52390.rjw@sisk.pl>
	<d6200be20903021548h11f57283t6d6a9053f3feb3fd@mail.gmail.com>
	<200903032339.02002.rjw@sisk.pl>
	<d6200be20903031538s42c8243dk59c505857cdab7cb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <d6200be20903031538s42c8243dk59c505857cdab7cb@mail.gmail.com>
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
Cc: Kyle Moffett <kyle@moffetthome.net>, Uli Luckas <u.luckas@road.de>, LKML <linux-kernel@vger.kernel.org>, Nigel Cunningham <nigel@nigel.suspend2.net>, Brian Swetland <swetland@google.com>, pm list <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> > That need not happen at once (eg. in one patch or something). =A0Once w=
e've
> > introduced the basics, the changes can be made gradually wherever neces=
sary,
> > step by step.
> =

> If you are OK with merging an unfinished system then this may work.

Good.

> > So, I'd suggest to just separate the timeouted suspend blockers from the
> > basic code and introduce the latter first.
> =

> How do you want to handle drivers that return -EBUSY from suspend. The
> basic code uses a wakelock with a timeout to handle this now. Without
> this we can either try suspend again immediately, or activate a
> suspend blocker and use a timer to release it.

Just printk() and complain. That should be good enough solution for
now... (Those drivers are arguably buggy already. If user told machine
to go to sleep, it should not randomly refuse to do that.)

									Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
