From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: Re: [PATCH 01/13] PM: Add wake lock api.
Date: Thu, 12 Feb 2009 21:17:57 -0600
Message-ID: <13B9B4C6EF24D648824FF11BE89671620377169735@dlee02.ent.ti.com>
References: <1233802226-23386-1-git-send-email-arve@android.com>
	<200902112323.53421.rjw@sisk.pl>
	<d6200be20902111542r3592f64dt41a282221aed1268@mail.gmail.com>
	<200902122322.30864.rjw@sisk.pl>
	<13B9B4C6EF24D648824FF11BE89671620377169672@dlee02.ent.ti.com>
	<20090213011035.GA8664@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090213011035.GA8664@srcf.ucam.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: "ncunningham@crca.org.au" <ncunningham@crca.org.au>, "u.luckas@road.de" <u.luckas@road.de>, "swetland@google.com" <swetland@google.com>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org


> From: Matthew Garrett [mailto:mjg59@srcf.ucam.org]
> Sent: Thursday, February 12, 2009 7:11 PM

> On Thu, Feb 12, 2009 at 05:42:01PM -0600, Woodruff, Richard wrote:
>
> > It is discouraging to hear comments like "we have been talking about for
> years something else" yet nothing exists or is in open development. Things can
> evolve in place.
>
> This is userlad-visible ABI. We can't evolve it in place - we need to
> get it right before merging it, otherwise we need to carry on
> maintaining code for an extended period of time in order to ensure that
> there's no userland code that depends on it.

It would be nice to do something evil and require a handshake which generates a random but unique string in sysfs at leaf level for interface. Making the namespace generation to be a bit more of a protocol instead of string matching might force a bit more flexible user space.

There are examples like syscalls of things which seem to grow with out huge contention.

> I dislike the kernel-side use of wakelocks. They're basically equivalent
> to a device returning -EBUSY during the suspend phase, which is
> something that can be done without any kernel modifications. I'm more
> interested in the userspace side, but I'd like to know more about what
> sort of constraints userspace is likely to impose. In general kernel
> people respond better to a "Here is a problem statement, here is our
> proposed solution" type statement than "Here is our code".

It is far better to get -EBUSY at the start of the suspend call out then at the end. Latency is less and not all drivers behave so well when resuming from a partial suspend.

I also agree kernel space could have been different and user space is interesting. However, I'm one to appreciate function over form. When you get them both its zen, but if is pretty and doesn't work its useless.

Thanks,
Richard W.
