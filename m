From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: 2.6.21-rc4-mm1: freezing of processes broken
Date: Tue, 20 Mar 2007 19:23:10 -0600
Message-ID: <m1lkhre6f5.fsf@ebiederm.dsl.xmission.com>
References: <20070319205623.299d0378.akpm@linux-foundation.org>
	<46004B02.7020407@gmail.com> <200703202206.38168.rjw@sisk.pl>
	<200703210149.33240.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200703210149.33240.rjw@sisk.pl> (Rafael J. Wysocki's message of
	"Wed, 21 Mar 2007 01:49:32 +0100")
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Sukadev Bhattiprolu <sukadev@us.ibm.com>, Jiri Slaby <jirislaby@gmail.com>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@tv-sign.ru>
List-Id: linux-pm@vger.kernel.org

"Rafael J. Wysocki" <rjw@sisk.pl> writes:

> On Tuesday, 20 March 2007 22:06, Rafael J. Wysocki wrote:
>> On Tuesday, 20 March 2007 21:58, Jiri Slaby wrote:
>> > Rafael J. Wysocki napsal(a):
>> > > Actually, the problem is 100% reproducible on my system too and I do=
ubt
> it's
>> > > caused by the recent freezer patches.
>> > =

>> > I don't know what exactly do you mean by recent, but 2.6.21-rc3-mm2 wo=
rks
>> > for me.
>> =

>> Thanks for the confirmation.
>> =

>> The patches I was talking about had already been in 2.6.21-rc3-mm2, so t=
he
>> reason of this failure must be different.
>
> Bisection shows that the freezing of processes has been broken by one of =
the
> patches:
>
> remove-the-likelypid-check-in-copy_process.patch

Grr.  Oleg's review of remove-the-likelypid-check-in-copy-process
showed it to be questionable (and it was just an optimization)
so we can get rid of that one easily. =


Although all it did that was really questionable was add
the idle process to the global process list and bump a process
count when we forked the idle process.  Not dramatically dangerous
things.

> use-task_pgrp-task_session-in-copy_process.patch

As I recall that patch was pretty trivial, and shouldn't have
anything to do with the freezer.   The process freezer doesn't care
about pids does it?

Eric
