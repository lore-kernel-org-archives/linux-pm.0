From: Pavel Machek <pavel@suse.cz>
Subject: Re: Dynanic On-The-Fly Operating points for PowerOP
Date: Tue, 15 Aug 2006 19:44:34 +0000
Message-ID: <20060815194433.GF4032@ucw.cz>
References: <44D8D40F.50005@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <44D8D40F.50005@mvista.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: David Singleton <dsingleton@mvista.com>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

Hi!

>         2) The naming scheme for operating points has been unified to
>         provide a better interface to the PowerOp power manager daemon.
>         The names range from:
> =

>                         highest
>                         high
>                         medhigh
>                         medium
>                         medlow
>                         low
>                         lowest
> =

>         PowerOp maps the supported processor frequencies onto this
>         namespace list.  The set of centrino processors it supports have
>         supported sets of between four and six different operating points.
> =

>         The PowerOP daemon, coming soon, can simply read the supported
>         set of operating points and make some simple rules based
>         decisions about when to transition to various operating points.
> =

>         The goal of a unified name space is to provide a PowerOp manager
>         that runs out of the box, with very little setup by the user.

Well, we already have perfectly working API for frequency management,
why not use that?

-- =

Thanks for all the (sleeping) penguins.
