From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [4/4] 2.6.23-rc5: known regressions v2
Date: Sat, 8 Sep 2007 15:01:04 +0200
Message-ID: <20070908130104.GA23408__22338.2986303934$1189256445$gmane$org@uranus.ravnborg.org>
References: <46E27DEF.7060109@googlemail.com> <46E2835E.9010408@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <46E2835E.9010408@googlemail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: Soeren Sonnenburg <kernel@nn7.de>, kbuild-devel@lists.sourceforge.net, Arkadiusz Miskiewicz <arekm@maven.pl>, Roman Zippel <zippel@linux-m68k.org>, Thomas Voegtle <tv@lio96.de>, LKML <linux-kernel@vger.kernel.org>, Christian Leber <christian@leber.de>, "Robert P. J. Day" <rpjday@mindspring.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi Michal.

> Kconfig/Kbuild
> 
> Subject         : building a specific in-tree module is currently a bit broken
> References      : http://lkml.org/lkml/2007/9/5/40
> Last known good : ?
> Submitter       : Robert P. J. Day <rpjday@mindspring.com>
> Caused-By       : ?
> Handled-By      : Sam Ravnborg <sam@ravnborg.org>
> Status          : problem is being debugged

Known bug there has been there for ages so this is not a regression.
I suggest removing it from this list - and I will see to have
it fixed for 2.6.24.
I will not push any fix for -rc for this.

	Sam
