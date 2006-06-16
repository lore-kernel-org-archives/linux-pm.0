From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/2] Fix console handling
	during	suspend/resume
Date: Fri, 16 Jun 2006 18:01:14 +1000
Message-ID: <1150444874.23600.41.camel@localhost.localdomain>
References: <Pine.LNX.4.64.0606131418580.5498@g5.osdl.org>
	<Pine.LNX.4.64.0606131435400.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606131435400.5498@g5.osdl.org>
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

On Tue, 2006-06-13 at 14:40 -0700, Linus Torvalds wrote:
> The old code was terminally broken, and would do extremely bad things if =

> you used netconsole, for example. Like sending out packets when the devic=
e =

> had already been suspended etc.
> =

> The new version may not be perfect either, but it seems fundamentally lik=
e =

> a better design: we just hold on to the primary console semaphore over th=
e =

> whole suspend event, forcing printk() to just buffer up its data until we =

> can show it again. The code is also much simpler and more obvious.
> =

> This can potentially make debugging harder when something goes wrong at =

> suspend time and a visible printk would have given us a hint _what_ went =

> wrong, but on the other hand, it makes fewer things go wrong. Oopses will =

> punch through the semaphore anyway, so serious problems aren't affected b=
y =

> this.

While the idea is nice for kernel console, we still need the console
switch for X. Unless you have some kind of APM emulation (which we do
have on ppc) in which case X should get notified of suspend and resume,
and will try to save/restore itself properly, not switching consoles is
a guarantee of X blowing up in many situations. (Your patch as-is broke
suspend/resume on pretty much all powermacs for example with X).

It's especially bad if you use things like AGP and DRI... =


Ben.
