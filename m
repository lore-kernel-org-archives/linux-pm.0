From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [3/3] 2.6.23-rc2: known regressions v2
Date: Wed, 8 Aug 2007 22:10:24 +0200
Message-ID: <200708082210.25836.rjw__31711.1283577562$1186603398$gmane$org@sisk.pl>
References: <46B9F664.9060600@googlemail.com> <46B9F983.9020700@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <46B9F983.9020700@googlemail.com>
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
Cc: Meelis Roos <mroos@linux.ee>, LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Wednesday, 8 August 2007 19:12, Michal Piotrowski wrote:
> Hi all,
> 
> Here is a list of some known regressions in 2.6.23-rc2.
> 
> Feel free to add new regressions/remove fixed etc.
> http://kernelnewbies.org/known_regressions
> 
> List of Aces
> 
> Name                    Regressions fixed since 21-Jun-2007
> Adrian Bunk                            6
> Andi Kleen                             4
> Andrew Morton                          4
> Linus Torvalds                         4
> Al Viro                                3
> Cornelia Huck                          3
> Jens Axboe                             3
> Tejun Heo                              3
> David Woodhouse                        2
> Hugh Dickins                           2
> Peter Zijlstra                         2
> Trent Piepho                           2
> 
> 
> 
> Power management
> 
> Subject         : Kconfig: 'SUSPEND_SMP' refers to undefined symbol 'HOTPLUG_CPU'
> References      : http://lkml.org/lkml/2007/8/4/39
> Last known good : ?
> Submitter       : Meelis Roos <mroos@linux.ee>
> Caused-By       : ?
> Handled-By      : Rafael J. Wysocki <rjw@sisk.pl>
> Status          : unknown

I can't reproduce this with my cross compilation toolchain for PPC.

Greetings,
Rafael
