From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.21-rc4-mm1: freezing of processes broken
Date: Wed, 21 Mar 2007 15:45:16 +0100
Message-ID: <200703211545.17919.rjw@sisk.pl>
References: <20070319205623.299d0378.akpm@linux-foundation.org>
	<1174446834.6665.3.camel@nigel.suspend2.net>
	<20070321142350.GB78@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070321142350.GB78@tv-sign.ru>
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
To: Oleg Nesterov <oleg@tv-sign.ru>, Andrew Morton <akpm@linux-foundation.org>
Cc: Sukadev Bhattiprolu <sukadev@us.ibm.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org, Jiri Slaby <jirislaby@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Wednesday, 21 March 2007 15:23, Oleg Nesterov wrote:
> On 03/21, Nigel Cunningham wrote:
> > =

> > On Tue, 2007-03-20 at 19:23 -0600, Eric W. Biederman wrote:
> > > >> > Rafael J. Wysocki napsal(a):
> > > >
> > > > Bisection shows that the freezing of processes has been broken by o=
ne of the
> > > > patches:
> > > >
> > > > remove-the-likelypid-check-in-copy_process.patch
> > > =

> > > Grr.  Oleg's review of remove-the-likelypid-check-in-copy-process
> > > showed it to be questionable (and it was just an optimization)
> > > so we can get rid of that one easily. =

> > > =

> > > Although all it did that was really questionable was add
> > > the idle process to the global process list and bump a process
> > > count when we forked the idle process.  Not dramatically dangerous
> > > things.
> > =

> > Could the freezer code be trying to freeze the idle thread as a result?
> =

> Yes. remove-the-likelypid-check-in-copy_process.patch make idle threads
> visible to for_each_process/do_each_thread. Note also that idle threads
> have ->mm !=3D NULL. freezer, oom_kill, move_task_off_dead_cpu, etc, shou=
ld
> not see idle threads, but they do now.

Well, I think this is a good enough reason for asking Andrew to drop this
patch.

Greetings,
Rafael
