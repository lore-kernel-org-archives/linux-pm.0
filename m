From: Ed Swierk <eswierk@aristanetworks.com>
Subject: Re: [Regression in 2.6.29] forcedeth doesn't work after
	resume from hibernation (was: Re: Resume after hibernation
	regression in 2.6.29)
Date: Fri, 3 Apr 2009 08:24:12 -0700
Message-ID: <9ae48b020904030824o1f94831asb60f979b3e489a8b__40958.6573405706$1238777717$gmane$org@mail.gmail.com>
References: <200903261920.32173.tvrtko@ursulin.net>
	<200903270801.46712.tvrtko@ursulin.net>
	<200903271255.36429.rjw@sisk.pl> <200903272109.21259.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200903272109.21259.rjw@sisk.pl>
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
Cc: "Tvrtko A. Ursulin" <tvrtko@ursulin.net>, Ayaz Abdulla <aabdulla@nvidia.com>, netdev <netdev@vger.kernel.org>, kernel list <linux-kernel@vger.kernel.org>, Tobias Diedrich <ranma+kernel@tdiedrich.de>, "David S. Miller" <davem@davemloft.net>, Arthur Jones <ajones@riverbed.com>, linux-pm <linux-pm@lists.linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Mar 27, 2009 at 1:09 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> I was able to reproduce the problem and identify the commit that broke the
> resume of forcedeth, which turned out to be:
>
> commit cb52deba12f27af90a46d2f8667a64888118a888
> Author: Ed Swierk <eswierk@arastra.com>
> Date: =A0 Mon Dec 1 12:24:43 2008 +0000
>
> =A0 =A0forcedeth: power down phy when interface is down
>
> =A0 =A0Signed-off-by: Ed Swierk <eswierk@arastra.com>
> =A0 =A0Tested-by: Arthur Jones <ajones@riverbed.com>
> =A0 =A0Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> =A0 =A0Signed-off-by: David S. Miller <davem@davemloft.net>
>
> Since I have no slightest idea of what this commit is supposed to achieve,
> I can only ask for reverting it. =A0It reverts cleanly, BTW.

The change causes forcedeth to bring down the physical link when an
interface goes down; leaving it up causes the switch at the other end
to think the port is still active, with potentially random speed and
duplex parameters.

It's possible that the forcedeth driver needs to reset autonegotiation
after bringing it up the link again.

Can you please try this on a 2.6.29 kernel that's exhibiting the
symptoms you describe, after resuming the machine from hibernation:

  ethtool -s eth1 autoneg off speed 100 duplex full
  ethtool -s eth1 autoneg on

This should reset autonegotiation manually and bring the link. Let me
know how it goes.

Thanks,
--Ed
