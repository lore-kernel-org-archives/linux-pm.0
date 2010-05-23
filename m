From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [Regression][git head f4b87dee9] ath9k doesn't work
	correctly after resume from suspend to RAM
Date: Mon, 24 May 2010 00:40:57 +0200
Message-ID: <201005240040.57443.rjw__19052.5428778075$1274654457$gmane$org@sisk.pl>
References: <201005222353.26920.rjw@sisk.pl> <201005230013.37578.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201005230013.37578.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "John W. Linville" <linville@tuxdriver.com>
Cc: Daniel Yingqiang ma <yma.cool@gmail.com>, "Luis R. Rodriguez" <mcgrof@gmail.com>, linux-wireless@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>, linux-pm@lists.linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Maciej Rutecki <maciej.rutecki@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Sunday 23 May 2010, Rafael J. Wysocki wrote:
> On Saturday 22 May 2010, Rafael J. Wysocki wrote:
> > Hi,
> > 
> > With current -git on Acer Ferrari One the ath9k driver doesn't seem to work
> > after resume from suspend to RAM.  NetworkManager seems to think that it works,
> > but it doesn't really connect with the AP and doesn't try to obtain an IP
> > address.
> 
> Sorry, this was incorrect.  It actually tries to obtain an IP address, but
> fails.  Apparently, it can't obtain the address without being reloaded.

This issue can be fixed by reverting:

commit 03ceedea972a82d343fa5c2528b3952fa9e615d5
Author: Daniel Yingqiang Ma <yma.cool@gmail.com>
Date:   Tue Apr 13 15:12:07 2010 +0800

    ath9k: Group Key fix for VAPs

Thanks,
Rafael
