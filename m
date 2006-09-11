From: Mark Gross <mgross@linux.intel.com>
Subject: Re: community PM requirements/issues and PowerOP [Was:
	Re: So, what's the status on the recent patches here?]
Date: Mon, 11 Sep 2006 14:53:03 -0700
Message-ID: <20060911215303.GA12176@linux.intel.com>
References: <450516E8.9010403@gmail.com> <20060911082025.GD1898@elf.ucw.cz>
Reply-To: mgross@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <20060911082025.GD1898@elf.ucw.cz>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@ucw.cz>
Cc: pm list <linux-pm@lists.osdl.org>, scott.preece@motorola.com
List-Id: linux-pm@vger.kernel.org

On Mon, Sep 11, 2006 at 10:20:25AM +0200, Pavel Machek wrote:
> Hi!
> =

> On Mon 2006-09-11 11:57:28, Eugeny S. Mints wrote:
> > [snip]
> > >> Are you arguing that the cpufreq interface be morphed to support pow=
er
> > >> op applications?
> > >
> > > No. I'm arguing that
> > >
> > > * cpufreq interface should be used for changing cpu frequency
> > the patch set i sent out has cpufreq used for changing cpu frequency,
> > hasn't it?
> =

> I was talking about kernel<->user interface.
> =

> You did echo low > something to change CPU frequency, IIRC.
> =

> > can we eventually start talking more close to the code rather than
> > speculating without it?
> =

> Lets get kernel<->user interface right, first. You'll need to create
> Documentation/ entries for your interfaces, eventually, so lets do
> that, first, and then talk about code. Oh and it would be nice to cc
> lkml on that document, too. New kernel<->user interface is not
> decision taken lightly.

Is this just trying delay power op getting into the kernel?  We are
building up / evolving a PM stack from bottom up and you want to the
high level interface to be well defined and agreed upon first?  =


I think the kernel user interface is important too but you are asking
for a complete solution stack when we are following an evolutionary
development process.  =


--mgross
