From: David Brownell <david-b@pacbell.net>
Subject: Re: Power Mangement Interfaces
Date: Sat, 31 Mar 2007 09:57:48 -0700
Message-ID: <200703310957.49409.david-b@pacbell.net>
References: <20070330235759.GC4252@cosmic.amd.com>
	<1175300283.23438.38.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1175300283.23438.38.camel@johannes.berg>
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
To: linux-pm@lists.linux-foundation.org
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-pm@lists.osdl.org, devel@laptop.org, linux-acpi@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Friday 30 March 2007 5:18 pm, Johannes Berg wrote:
> On Fri, 2007-03-30 at 17:57 -0600, Jordan Crouse wrote:

> About different possible states: I think each of those can have
> different possible wakeup sources, ACPI can afaik go to S4 and still be
> able to configure the wakeup sources. So I suppose this really needs to
> be something like /sys/power/wakeup/<state>/<event> then where <state>
> is one of (currently) "mem", "disk" and "standby".

Nobody has yet been able to demonstrate user benefit from exposing
that level of complexity to userspace.

To the contrary, it seems enough to just expose a boolean flag saying
whether a given device should try to be a wakeup event source.  If
the hardware won't allow that in the target system state, so be it;
there's no way software can change that.


> And then change the =

> interface of pm_register_wakeup_source to include the state.

We don't need such a new interface.

- Dave
