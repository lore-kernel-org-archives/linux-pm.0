From: Julien Cristau <jcristau@debian.org>
Subject: Re: [PATCH] DRM / i915: Fix resume regression on MSI
 Wind U100 w/o KMS
Date: Mon, 11 Jan 2010 21:43:55 +0000
Message-ID: <20100111214355.GA11456__8235.2809644819$1263263946$gmane$org@radis.liafa.jussieu.fr>
References: <201001090045.33784.rjw@sisk.pl>
	<20100111083825.4c2bb7b3@jbarnes-piketon>
	<21d7e9971001111212h1ded5292l94d514c6f5a47cd4@mail.gmail.com>
	<201001112204.36724.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201001112204.36724.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Dave Airlie <airlied@linux.ie>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, pm list <linux-pm@lists.linux-foundation.org>, dri-devel@lists.sourceforge.net, Dave Airlie <airlied@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Mon, Jan 11, 2010 at 22:04:36 +0100, Rafael J. Wysocki wrote:

> Hmm, are you trying to say radeon is better at that?
> 
> My experience is quite the opposite to be honest.
> 
radeon kms is in staging, doesn't pretend to be stable and force all
users to the experimental paths.  So yes, I would say radeon is better
at that.

Cheers,
Julien
