From: Mark Gross <mgross@linux.intel.com>
Subject: Re: community PM requirements/issues and PowerOP [Was:
	Re: So, what's the status on the recent patches here?]
Date: Mon, 11 Sep 2006 17:00:00 -0700
Message-ID: <20060912000000.GB14234@linux.intel.com>
References: <450516E8.9010403@gmail.com> <20060911082025.GD1898@elf.ucw.cz>
	<20060911215303.GA12176@linux.intel.com>
	<20060911224313.GA13536@elf.ucw.cz>
Reply-To: mgross@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <20060911224313.GA13536@elf.ucw.cz>
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

On Tue, Sep 12, 2006 at 12:43:13AM +0200, Pavel Machek wrote:
> On Mon 2006-09-11 14:53:03, Mark Gross wrote:
> > On Mon, Sep 11, 2006 at 10:20:25AM +0200, Pavel Machek wrote:
> > > Lets get kernel<->user interface right, first. You'll need to create
> > > Documentation/ entries for your interfaces, eventually, so lets do
> > > that, first, and then talk about code. Oh and it would be nice to cc
> > > lkml on that document, too. New kernel<->user interface is not
> > > decision taken lightly.
> > =

> > Is this just trying delay power op getting into the kernel?  We are
> > building up / evolving a PM stack from bottom up and you want to the
> > high level interface to be well defined and agreed upon first?
> =

> As long as you do not introduce _any_ user<->kernel interfaces within
> patch series, going without Documentation is okay. But IIRC that was
> not the case.
> =


I don't think providing Documentation on whatever interface will be a
problem.

--mgross
