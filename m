From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Fri, 23 Jun 2006 17:10:39 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606231706180.6483@g5.osdl.org>
References: <Pine.LNX.4.44L0.0606211219170.6700-100000@iolanthe.rowland.org>
	<200606221130.30614.david-b@pacbell.net>
	<Pine.LNX.4.64.0606221210350.5498@g5.osdl.org>
	<200606231106.46863.david-b@pacbell.net>
	<Pine.LNX.4.64.0606231216290.6483@g5.osdl.org>
	<20060623233244.GB4264@neo.rr.com>
	<Pine.LNX.4.64.0606231622580.6483@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606231622580.6483@g5.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Adam Belay <ambx1@neo.rr.com>
Cc: David Brownell <david-b@pacbell.net>, linux-pm@lists.osdl.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org



On Fri, 23 Jun 2006, Linus Torvalds wrote:
> =

> And IT'S ONLY DONE BECAUSE THE INTERFACE SUCKS!

Btw, I don't think I'm interested in arguing the point any more.

It's clear that people who I thought should know better are just too used =

to the status quo, and as such, any change is automatically a bad thing.

Me, I don't care. Happily, the whole point of open source is that you can =

change things. So rather than waste time explaining myself to people who =

can't admit that the current situation sucks, I'll just end up doing =

something productive - namely "Just Do It".

I think it's a failure that I have to do things like that myself, but in =

the end, I don't much care. I've fixed up USB and PCMCIA messes for the =

same reasons in the past.

One day maybe it turns out that I'll be wrong. We'll see. I doubt it's =

going to be this time.

		Linus
