From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: Power Management framework proposal
Date: Sun, 22 Jul 2007 21:00:39 -0700
Message-ID: <1185163239.2714.37.camel__35152.0440112383$1185163406$gmane$org@laptopd505.fenrus.org>
References: <Pine.LNX.4.64.0707212339550.6350@asgard.lang.hm>
	<1185125189.2714.13.camel@laptopd505.fenrus.org>
	<Pine.LNX.4.64.0707221130380.6350@asgard.lang.hm>
	<1185143240.2714.24.camel@laptopd505.fenrus.org>
	<Pine.LNX.4.64.0707221946170.6350@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.64.0707221946170.6350@asgard.lang.hm>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: david@lang.hm
Cc: linux-pm <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

> example 1: a laptop screen
> 
> mode  capacity power description
> 0        0        0    off
> 1      100      100    full brightness
> 2       70       60    half power to the backlight
> 3       50       35    quarter power to the backlight
> 4       30       25    eighth power to the backlight
> 5        5       10    backlight off.
> 
> example 2: a front-panel display on a server (no variable backlight 
> control)
> 
> mode capacity power description
> 0       0        0   off
> 1     100      100   backlight on
> 2      50       10   backlight off


the problem is: the person who SETS these needs to know what they mean.
And the side that implements these needs to translate them as well...

that's two translations, and information is lost in the abstract number
in the middle that doesn't mean anything

> if you don't want to make the shift with cpufreq, that's fine. it
> sounds 
> like you are at least 90% of the way there anyway, it's not that big
> a 
> deal, but do you think that there's value in replacing the current
> ad-hoc 
> approach with something more structured (even if it's not this
> proposal)?

as someone who wrote (part of) a power policy manager; sorry but you
take away information I need, and in addition the different API's are
absolutely no big deal.

-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org
