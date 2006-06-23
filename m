From: David Brownell <david-b@pacbell.net>
Subject: Re: cpufreq-related updates [WAS: Fix console handling
	during	suspend/resume]
Date: Fri, 23 Jun 2006 16:54:58 -0700
Message-ID: <200606231654.58578.david-b@pacbell.net>
References: <Pine.LNX.4.44L0.0606211219170.6700-100000@iolanthe.rowland.org>
	<200606231448.32927.david-b@pacbell.net>
	<20060623221026.GA30332@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060623221026.GA30332@kroah.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Greg KH <greg@kroah.com>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-pm@lists.osdl.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

Thanks for explaining that "PCI resource rebalancing" thing.

On Friday 23 June 2006 3:10 pm, Greg KH wrote:
> 	 I'm guessing that Adam is thinking that the
> suspend/freeze/whatever-you-want-to-call-it model might be the one to
> help with this issue.

I see.   Though I don't much like adding new driver callbacks, this may
be a case where they're appropriate ... so the PCI rebalancing code could
have logic like "don't rebalance devices whose pci_driver can't cooperate".

That same argument might be applied to the reclocking issue.  Not that
we have systems that need driver reclocking just now ... but that issue
does keep coming up.

- Dave
