From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Status of Regression/Bug 13407 adb trackpad
 disappears after suspend to ram?
Date: Mon, 28 Sep 2009 13:29:07 +1000
Message-ID: <1254108547.8421.4.camel__39097.7554060102$1254111036$gmane$org@pasglop>
References: <4ABF5432.9020508@gmx.net> <200909271713.44719.rjw@sisk.pl>
	<4ABFAA82.2040200@gmx.net>  <1254108467.8421.3.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1254108467.8421.3.camel@pasglop>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Martin Wache <m.wache@gmx.net>
Cc: pm list <linux-pm@lists.linux-foundation.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon, 2009-09-28 at 13:27 +1000, Benjamin Herrenschmidt wrote:

> Start with sending the dmesg, the output of cat /proc/cpuinfo, and the
> Xorg log (/var/log/Xorg.0.log)

Also throw in your .config (and while at it, try using the standard
pmac32_defconfig).

Cheers,
Ben.
