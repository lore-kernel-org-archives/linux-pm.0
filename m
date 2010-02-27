From: =?ISO-8859-2?Q?=C1kos_Mar=F3y?= <akos@maroy.hu>
Subject: Re: pm-suspend working, but pm-hibernate fails
Date: Sat, 27 Feb 2010 14:28:44 +0100
Message-ID: <4B891E0C.4030402@maroy.hu>
References: <4B86F96A.1010306@maroy.hu> <201002252357.04056.rjw@sisk.pl>
	<4B88D6B9.2050200@maroy.hu> <201002271300.56741.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201002271300.56741.rjw@sisk.pl>
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
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Rafael,

> Does it also happen if you rmmod the xhci-hcd module manually and run
> "echo disk > /sys/power/state" afterwards?

yes. I do an rmmod xhci, lsmod | grep xhci returns nothing, and then
echo disk > /sys/power/state will give me the same result as
pm-hibernate. that is, I get to an empty screen, there's a cursor
blinking on the top left. after a while, the screen dims, but nothing
else happens. only a power cycle saves the day, where the machine boots
normally, when just turned on.

how could I debug these happenings further?


Akos
