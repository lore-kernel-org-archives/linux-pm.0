From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 0/2] suspend-to-ram debugging patches
Date: Fri, 16 Jun 2006 10:45:49 +1000
Message-ID: <1150418749.7725.34.camel@localhost.localdomain>
References: <Pine.LNX.4.64.0606131418580.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606131418580.5498@g5.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: Power management list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org


> 	Some people may hate this, but what it does is to suspend the =

> 	console handling _properly_, so that if there are messages that =

> 	happen while the machine is suspending or resuming, they can =

> 	actually be printed out over a netconsole window, even if the =

> 	network device was part of the devices going down.

Nice to do that generically for all consoles ! I did something fbdev
specific a while ago for ppc macs (since their video chips goes D2 or D3
which is completely inaccessible and we don't do legacy VGA on those)
where the low level driver can instruct the fbdev layer that it's now
offline. Your stuff will probably make things even more reliable for me
too though.

> 	The reason people may hate it is that it actually means that we =

> 	don't print the messages at all when the machine is going down. We =

> 	really can't. Even VGA may be behind a bridge or something, and =

> 	trying to access it is just totally random luck. So the suspend =

> 	and resume actually gets a lot more quiet - but in the process it =

> 	actually gets more reliable.

But that's the only sane way to do it, I agree. One thing I did for mac
to help debugging is based on the knowledge that the Mac laptops / mini
video chip is always on the toplevel AGP bus (can be resumed without any
ordering constraint vs. another device except AGP), I've added a pair of
special platform hooks that the fbdev's can use to get resumed very very
early. I bit hackish but that has proven invaluable. Basically, radeon
registers a callback with the arch, which will then call it on resume
before anything else. (There are also similar callbacks registered so
that the video driver can properly suspend/resume the AGP bridge in the
right order since that isn't possible with the "normal" AGP
suspend/resume hooks, as the AGP bridge isn't physically in a location
that ensure proper dependency with the video chip).

> 	This makes netconsole usable over a suspend/resume, for example, =

> 	instead of just oopsing or doing really bad things because we're =

> 	trying to use the network device at the same time that it's going =

> 	down.
> =

> 	When the resume is done, the normal printk() buffering will have =

> 	kept all the messages, so they are then printed when the devices =

> 	actually work again.
> =

> 	I suspect that we might want to have a "debug mode" that basically =

> 	doesn't stop the console at all, because sometimes the extra =

> 	messages are very useful, even if they sometimes also just help =

> 	break the suspend/resume further. That might make some of the =

> 	people who otherwise hate this happier.
> =

> Actual patches in the next two mails as replies to this one.
> =

> [ And note: I'm not on the linux-pm list, so please cc me with any useful =

>   commentary ]
> =

> 			Linus
> _______________________________________________
> linux-pm mailing list
> linux-pm@lists.osdl.org
> https://lists.osdl.org/mailman/listinfo/linux-pm
