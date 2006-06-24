From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Fri, 23 Jun 2006 20:30:10 -0700
Message-ID: <200606232030.11497.david-b@pacbell.net>
References: <Pine.LNX.4.44L0.0606211219170.6700-100000@iolanthe.rowland.org>
	<Pine.LNX.4.64.0606231622580.6483@g5.osdl.org>
	<Pine.LNX.4.64.0606231706180.6483@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606231706180.6483@g5.osdl.org>
Content-Disposition: inline
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
Cc: linux-pm@lists.osdl.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Friday 23 June 2006 5:10 pm, Linus Torvalds wrote:
> =

> It's clear that people who I thought should know better are just too used =

> to the status quo, and as such, any change is automatically a bad thing.

Loosely defined changes are hard to support.  It's unclear which of the not=
ions
(or versions thereof) that have been discussed are ones you're actually sug=
gesting
should happen, or what the overall impact of them would be.


> I think it's a failure that I have to do things like that myself, but in =

> the end, I don't much care. I've fixed up USB and PCMCIA messes for the =

> same reasons in the past.

So have we all.  It makes us want to avoid large scale changes that cause
a need to retest things, since adequate retesting even on _one_ of the
affected platform configurations can take so long.

- Dave
