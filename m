From: Igor Stoppa <igor.stoppa@nokia.com>
Subject: Re: PowerOp Design and working patch
Date: Tue, 08 Aug 2006 14:12:02 +0300
Message-ID: <1155035522.11382.64.camel@Dogbert.NOE.nokia.com>
References: <1c70fd37e4eb876295e0194e2b8725d6@mvista.com>
	<44CBB1E0.3030908@gmail.com><62e4476a851bbed395b509023edc5c5c@mvista.com>
	<acd2a5930607300402n13890dbg150315f617c86ffd@mail.gmail.com>
	<b04f25ff9b3eb8a48cad52ee832d5bf2@mvista.com>
	<215c230e2979117fd14d83ea2fd83054@embeddedalley.com>
	<287a694aae15b3fba505f4381c95c9c8@mvista.com><44CFA2F5.1070707@am.sony.com>
	<20060806221104.GB4205@ucw.cz><44D7985B.6080508@am.sony.com>
	<20060808100723.GC4442@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060808100723.GC4442@elf.ucw.cz>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: ext Pavel Machek <pavel@ucw.cz>
Cc: David Singleton <daviado@gmail.com>, linux-pm@lists.osdl.org, david singleton <dsingleton@mvista.com>
List-Id: linux-pm@vger.kernel.org

On Tue, 2006-08-08 at 13:07 +0300, ext Pavel Machek wrote:
> Hi!
> =

> > >> Often, in the embedded world, the person defining the operating
> > >> states will not be a kernel developer, and may not be comfortable
> > >> with, or capable of, creating a kernel module.  (There are
> > >
> > > That's okay, we can create HOWTO or something. 'System designed is
> too
> > > stupid to hack kernel' should not be an argument.
> >
> > It's not a matter of stupidity.  The example I gave of not being
> > able to create a kernel module was the situation where loadable
> > module support is not available.  A HOWTO wouldn't alter this.
> =

> So they need to recompile the kernel. Not a big deal when you are
> developing new machine.
> =

1 time yes, several maybe, thousands no.

think about it as finding minimums in a n-dimensional discrete function:
you really don't want to recompile a kernel each time

-- =

Cheers,
           Igor

Igor Stoppa (Nokia M - OSSO / Tampere)
