From: "Scott E. Preece" <preece@motorola.com>
Subject: Re: Alternative Concept
Date: Thu, 15 Mar 2007 08:21:28 -0500 (CDT)
Message-ID: <200703151321.l2FDLSWX029751@olwen.urbana.css.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-reply-to: "Scott E. Preece"'s message of Wed, 14 Mar 2007 17:08:56 -0500
	(CDT)
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: preece@motorola.com
Cc: linux-pm@lists.osdl.org, linux@dominikbrodowski.net, pavel@ucw.cz
List-Id: linux-pm@vger.kernel.org


| From: "Scott E. Preece" <preece@motorola.com>
| =

| | From: David Brownell<david-b@pacbell.net>
| | =

| | I couldn't know.  This "alternative concept" hasn't gotten very far
| | into the hand-waving stage, much less beyond it into proposed interface
| | or (gasp!) implementations.  Platforms that don't *have* those particul=
ar
| | interdependencies should not of course incur costs to implement them...
| ---
| =

| Well, that's fine if the platform you use is the current design
| center. For the rest of us, though, all the stuff you're currently
| doing for power management is wasted effort and why should we incur
| costs to work around them?  Today, we just configure it all out and put
| in our own stuff. We would prefer to have a mainstream framework that
| could be used to meet both Intel laptop needs and embedded device needs...
---

I have to apologize for this comment. I wrote it in a hurry as I left
for a meeting and tried to condense too many thoughts and not enough
thinking into the number of words I had time to type.

The clock framework is reasonably inoffensive, and I think it might be
reasonable to retain the current interfaces for clock-like devices while
adding on support for dependency modeling.  Today the dependencies
behind the clocks aren't modeled anywhere visible (in our implementation
they are managed by low-level assembler interfaces). We would like to be
able to have a power management system that WAS aware of the
interdependencies and able to make decisions based on concerns deeper
than the current clock frequency. Part of the reson for this is to
enable portability of at least some parts of our PM code (we build
products on a number of platforms, each with different parts in similar
roles).

I agree with David that typed interfaces are highly preferable.  Moving
the typing to data (having a type field associated with nodes in a
network) is more dangerous and less readable, at least in the absence of
a language with first-class classes and inheritance. So, I would prefer
to see the model have different kinds of nodes for different kinds of
devices; that should be possible while using common mechanisms for
implementing the dependencies between them.

However, I think it would be more appropriate to debate that when there
is a proposal for interfaces and at least a little bit of code. It is
possible that the current clock framework would appear broken in
comparison to something that was clearly superior. We don't know, yet,
whether what is proposed will look clearly superior, so it's probably
too early to argue about that aspect. The goal at this point was just to
surface the underlying concepts and see if people thought they
adequately model the problem space.

scott

-- =

scott preece
motorola mobile devices, il67, 1800 s. oak st., champaign, il  61820  =

e-mail:	preece@motorola.com	fax:	+1-217-384-8550
phone:	+1-217-384-8589	cell: +1-217-433-6114	pager: 2174336114@vtext.com
