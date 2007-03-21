From: Oleg Nesterov <oleg@tv-sign.ru>
Subject: Re: 2.6.21-rc4-mm1: freezing of processes broken
Date: Wed, 21 Mar 2007 20:15:38 +0300
Message-ID: <20070321171538.GA550@tv-sign.ru>
References: <20070319205623.299d0378.akpm@linux-foundation.org>
	<1174446834.6665.3.camel@nigel.suspend2.net>
	<20070321142350.GB78@tv-sign.ru> <200703211545.17919.rjw@sisk.pl>
	<20070321082029.2a38e09f.akpm@linux-foundation.org>
	<20070321165534.GA476@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20070321165534.GA476@tv-sign.ru>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Sukadev Bhattiprolu <sukadev@us.ibm.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org, Jiri Slaby <jirislaby@gmail.com>
List-Id: linux-pm@vger.kernel.org

On 03/21, Oleg Nesterov wrote:
>
> On 03/21, Andrew Morton wrote:
> >
> > On Wed, 21 Mar 2007 15:45:16 +0100 "Rafael J. Wysocki" <rjw@sisk.pl> wr=
ote:
> > =

> > > On Wednesday, 21 March 2007 15:23, Oleg Nesterov wrote:
> > > > > =

> > > > > Could the freezer code be trying to freeze the idle thread as a r=
esult?
> > > > =

> > > > Yes. remove-the-likelypid-check-in-copy_process.patch make idle thr=
eads
> > > > visible to for_each_process/do_each_thread. Note also that idle thr=
eads
> > > > have ->mm !=3D NULL. freezer, oom_kill, move_task_off_dead_cpu, etc=
, should
> > > > not see idle threads, but they do now.
> > > =

> > > Well, I think this is a good enough reason for asking Andrew to drop =
this
> > > patch.
> > =

> > Or we change the freezer to skip pid=3D=3D0 tasks.
> =

> I strongly disagree. In that case we should audit all users of for_each_p=
rocess.

Just in case, this is not the only problem with this patch. The things like
attach_pid(PIDTYPE_PGID/PIDTYPE_SID) or add_parent() are wrong for the idle
threads unless the parent is "swapper". But this is not always so.

Oleg.
