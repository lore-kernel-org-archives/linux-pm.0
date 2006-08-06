From: Pavel Machek <pavel@ucw.cz>
Subject: Re: PowerOp Design and working patch
Date: Sun, 6 Aug 2006 22:11:05 +0000
Message-ID: <20060806221104.GB4205@ucw.cz>
References: <c6333353f00bb7fd435ef518dc8cee21@mvista.com>
	<20060729004546.GA3917@kroah.com>
	<1c70fd37e4eb876295e0194e2b8725d6@mvista.com>
	<44CBB1E0.3030908@gmail.com>
	<62e4476a851bbed395b509023edc5c5c@mvista.com>
	<acd2a5930607300402n13890dbg150315f617c86ffd@mail.gmail.com>
	<b04f25ff9b3eb8a48cad52ee832d5bf2@mvista.com>
	<215c230e2979117fd14d83ea2fd83054@embeddedalley.com>
	<287a694aae15b3fba505f4381c95c9c8@mvista.com>
	<44CFA2F5.1070707@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <44CFA2F5.1070707@am.sony.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Tim Bird <tim.bird@am.sony.com>
Cc: David Singleton <daviado@gmail.com>, linux-pm@lists.osdl.org, david singleton <dsingleton@mvista.com>
List-Id: linux-pm@vger.kernel.org

Hi!

> >>Well, no one is suggesting a user define and install that info.  =

> >>Operating point creation will be done by someone who understands the =

> >>system (system designer) regardless of the method used to get the =

> >>operating points in the kernel.
> > =

> > It sounds to me like they don't want to have to change kernel code and =

> > recompile the kernel
> > to get a new operating point.
> > =

> > It sounds like they are talking about a dynamic operating point as a =

> > loadable
> > module, which would fit perfectly with the PowerOp scheme, since it's =

> > the
> > system designer who would be creating the new  dynamic operating point,
> > not the user.
> =

> Often, in the embedded world, the person defining the operating
> states will not be a kernel developer, and may not be comfortable
> with, or capable of, creating a kernel module.  (There are

That's okay, we can create HOWTO or something. 'System designed is too
stupid to hack kernel' should not be an argument.

Maybe operating points need to be changed at runtime -- I do not think
so -- but *please* get the basic stuff in/merged ASAP and then add
features one-by-one.
						Pavel
-- =

Thanks for all the (sleeping) penguins.
