From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC] dynamic device power management proposal
Date: Thu, 22 Mar 2007 10:45:22 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0703221039001.3605-100000@iolanthe.rowland.org>
References: <200703221339.l2MDdejg007459@olwen.urbana.css.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200703221339.l2MDdejg007459@olwen.urbana.css.mot.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Scott E. Preece" <preece@motorola.com>
Cc: linux-pm@lists.osdl.org, pavel@ucw.cz
List-Id: linux-pm@vger.kernel.org

On Thu, 22 Mar 2007, Scott E. Preece wrote:

> I would normally call designs that expect important functions (like
> power on/power off) to happen as side effects of other operations (like
> opening and closing files) broken to begin with. It's still a bad idea
> to hide policy inside the driver.

Even though other people have already answered this, I'd like to add my =

own comments.

Firstly, doing power on/power off as side effects of other operations is =

_not_ a policy choice.  It is a design principle:

	When device D has been idle for more than N ms, it should be
	put in a low-power state (unless such state changes have been
	disabled for D by userspace).

Of course N will vary for different D's, and the exact choice of N _is_
policy.  Thus N should be exposed and configurable by userspace.  So
should the ability to disable the state changes.  But the principle
above isn't a policy, it is part of the design.

Secondly, this principle _requires_ that power on/power off occur as side =

effects of other operations, since those other operations affect whether =

or not the device is idle.

If anybody wants to argue against the principle itself, then go ahead and
say so.  I, for one, don't see anything objectionable about it.

Alan Stern
