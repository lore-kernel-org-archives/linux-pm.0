From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: some task not stopped during resume
Date: Wed, 30 May 2007 15:50:55 +0200
Message-ID: <200705301550.56257.rjw@sisk.pl>
References: <1180442538.1396.3.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1180442538.1396.3.camel@johannes.berg>
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
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-pm <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

Hi,

On Tuesday, 29 May 2007 14:42, Johannes Berg wrote:
> Hi,
> 
> Oddly, I just got the following on 2.6.22-rc1:
> 
> [164571.322432] PM: Preparing system for mem sleep
> [164571.883809] Stopping tasks ... done.
> [...]
> [164573.454973] PM: Entering mem sleep
> [...]
> [164574.580359] PM: Finishing wakeup.
> [...]
> [164578.238895] Restarting tasks ... <4> Strange, evolution not stopped
> [164578.456389] done.
> 
> The interesting thing is that when I resumed, the gdb crash window came
> up because evolution had just crashed (this is an option, otherwise
> bug-buddy comes up.) But I'm not entirely sure how this could have
> happened since it was definitely running while I suspended and must have
> stopped at that point. Maybe some bad ptrace interaction? Though it
> shouldn't have crashed when tasks were stopped? I'm confused.

The message seems to be a false-positive (this printk has been removed
recently, in 2.6.22-rc3, IIRC).

We don't freeze traced tasks the parents of which have been frozen.  So, in
fact, the evolution wasn't frozen, only the gdb that traced it, and during the
resume the gdb was thawed and allowed evolution to run, but it crashed.

Why it crashed is a different problem, actually, and that need not be related
to the freezer.  Still, if that turns out to be reproducible, I'll start to worry. ;-)

Greetings,
Rafael
