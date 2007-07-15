From: Cornelius Riemenschneider <c.r1@gmx.de>
Subject: Re: Hibernation considerations
Date: Sun, 15 Jul 2007 20:35:33 +0000
Message-ID: <469A8515.3080109__11809.1820776046$1184524555$gmane$org@gmx.de>
References: <200707151433.34625.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200707151433.34625.rjw@sisk.pl>
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
Cc: david@lang.hm, LKML <linux-kernel@vger.kernel.org>, Kyle Moffett <mrmacman_g4@mac.com>, Al Boldi <a1426z@gawab.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, "Huang, Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

Hi,
I think a (10) is needed to be clear:

(10) This depends directly on (9)
Easy Userinterface for the average user, no one wants to edit several
files and use a long commandline for a suspend (not all know about
alias(P)), so keeping the effort to suspend your system low, please.(eg
for my TuxOnIce i just type hibernate as root/ sudo hibernate as normal
user and the suspend begin, the rest is automatically done by the
configuration(for me this is shutting down my wireless interface)

Cornelius Riemenschneider

My source of power: www.humppa.com
