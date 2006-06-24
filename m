From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Fri, 23 Jun 2006 21:10:04 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606232108440.6483@g5.osdl.org>
References: <Pine.LNX.4.44L0.0606211219170.6700-100000@iolanthe.rowland.org>
	<Pine.LNX.4.64.0606231622580.6483@g5.osdl.org>
	<Pine.LNX.4.64.0606231706180.6483@g5.osdl.org>
	<200606232030.11497.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200606232030.11497.david-b@pacbell.net>
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
Cc: linux-pm@lists.osdl.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org



On Fri, 23 Jun 2006, David Brownell wrote:
> =

> So have we all.  It makes us want to avoid large scale changes that cause
> a need to retest things, since adequate retesting even on _one_ of the
> affected platform configurations can take so long.

The whole notion that this needs "large" changes was somebody elses =

theory. I just posted the patch that implements all my proposals with =

_zero_ need for driver changes.

Yes, drivers need to change if they want to take advantage of this, of =

course..

			Linus
