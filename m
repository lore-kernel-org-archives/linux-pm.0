From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] PM: Hide CONFIG_PM from users
Date: Tue, 8 Feb 2011 15:29:01 +0100
Message-ID: <20110208142901.GB1437__41473.7798426815$1297175511$gmane$org@ucw.cz>
References: <1297081335-13631-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1297081335-13631-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Len Brown <len.brown@intel.com>, linux-embedded@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> It is very rare to find a current system which is both sufficiently
> resource constrained to want to compile out power management support
> and sufficiently power insensitive to be able to tolerate doing so.

Ok, how much memory do we talk about here?

Lots of embedded systems are AC powered or powered from some powerful
source -- such as alternator in car. PM can be unwanted complexity
there.

Ot maybe they are running under realtime hypervisor...

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
