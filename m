From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Alternative Concept
Date: Tue, 13 Mar 2007 12:08:51 +0100
Message-ID: <20070313110851.GB10702@elf.ucw.cz>
References: <44ECFF94.3030506@gmail.com>
	<20061007023620.GD30380@dominikbrodowski.de>
	<CFF99858-3B0C-4492-807E-B61E9CA891E5@nomadgs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <CFF99858-3B0C-4492-807E-B61E9CA891E5@nomadgs.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Matthew Locke <matt@nomadgs.com>
Cc: Eugeny Mints <eugeny@nomadgs.com>, pm list <linux-pm@lists.osdl.org>, Dominik Brodowski <linux@dominikbrodowski.net>
List-Id: linux-pm@vger.kernel.org

Hi!

> I believe this power parameter framework should solve many (if not  =

> all) of the issues raised by using operating points as the base  =

> abstraction and provide a common layer across architectures.  Eugeny  =

> and I have the beginnings of an API proposal for this framework, but  =

> we wanted to get some high level feedback on the concepts so we can  =

> adjust the API if necessary.  So, comments?

Looks better than powerop certainly.

Perhaps first step would be to convert cpufreq to this new framework?

								Pavel

-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
