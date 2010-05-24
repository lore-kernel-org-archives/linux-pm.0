From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [Regression][git head f4b87dee9] ath9k doesn't work
 correctly after resume from suspend to RAM
Date: Mon, 24 May 2010 10:14:29 +0200
Message-ID: <1274688869.3743.5.camel__29614.037651527$1274688942$gmane$org@jlt3.sipsolutions.net>
References: <201005222353.26920.rjw@sisk.pl>
	<201005230013.37578.rjw@sisk.pl> <201005232120.16814.rjw@sisk.pl>
	<201005240059.57921.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201005240059.57921.rjw@sisk.pl>
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
Cc: Daniel Yingqiang Ma <yma.cool@gmail.com>, "Luis
	R. Rodriguez" <mcgrof@gmail.com>, David Miller <davem@davemloft.net>, linux-wireless@vger.kernel.org, "John W. Linville" <linville@tuxdriver.com>, LKML <linux-kernel@vger.kernel.org>, linux-pm@lists.linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Maciej Rutecki <maciej.rutecki@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Mon, 2010-05-24 at 00:59 +0200, Rafael J. Wysocki wrote:

> commit 03ceedea972a82d343fa5c2528b3952fa9e615d5
> Author: Daniel Yingqiang Ma <yma.cool@gmail.com>
> Date:   Tue Apr 13 15:12:07 2010 +0800
> 
>     ath9k: Group Key fix for VAPs
> 
> also fixes the resume issue with iwlagn.

Ok that had me going WTF.

But then I saw that a huge ath9k patch had a mac80211 change sneakily
hidden in it. WTF!

> So, please revert.

Indeed, this patch needs to be reverted. That mac80211 change is wrong
and completely unnecessary.

johannes
