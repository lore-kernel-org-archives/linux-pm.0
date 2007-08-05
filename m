From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [2/3] 2.6.23-rc2: known regressions
Date: Sun, 5 Aug 2007 18:58:11 +0200
Message-ID: <200708051858.12404.rjw__13711.7858896547$1186332588$gmane$org@sisk.pl>
References: <46B5F74D.7010708@googlemail.com> <46B5FA32.50208@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <46B5FA32.50208@googlemail.com>
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

On Sunday, 5 August 2007 18:26, Michal Piotrowski wrote:
> Hi all,
> 
> Here is a list of some known regressions in 2.6.23-rc2.
> 
> Feel free to add new regressions/remove fixed etc.
> http://kernelnewbies.org/known_regressions
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

Is being debugged.

Frankly, I don't know what to think about that.  With the Meelis' .config
SUSPEND_SMP can't even be set ...

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
