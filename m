From: Mark Gross <mgross@linux.intel.com>
Subject: Re: Alternative Concept
Date: Tue, 13 Mar 2007 13:34:58 -0700
Message-ID: <20070313203458.GA1213@linux.intel.com>
References: <44ECFF94.3030506@gmail.com>
	<20061007023620.GD30380@dominikbrodowski.de>
	<CFF99858-3B0C-4492-807E-B61E9CA891E5@nomadgs.com>
	<20070313110851.GB10702@elf.ucw.cz>
Reply-To: mgross@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <20070313110851.GB10702@elf.ucw.cz>
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
Cc: Eugeny Mints <eugeny@nomadgs.com>, pm list <linux-pm@lists.osdl.org>, Dominik Brodowski <linux@dominikbrodowski.net>
List-Id: linux-pm@vger.kernel.org

On Tue, Mar 13, 2007 at 12:08:51PM +0100, Pavel Machek wrote:
> Hi!
> =

> > I believe this power parameter framework should solve many (if not  =

> > all) of the issues raised by using operating points as the base  =

> > abstraction and provide a common layer across architectures.  Eugeny  =

> > and I have the beginnings of an API proposal for this framework, but  =

> > we wanted to get some high level feedback on the concepts so we can  =

> > adjust the API if necessary.  So, comments?
> =

> Looks better than powerop certainly.
> =

> Perhaps first step would be to convert cpufreq to this new framework?

The first step is to get a parameter framework in upstream.  =


It will take some time for the applications of this proposed framework
to materialize and drive the maturing of the implementation.  These
won't get written unless a framework is upstream. =


I don't know if having cpufreq plug into this framework will ever make a
lot of sense.  However; it would be simple to create a cpufreq driver
that access the parameter layer for some selected platforms.  (N800?)

--mgross
