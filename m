From: Oliver Neukum <oliver@neukum.org>
Subject: Re: Re: Hibernation considerations
Date: Fri, 20 Jul 2007 22:03:27 +0200
Message-ID: <200707202203.27849.oliver__26062.1420959525$1184961829$gmane$org@neukum.org>
References: <Pine.LNX.4.44L0.0707201408060.2546-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0707201408060.2546-100000@iolanthe.rowland.org>
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
To: Alan Stern <stern@rowland.harvard.edu>
Cc: David Lang <david@lang.hm>, LKML <linux-kernel@vger.kernel.org>, Milton Miller <miltonm@bga.com>, Ying Huang <ying.huang@intel.com>, linux-pm <linux-pm@lists.linux-foundation.org>, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

Am Freitag 20 Juli 2007 schrieb Alan Stern:
> Some drivers need the ability to schedule. =A0Some will need the abilit=
y=20
> to allocate memory (although GFP_ATOMIC is probably sufficient). =A0Som=
e=20
> will need timers to run.

Some will have to request firmware. It can add up to some megabytes.
In addition, if we don't freeze, some drivers, eg. video drivers, can
do allocations in the megabyte range.

It seems to me that without the freezer we will end up with many drivers
needing a two step notification process. Furthermore there are requiremen=
ts
on the order of shutting down system facilities, eg. device addition must
be stopped before drivers allocate firmware.

	Regards
		Oliver
