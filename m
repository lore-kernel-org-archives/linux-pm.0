From: Dave Jones <davej@redhat.com>
Subject: Re: Ottawa Linux Power Management Summit, June 25-26,
	2007 - Minutes
Date: Mon, 24 Sep 2007 15:41:02 -0400
Message-ID: <20070924194102.GH8127@redhat.com>
References: <200709050426.04793.lenb@kernel.org>
	<200709091426.39854.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200709091426.39854.rjw@sisk.pl>
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

On Sun, Sep 09, 2007 at 02:26:39PM +0200, Rafael J. Wysocki wrote:

 > > Dave mentioned that Fedora Core 7 32-bit is now shipping with
 > > CONFIG_NOHZ=y and CONFIG_HZ=1000.
 > 
 > CONFIG_NOHZ is known to break suspend and resume on some machines.  These
 > problems are being fixed over time, but that's a risky decision for a
 > distribution to switch it on by default.

Expect to see everyone else doing the same thing in the next versions.
Without field-testing this stuff it remains busted.  A lot of bugs got
found and fixed by having this in Fedora that weren't tripped over
by linux-kernel testers at all.

	Dave

-- 
http://www.codemonkey.org.uk
