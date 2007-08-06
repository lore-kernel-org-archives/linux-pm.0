From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 2.6.23-rc2 1/2] define clk_must_disable()
Date: Mon, 6 Aug 2007 14:03:16 -0700
Message-ID: <200708061403.16311.david-b@pacbell.net>
References: <200708061111.03407.david-b@pacbell.net>
	<20070806200446.GD3360@flint.arm.linux.org.uk>
	<200708061338.08561.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200708061338.08561.david-b@pacbell.net>
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
To: Russell King <rmk@arm.linux.org.uk>
Cc: Andrew Victor <andrew@sanpeople.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Monday 06 August 2007, David Brownell wrote:
> > Please don't wrap up unreviewed patches as "important build fixes".
>=20
> From my perspective, they've been reviewed for well over a year and
> have just been waiting for me to get off my butt and be extremely
> explicit that they need to merge. =A0(That is, not expect anyone to
> just pick them up and merge.)

Oh, and one more point in favor of merging this:  they've been in
use in Andrew Victor's 2.6 AT91 patches since last November.

That would be yet another reason why nobody has noticed this build
problem before.  It's not just me; almost everyone doing AT91 work
is *already using* these two patches, and has been doing so for most
of the last year.


> And since you asked for a build fix ... I have a hard time thinking
> that anything else could really be the "right fix".
=20
