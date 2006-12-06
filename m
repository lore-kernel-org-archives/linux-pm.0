From: Nigel Cunningham <ncunningham@linuxmail.org>
Subject: Re: [Suspend-devel] [PATCH -mm 1/2]: PM: Fix handling	of
	stopped tasks
Date: Wed, 06 Dec 2006 11:02:20 +1100
Message-ID: <1165363341.19284.0.camel@nigel.suspend2.net>
References: <200612032318.29030.rjw@sisk.pl>
	<20061205223634.GA2642@elf.ucw.cz> <200612052345.28882.rjw@sisk.pl>
	<200612060008.51373.rjw@sisk.pl>  <20061205234550.GA10914@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20061205234550.GA10914@elf.ucw.cz>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@ucw.cz>
Cc: suspend-devel@lists.sourceforge.net, pm list <linux-pm@lists.osdl.org>, Stephen Hemminger <shemminger@osdl.org>
List-Id: linux-pm@vger.kernel.org

Hi guys.

On Wed, 2006-12-06 at 00:45 +0100, Pavel Machek wrote:
> Hi!
> =

> > > > ...after resume.
> > > =

> > > This is because of how signal_wake_up() works, I think..
> > > =

> > > > But I think it is right approach.
> > =

> > Okay, with the appended patch applied everything seems to work and I do=
n't
> > see any undesirable side-effects.
> =

> I promise to try it... tommorow. Looks very good to me.

Just to say sorry for my lack of interaction / feedback. Too busy with
other stuff at the moment, but I'm trying to keep track :)

Nigel
