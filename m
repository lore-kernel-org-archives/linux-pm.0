From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFC] dynamic device power management proposal
Date: Thu, 22 Mar 2007 12:58:32 -0700
Message-ID: <200703221258.33306.david-b@pacbell.net>
References: <Pine.LNX.4.44L0.0703191135360.14222-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0703191135360.14222-100000@iolanthe.rowland.org>
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
List-Id: linux-pm@vger.kernel.org

On Monday 19 March 2007 8:44 am, Alan Stern wrote:
> On Mon, 19 Mar 2007, Shaohua Li wrote:
> =

> > ...
> > Basically we need device driver support, a kernel framework and a policy
> > (determine when to change a device=E2=80=99s power state).
> =

> A lot of development along these lines has already been going on in the =

> USB subsystem.  It isn't complete yet, but a lot of the ideas you raise =

> have already been implemented.

ISTR pointing out a few years ago that USB makes a good testbed for
such things, in technical terms ... it's got the "complete problem"
wrapped up in one more-or-less modern subsystem.  So making it do
PM well has been an object lesson in how the Linux PM infrastructure
works -- or, too often, doesn't.

The most troublesome spot being that ACPI interferes on PCs, so we
can't yet do stuff like put EHCI/OHCI/UHCI controllers into PCI_D2 at
runtime and rely on remote wakeup.   But embedded Linux systems make
it easy to work with saner frameworks; on those systems you can see
even more of the pieces working well together.  :)

- Dave
