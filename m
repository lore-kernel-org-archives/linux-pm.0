From: Oleg Nesterov <oleg@tv-sign.ru>
Subject: Re: 2.6.21-rc4-mm1: freezing of processes broken
Date: Wed, 21 Mar 2007 17:23:50 +0300
Message-ID: <20070321142350.GB78@tv-sign.ru>
References: <20070319205623.299d0378.akpm@linux-foundation.org>
	<46004B02.7020407@gmail.com> <200703202206.38168.rjw@sisk.pl>
	<200703210149.33240.rjw@sisk.pl>
	<m1lkhre6f5.fsf@ebiederm.dsl.xmission.com>
	<1174446834.6665.3.camel@nigel.suspend2.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1174446834.6665.3.camel@nigel.suspend2.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Nigel Cunningham <nigel@nigel.suspend2.net>
Cc: Sukadev Bhattiprolu <sukadev@us.ibm.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org, Jiri Slaby <jirislaby@gmail.com>
List-Id: linux-pm@vger.kernel.org

On 03/21, Nigel Cunningham wrote:
> =

> On Tue, 2007-03-20 at 19:23 -0600, Eric W. Biederman wrote:
> > >> > Rafael J. Wysocki napsal(a):
> > >
> > > Bisection shows that the freezing of processes has been broken by one=
 of the
> > > patches:
> > >
> > > remove-the-likelypid-check-in-copy_process.patch
> > =

> > Grr.  Oleg's review of remove-the-likelypid-check-in-copy-process
> > showed it to be questionable (and it was just an optimization)
> > so we can get rid of that one easily. =

> > =

> > Although all it did that was really questionable was add
> > the idle process to the global process list and bump a process
> > count when we forked the idle process.  Not dramatically dangerous
> > things.
> =

> Could the freezer code be trying to freeze the idle thread as a result?

Yes. remove-the-likelypid-check-in-copy_process.patch make idle threads
visible to for_each_process/do_each_thread. Note also that idle threads
have ->mm !=3D NULL. freezer, oom_kill, move_task_off_dead_cpu, etc, should
not see idle threads, but they do now.

Oleg.
