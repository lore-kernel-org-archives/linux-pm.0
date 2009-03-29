From: "Tvrtko A. Ursulin" <tvrtko@ursulin.net>
Subject: Re: [Regression in 2.6.29] forcedeth doesn't work after
	resume from hibernation (was: Re: Resume after hibernation
	regression in 2.6.29)
Date: Sun, 29 Mar 2009 09:03:57 +0100
Message-ID: <200903290903.57911.tvrtko__9752.55358866907$1238314071$gmane$org@ursulin.net>
References: <200903261920.32173.tvrtko@ursulin.net>
	<200903271255.36429.rjw@sisk.pl> <200903272109.21259.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200903272109.21259.rjw@sisk.pl>
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
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Ayaz Abdulla <aabdulla@nvidia.com>, Ed Swierk <eswierk@arastra.com>, "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org, kernel list <linux-kernel@vger.kernel.org>, Tobias Diedrich <ranma+kernel@tdiedrich.de>, Arthur Jones <ajones@riverbed.com>, linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Friday 27 March 2009 20:09:20 Rafael J. Wysocki wrote:
> I was able to reproduce the problem and identify the commit that broke the
> resume of forcedeth, which turned out to be:
>
> commit cb52deba12f27af90a46d2f8667a64888118a888
> Author: Ed Swierk <eswierk@arastra.com>
> Date:   Mon Dec 1 12:24:43 2008 +0000
>
>     forcedeth: power down phy when interface is down
>
>     Signed-off-by: Ed Swierk <eswierk@arastra.com>
>     Tested-by: Arthur Jones <ajones@riverbed.com>
>     Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>     Signed-off-by: David S. Miller <davem@davemloft.net>
>
> Since I have no slightest idea of what this commit is supposed to achieve,
> I can only ask for reverting it.  It reverts cleanly, BTW.

Reverting this fixes it for me as well.

Thanks for your effort!

Tvrtko
