From: Dmitry Nezhevenko <dion@inhex.net>
Subject: 2.6.38-rc7: oops on hibernate
Date: Sat, 5 Mar 2011 21:40:27 +0200
Message-ID: <20110305194027.GA6582@laptop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi,

I've just hit oops on hibernate. Unfortunately there is no
info in syslog, however I've created a photo with call stack:
http://dion.org.ua/tmp/20110305_210225.jpg

It looks like I can't reproduce it anymore. Both hibernate and s2ram works
on this machine (Asus F6A laptop).

-- 
WBR, Dmitry
