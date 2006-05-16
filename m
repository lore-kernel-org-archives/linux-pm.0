From: Pavel Machek <pavel@ucw.cz>
Subject: Re: suspend and hibernate nomenclature
Date: Tue, 16 May 2006 20:40:22 +0000
Message-ID: <20060516204021.GA5846@ucw.cz>
References: <1147024930.16057.3.camel@localhost.localdomain>
	<200605081647.55275.david-b@pacbell.net>
	<1147160320.2120.10.camel@localhost.localdomain>
	<200605090857.07853.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9760689596277532=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200605090857.07853.david-b@pacbell.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-pm@lists.osdl.org, richard@hughsie.com
List-Id: linux-pm@vger.kernel.org

--===============9760689596277532==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> Of course what I _would_ like to see is Linux distros that autosuspend,
> entering "standby" after they're idle for a while and then, if they're
> not woken up quickly enough, entering "suspend-to-RAM".  No point in
> having laptops burn all that energy all the time, after all ... or
> automagically inflicting long resume-from-STR latencies on them.

Actually, it is quite hard to decide when it is okay to suspend
machine. You do not want it to fall asleep during compilation/cd
burning/download.

> > If you guys used a sleep name in the kernel
> > sleep_for_not_longer_than_6_minutes_but_more_that_2_seconds() I really
> > don't mind -- but if the user has to click a button, I would rather the
> > button was marked suspend or hibernate :-)
> 
> Well "not_longer_yadda_yadda()" would be a bizarre model.  The user-visible
> issue is the latency to suspend or resume ... where "standby" is quick, and
> "suspend-to-RAM" is relatively slow.  Where "quick" is on the order of time
> for users to finish switching their mental context, while "slow" is on the
> order of doing that _plus_ doing something else to fill the wait time.  How
> long the system stays in a given suspend state is immaterial to any issue
> beyond how much power is saved.  (Which is only indirectly user visible,
> e.g. stretching battery life out one more hour vs eight more.)

Well, entering/exiting s2ram eats more power than idle; so if you expect to
sleep 4 seconds, it is probably best to do nothing, maybe enter
standby if you are fast.

4sec idle: 4 sec at 10W
4sec s2ram: 2 sec entering s2ram at 15W, 0 sec sleep, 2 sec exiting
s2ram at 15W. bad
4sec standby: 1sec enter standby at 15W, 2 sec sleep at 5W, 1 sec exit
standby at 15W

							Pavel
-- 
Thanks for all the (sleeping) penguins.

--===============9760689596277532==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============9760689596277532==--
