From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC] PowerOP Take 3, sysfs UI core 2/5
Date: Sat, 5 Aug 2006 12:09:51 +0000
Message-ID: <20060805120950.GB5417@ucw.cz>
References: <ADE4D9DBCFC3A345AAA95C195F62B6DD018ACC7B@de01exm64.ds.mot.com>
	<200607241732.57588.david-b@pacbell.net>
	<1153822154.5875.16.camel@localhost>
	<200607252205.37086.david-b@pacbell.net>
	<8417055efd530dbc76993e0b1d61de81@nomadgs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <8417055efd530dbc76993e0b1d61de81@nomadgs.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Matthew Locke <matt@nomadgs.com>
Cc: David Brownell <david-b@pacbell.net>, linux-pm@lists.osdl.org, Preece Scott-PREECE <scott.preece@motorola.com>
List-Id: linux-pm@vger.kernel.org

Hi!

> Here is the use case we are picturing:
> =

> The semiconductor vendor creates the full list of operating points =

> supported on a SoC (and reference board).  A device (cell phone, etc) =

> manufacturer decides to use only a subset of the full operating points =

> due to their use cases and board design.   We want to enable the =

> semiconductor vendor and device manufacturer to easily update the =

> operating points and selectively enable ones for their use in a way =

> that doesn't require maintaining out of tree patches or submitting =

> patches for every update and every device made.

Thats more complex than it needs to be. Easy solution is to allways
compile in full set from semiconductor vendor and then maybe only use
subset.

'Changing kernel is hard, lets do it from initscripts' is perverse
reason for overdesign... (And btw it should be kernel doing the
hardware abstraction, you are turning things upside down).
						Pavel
-- =

Thanks for all the (sleeping) penguins.
