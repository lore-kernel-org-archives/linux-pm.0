From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v2] pm_ops: add system quiesce/activate hooks
Date: Thu, 12 Apr 2007 12:16:53 +0200
Message-ID: <20070412101653.GB26473@elf.ucw.cz>
References: <1175810054.3489.34.camel@johannes.berg>
	<1176306867.19348.4.camel@johannes.berg>
	<461D494D.3080808@gmail.com>
	<1176367352.5764.2.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1176367352.5764.2.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-pm <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> > I doubt your reasoning is cogent enough. If you add such a global thing,
> > you should prove it, or clearly explain what is the thing for.
> > I don't believe that it's not possible to solve that decrementer case
> > without this change. Can't you add appropriate platform_device which
> > would register early enough, to meet that timing requirement when it
> > gets suspended?
> =

> That's would be absolutely disgusting... (relying on magic ordering of
> platform devices).

Adding platform hook to disable interrupts just because we need one
platform device last is not nice, either. (And does decrementer even
need to come last?)

Anyway, platform devices may need specific ordering on more than power
pc, so perhaps we should just make ordering more stable so that
relying on it is no longer a hack?
									Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
