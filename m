From: David Brownell <david-b@pacbell.net>
Subject: Re: suspend and hibernate nomenclature
Date: Mon, 8 May 2006 16:47:54 -0700
Message-ID: <200605081647.55275.david-b@pacbell.net>
References: <1147024930.16057.3.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8498625816335259=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1147024930.16057.3.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linux-pm@lists.osdl.org, richard@hughsie.com
List-Id: linux-pm@vger.kernel.org

--===============8498625816335259==
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

One thing that doesn't seem right at all:  you suggest using the same
name for the "standby" and "suspend to RAM" states.  Those are both
different types of "suspend" states, as distinct from "hibernate"/swsusp
states (which are types of power-off).

That wiki page has an assertion that both "standby" and "suspend-to-RAM"
are bad names.  Maybe; but they're also the names that MS-Windows users have
been trained to expect, so fighting against them (and hiding them even in
explanations) isn't necessarily good.

But they are still distinctly different states, and if you don't expose
both of them to users, then you'd be effectively preventing use of one
of the two states.  And if power savings is a goal, that's ungood.  On
embedded systems, there are lots of variants of "standby", and analogues
of "suspend to RAM" can be hard to enter.

One suggestion might be to talk about how deeply the system is suspended;
"light suspend" (standby) or "deep suspend" (suspend-to-RAM).  That could
work well with the non-PC/non-ACPI/non-ACPI type of systems too, where
there may well be several more types of "suspend" state than just those
two, and no analague of "hibernate".  (Noted also by Scott Preece...)

- Dave


--===============8498625816335259==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============8498625816335259==--
