From: Pavel Machek <pavel@ucw.cz>
Subject: Re: PowerOp Design and working patch
Date: Tue, 8 Aug 2006 15:52:47 +0200
Message-ID: <20060808135247.GA4624@elf.ucw.cz>
References: <200608081344.k78DiY0t002356@olwen.urbana.css.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <200608081344.k78DiY0t002356@olwen.urbana.css.mot.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Scott E. Preece" <preece@motorola.com>
Cc: daviado@gmail.com, linux-pm@lists.osdl.org, dsingleton@mvista.com
List-Id: linux-pm@vger.kernel.org

Hi!

A: No.
Q: Should I top-post?

> If you're a device manufacturer, and you build, say 50 devices that all
> use the same hardware but, because they are optimized for different
> functional use cases, have different preferred operating points and
> DVFS policies, it's *highly* desirable to not have to maintain 50
> separate builds for those devices.  Putting configuration information
> in places that can be changed independently of compilation is very
> important to us.

You'll still need to maintain 50 different userlands, so I do not
think that issue is _so_ important.

Anyway, lets get in core first, than talk about userspace interface
for chanig operating points, ok?
							Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
