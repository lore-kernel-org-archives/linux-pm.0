From: Greg KH <greg@kroah.com>
Subject: OpPoint summary
Date: Wed, 13 Sep 2006 22:55:29 -0700
Message-ID: <20060914055529.GA18031@kroah.com>
References: <20060911082025.GD1898@elf.ucw.cz>
	<b0623b9bb79afacc77cddc6e39c96b62@nomadgs.com>
	<20060911195546.GB11901@elf.ucw.cz> <4505CCDA.8020501@gmail.com>
	<20060911210026.GG11901@elf.ucw.cz> <4505DDA6.8080603@gmail.com>
	<20060911225617.GB13474@elf.ucw.cz>
	<20060912001701.GC14234@linux.intel.com>
	<20060912033700.GD27397@kroah.com>
	<b324b5ad0609131650q1b7a78cfsa90e3fbe8d7b4093@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <b324b5ad0609131650q1b7a78cfsa90e3fbe8d7b4093@mail.gmail.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: David Singleton <daviado@gmail.com>
Cc: linux-pm@lists.osdl.org, kernel list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Sep 13, 2006 at 04:50:43PM -0700, David Singleton wrote:
> Greg,
>   here's a few paragraphs about the power management code I'm working on.
> The OpPoint patch set is a fully functionaly power management solution,
> from kernel operating state support to userland power manager.

Thanks for the summary, but it was a bit longer than just "one
paragraph" :)

> OpPoint constructs operating points for all supported frequency, voltage
> and suspend states for PC and SoC solutions running Linux.  OpPoint
> does not break or replace cpufreq.  It leverages cpufreq code to provide
> the same driver scaling functions when cpu frequency changes affect drive=
rs.

So it works with cpufreq?  That's a good thing, as it is a requirement.
We can't just break current usages.

> OpPoint is a fully functional solution ready for testing and evaluation
> in Andrew's or your tree.
> =

> The kernel patches are available at:
> =

>        http://source.mvista.com/~dsingleton/2.6.1-rc6

I get a 404 with that link :(

Care to resend your patches in the proper format, through email so that
we can see them, and possibly get some testing in -mm if they look sane?

thanks,

greg k-h
