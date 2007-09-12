From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Subject: Re: [4/4] 2.6.23-rc6: known regressions
Date: Wed, 12 Sep 2007 18:59:08 +0200
Message-ID: <46E81ADC.4030902__2407.38825309581$1189616914$gmane$org@googlemail.com>
References: <46E8187E.9000006@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <46E8187E.9000006@googlemail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Soeren Sonnenburg <kernel@nn7.de>, Arkadiusz Miskiewicz <arekm@maven.pl>, Thomas Voegtle <tv@lio96.de>, Greg KH <gregkh@suse.de>, Tino Keitel <tino.keitel@gmx.de>, LKML <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>, Christian Leber <christian@leber.de>, Andy Whitcroft <apw@shadowen.org>, Alan Cox <alan@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, linux-usb-devel@lists.sourceforge.net
List-Id: linux-pm@vger.kernel.org

Hi all,

Here is a list of some known regressions in 2.6.23-rc6.

Feel free to add new regressions/remove fixed etc.
http://kernelnewbies.org/known_regressions

List of Aces

Name                    Regressions fixed since 21-Jun-2007
Adrian Bunk                            10
Linus Torvalds                         6
Alan Stern                             5
Andi Kleen                             5
Hugh Dickins                           5
Trond Myklebust                        5
Andrew Morton                          4
Al Viro                                3
Alexey Starikovskiy                    3
Cornelia Huck                          3
David S. Miller                        3
Jens Axboe                             3
Stephen Hemminger                      3
Tejun Heo                              3



Power management

Subject         : powersaving degradation, (time spend in C0 goes up after a while)
References      : http://lkml.org/lkml/2007/9/2/142
Last known good : ?
Submitter       : Christian Leber <christian@leber.de>
Caused-By       : ?
Handled-By      : ?
Status          : unknown

Subject         : something broke resume from s2ram on mbp c1d (??? :))
References      : http://lkml.org/lkml/2007/8/28/67
Last known good : 2.6.23-rc3
Submitter       : Soeren Sonnenburg <kernel@nn7.de>
Caused-By       : ?
Handled-By      : Rafael J. Wysocki <rjw@sisk.pl>
Status          : unknown

Subject         : 2.6.23-rc2 swsusp, suddenly increased uptime
References      : http://lkml.org/lkml/2007/8/12/249
Last known good : ?
Submitter       : Thomas Voegtle <tv@lio96.de>
Caused-By       : ?
Handled-By      : Rafael J. Wysocki <rjw@sisk.pl>
Status          : problem is being debugged

Subject         : resume from ram much slower
References      : http://lkml.org/lkml/2007/8/10/275
Last known good : 2.6.23-rc1 ?
Submitter       : Arkadiusz Miskiewicz <arekm@maven.pl>
Caused-By       : ?
Handled-By      : Rafael J. Wysocki <rjw@sisk.pl>
Status          : problem is being debugged



TTY things

Subject         : 2.6.23-rc6-git1 -- termios *_1 compile failures on powerpc
References      : http://lkml.org/lkml/2007/9/12/101
Last known good : ?
Submitter       : Andy Whitcroft <apw@shadowen.org>
Caused-By       : David Miller <davem@davemloft.net>
                  commit f629307c857c030d5a3dd777fee37c8bb395e171
Handled-By      : ?
Status          : unknown



USB

Subject         : 2.6.23-rc1: USB hard disk broken
References      : http://lkml.org/lkml/2007/7/25/62
Last known good : ?
Submitter       : Tino Keitel <tino.keitel@gmx.de>
Caused-By       : ?
Handled-By      : Oliver Neukum <oliver@neukum.org>
Status          : unknown



Regards,
Michal

--
LOG
http://www.stardust.webpages.pl/log/
