From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch] suspend/resume self-test
Date: Tue, 19 Feb 2008 11:12:57 -0800
Message-ID: <200802191112.57616.david-b__24025.7488716908$1203448568$gmane$org@pacbell.net>
References: <20080130131748.GA3796@elf.ucw.cz>
	<20080219101116.GA2202@elf.ucw.cz> <20080219144328.GD21176@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080219144328.GD21176@elte.hu>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-pm@lists.linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tuesday 19 February 2008, Ingo Molnar wrote:
> * Pavel Machek <pavel@ucw.cz> wrote:
> =

> > > Thing is, this will catch not just regressions ... but cases where =

> > > STR never worked in the first place. =A0Video problems, etc. =A0Also =

> > > various system startup races, as in the PCMCIA and MMC/SD/SDIO cases =

> > > I noted.
> > =

> > David is right here. At minimum, s2ram needs acpi_sleep=3D... options t=
o =

> > tell it how to set up the video. That is not issue for you, but it =

> > means we should not be doing it by default.
> =

> nowhere did i suggest that it should be default-enabled ...

The patch you asked to be merged *DID* have it be default-enabled!
So you did more than just "suggest"... if that option is enabled in
Kconfig, this test is always forced on and it will cause failures
on systems where STR has never worked.

The patch comments even pointed out that flaw.
