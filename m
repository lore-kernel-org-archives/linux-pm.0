From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Re: [PATCH/rfc] schedule /sys/device/.../power for
	removal
Date: Sun, 14 May 2006 10:21:56 +1000
Message-ID: <1147566116.21291.25.camel@localhost.localdomain>
References: <20060512100544.GA29010@elf.ucw.cz>
	<20060512031151.76a9d226.akpm@osdl.org>
	<200605120652.55658.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============45889267877119932=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200605120652.55658.david-b@pacbell.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: David Brownell <david-b@pacbell.net>
Cc: Andrew Morton <akpm@osdl.org>, linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

--===============45889267877119932==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


> I think both Patrick Mochel and Alan Stern have sent patches at
> various times to let individual drivers provide a list of named
> states they support,  In some cases (like PCI) those lists could
> be delegated to bus-specific code.

I've several times expressed my opinion there that it's not bus states
that should be exposed by a driver but the actual states that the
driver/device combination supports _regardless_ of what bus state they
map to (if any). Bus states simply mean nothing at this point (Unless
you are the bus driver). Of course we need both top-down and bottom-up
dependency mecanisms to handle state changes, but at the user level, a
given PCI driver shouldn't expose something like "D1", "D2" and "D3"...
those are PCI states that don't have a well defined semantics (and may
not be all supported by the device/driver). However, it's whatever
functional states that device/driver supports that shall be exposed.
Those can be "idle" and "suspended" for example, or there could be
several levels of "suspended".

Now of course, there is the problem that while such descriptive names
might have a sense to a user (and even then, only in one language,
english) they aren't very useful to some automated power management
mecanism.

That's the whole problem that needs solving, possibly by exposing as
much as the state dependencies as possible, along eventually with
informations such as can the device automatically trigger a transition
out of this state, eventually informations relative to max power
consumed in this state (not only embedded devices but also desktop
machines nowadays have fairly strick power budgets when entering global
system suspend), etc...

That was one of the goal of the mecanisms I described more than a year
ago with bit masks exposing bus state <-> device state dependencies,
though not a complete solution, it was more like a starting point to
think from.

Due to various personal matter I haven't followed up much on what came
next on this list or during the last PM summit, but from some of the
mails I'm reading, I have the feeling that there haven't been much
progress...

Ben
 


--===============45889267877119932==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============45889267877119932==--
