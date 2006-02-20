From: Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: [PATCH 3/5] [pm] Respect the actual device power
	states in sysfs interface
Date: Sun, 19 Feb 2006 16:36:34 -0800 (PST)
Message-ID: <Pine.LNX.4.50.0602191628270.8676-100000@monsoon.he.net>
References: <Pine.LNX.4.50.0602171758160.30811-100000@monsoon.he.net>
	<20060218155543.GE5658@openzaurus.ucw.cz>
	<Pine.LNX.4.50.0602191557520.8676-100000@monsoon.he.net>
	<20060220000907.GE15608@elf.ucw.cz>
	<Pine.LNX.4.50.0602191611130.8676-100000@monsoon.he.net>
	<20060220002053.GF15608@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============34828739124353492=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060220002053.GF15608@elf.ucw.cz>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@suse.cz>
Cc: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org, linux-pm@osdl.org
List-Id: linux-pm@vger.kernel.org

--===============34828739124353492==
Content-Type: TEXT/PLAIN; charset=US-ASCII


On Mon, 20 Feb 2006, Pavel Machek wrote:

> On Ne 19-02-06 16:17:01, Patrick Mochel wrote:

> > I really fail to see what your fundamental objection is. This restores
> > compatability, makes the core simpler, and adds the ability to use the
> > additional states, should drivers choose to implement them; all for
> > relatively little code. It seems a like a good thing to me..
>
> Compatibility is already restored.

No, the interface is currently broken. The driver core does not dictate
what values are valid or invalid. It is meant to be used by the bus
drivers to help provide a simiar interface as each other, and to reduce
duplicate code.

It should not be filtering the value. Period. That is a policy decision,
and what is worse, is that it is a static, hard-coded policy decision. The
decision to only accept "0", "2", or "3" is a decision that should be made
on a bus-by-bus basis.

> Introducing additional states should be done in right way, something
> we can keep long-term.

Yup, and it starts with the core not deciding what values are wrong or
right.

Thanks,


	Pat

--===============34828739124353492==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============34828739124353492==--
