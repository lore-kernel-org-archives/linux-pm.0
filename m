From: Igor Stoppa <igor.stoppa@nokia.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Fri, 28 May 2010 15:49:42 +0300
Message-ID: <4BFFBBE6.50604__11907.5008122765$1275049673$gmane$org@nokia.com>
References: <20100527222514.0a1710bf@lxorguk.ukuu.org.uk>	<Pine.LNX.4.44L0.1005271730180.3239-100000@iolanthe.rowland.org>	<20100527230806.4deb6de3@lxorguk.ukuu.org.uk>	<20100527220949.GB10602@srcf.ucam.org>	<20100527232357.6d14fdb2@lxorguk.ukuu.org.uk>	<20100527223605.GB11364@srcf.ucam.org>	<20100527235546.09f3ce8a@lxorguk.ukuu.org.uk>	<20100528043114.GC26177@thunk.org>	<20100528103713.0a7952d9@lxorguk.ukuu.org.uk>
	<06439EEF-9404-45DC-AB37-5CC0486CCF6C@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <06439EEF-9404-45DC-AB37-5CC0486CCF6C@mit.edu>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: ext Theodore Tso <tytso@mit.edu>
Cc: Peter Zijlstra <peterz@infradead.org>, "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

ext Theodore Tso wrote:

> I've seen very hard to debug situations  with Maemo where users are essentially asked to uninstall all their applications, and then install them back one at a time, waiting several hours between each install for a charge/discharge cycle, to figure out which application was waking up the system so !@#@! much while the screen was turned off.   And, when the periodic wakeups are faster than the refresh time of powertop, no, powertop won't help you find the crapplication.   If you think that's acceptable, fine --- we'll see who wins in the marketplace, and who gets blamed for producing a crappy platform --- the incompetent application programmer, or the platform supplier.
>   
Those apps were from an experimental repository, which is not enabled by 
default in stock SW.

Of course tools can be improved, but if someone decides to run sw which 
is clearly under heavy development, i see little point in complaining 
that it might not work as expected.

igor
