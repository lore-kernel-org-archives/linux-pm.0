From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFC] dynamic device power management proposal
Date: Thu, 22 Mar 2007 12:28:44 -0700
Message-ID: <200703221228.44642.david-b@pacbell.net>
References: <Pine.LNX.4.44L0.0703191135360.14222-100000@iolanthe.rowland.org>
	<200703220042.20471.lenb@kernel.org>
	<1174564606.4935.6.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1174564606.4935.6.camel@localhost>
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
To: linux-pm@lists.linux-foundation.org, jg@laptop.org
List-Id: linux-pm@vger.kernel.org

On Thursday 22 March 2007 4:56 am, Jim Gettys wrote:

> On system suspend, we may not want to suspend all devices; we may need
> to leave certain devices alone, and only power down the host interface
> to them.
> =

> Upon system resume, therefore, devices may also *not* need to be
> resumed; only the host interface to them powered up again.
> =

> We have two devices in the OLPC machine in this class: our screen, and
> our wireless, both of which will often/usually be left on while the rest
> of the sysetm is suspended.

I'm suspecting this is an area where Linux doesn't yet do what you
need to be done.  Right?

Of course, one model here is that this "suspend" is not the same as
an "echo something > /sys/power/state" ... that you'd be using runtime
power management, and just opportunistically notice that the system is
going to be idle for a while so that with CONFIG_NO_HZ your system idle
loop could shut down various things (CPU, maybe more).

- Dave
