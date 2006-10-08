From: Pavel Machek <pavel@suse.cz>
Subject: Re: Alternative Concept [Was: Re: [RFC] CPUFreq PowerOP
	integration, Intro 0/3]
Date: Sun, 8 Oct 2006 07:16:49 +0000
Message-ID: <20061008071649.GB5672@ucw.cz>
References: <44ECFF94.3030506@gmail.com>
	<20061007023620.GD30380@dominikbrodowski.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <20061007023620.GD30380@dominikbrodowski.de>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: pm list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> F) So, how would this work for OMAP1?
> =

> Let's limit it, to keep it somewhat simple, to the values contained in yo=
ur
> "struct pm_core_point" for OMAP:
> =

> 	int cpu_vltg; /* voltage in mV */
> 	int dpll;     /* in KHz */
> 	int cpu;      /* CPU frequency in KHz */
> 	int tc;       /* in KHz */
> 	int per;      /* in KHz */
> 	int dsp;      /* in KHz */
> 	int dspmmu;   /* in KHz */
> 	int lcd;      /* in KHz */
> =

> and let's also add a
> =

> 	int i_am_special;

Hehe, nice idea.

> I think that this might be much easier to implement than your PowerOP /
> operating points / PM core / PowerOP - cpufreq interaction patches. As a
> matter of fact, some parts of your operating points table infrastructure
> may be usable for the concept outlined above. So, what do you think? What
> does everyone else involved think about this alternative approach?

Looks okay to me. Unlike powerop design, this actually works for
everyone.
-- =

Thanks for all the (sleeping) penguins.
