From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [3/3] 2.6.23-rc6: known regressions v2
Date: Sat, 15 Sep 2007 20:20:31 +0200
Message-ID: <200709152020.33179.rjw__19942.4617262141$1189879784$gmane$org@sisk.pl>
References: <46EB3EF8.6040103@googlemail.com> <46EB4374.50104@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <46EB4374.50104@googlemail.com>
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
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: Soeren Sonnenburg <kernel@nn7.de>, Arkadiusz Miskiewicz <arekm@maven.pl>, Thomas Voegtle <tv@lio96.de>, LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Saturday, 15 September 2007 04:29, Michal Piotrowski wrote:
> Hi all,
> 
> Here is a list of some known regressions in 2.6.23-rc6.
> 
> Feel free to add new regressions/remove fixed etc.
> http://kernelnewbies.org/known_regressions
> 
> List of Aces
> 
> Name                    Regressions fixed since 21-Jun-2007
> Adrian Bunk                            10
> Andi Kleen                             7
> Linus Torvalds                         6
> Alan Stern                             5
> Hugh Dickins                           5
> Trond Myklebust                        5
> Andrew Morton                          4
> David S. Miller                        4
> Al Viro                                3
> Alexey Starikovskiy                    3
> Cornelia Huck                          3
> Jens Axboe                             3
> Stephen Hemminger                      3
> Tejun Heo                              3
> 
> 
> 
> Power management
> 
> Subject         : powersaving degradation, (time spend in C0 goes up after a while)
> References      : http://lkml.org/lkml/2007/9/2/142
> Last known good : ?
> Submitter       : Christian Leber <christian@leber.de>
> Caused-By       : ?
> Handled-By      : ?
> Status          : unknown
> 
> Subject         : something broke resume from s2ram on mbp c1d (??? :))
> References      : http://lkml.org/lkml/2007/8/28/67
> Last known good : 2.6.23-rc3
> Submitter       : Soeren Sonnenburg <kernel@nn7.de>
> Caused-By       : ?
> Handled-By      : Rafael J. Wysocki <rjw@sisk.pl>
> Status          : unknown

Soeren said he would bisect, but I guess he didn't have the time.

> Subject         : 2.6.23-rc2 swsusp, suddenly increased uptime
> References      : http://lkml.org/lkml/2007/8/12/249
> Last known good : ?
> Submitter       : Thomas Voegtle <tv@lio96.de>
> Caused-By       : ?
> Handled-By      : Rafael J. Wysocki <rjw@sisk.pl>
> Status          : problem is being debugged

This is hard to reproduce, AFAICS, and unreproducible on any boxes I have
access to.
 
> Subject         : resume from ram much slower
> References      : http://lkml.org/lkml/2007/8/10/275
> Last known good : 2.6.23-rc1 ?
> Submitter       : Arkadiusz Miskiewicz <arekm@maven.pl>
> Caused-By       : ?
> Handled-By      : Rafael J. Wysocki <rjw@sisk.pl>
> Status          : problem is being debugged

Unresolved, bisection might be helpful.

Greetings,
Rafael
