From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC] Asynchronous suspend/resume - test results
Date: Wed, 23 Dec 2009 21:46:29 +0100
Message-ID: <200912232146.29339.rjw__38063.9401999817$1261601309$gmane$org@sisk.pl>
References: <200912210140.19713.rjw@sisk.pl> <4B2F22EF.6040500@crca.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4B2F22EF.6040500@crca.org.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Nigel Cunningham <ncunningham@crca.org.au>
Cc: Jiri Slaby <jslaby@suse.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Monday 21 December 2009, Nigel Cunningham wrote:
> Hi.
> 
> Rafael J. Wysocki wrote:
> > I'm not sure what the next step should be at this point.  To me, the picture is
> > quite clear now, but perhaps we ought to run more tests on some other machines
> > or something.  Please let me know what you think.
> 
> Looks great. If you do decide you want other machines tested, I'll
> happily try the machines around here:
> 
> - Dell M1530
> - Omnibook XE3-GF.
> - Via LN10000 based Mythtv Box
> - Desktop machine - Some Intel-based mobo I've forgotten the name of.

Yes, that would be useful.  If the results are in agreement with my data at
http://www.sisk.pl/kernel/data/, we will have a strong support for starting the
async threads upfront during resume. 

The patches I used for testing are in the async branch in my tree:
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/suspend-2.6.git
The first of them is
http://git.kernel.org/?p=linux/kernel/git/rafael/suspend-2.6.git;a=commit;h=91bbe0161cab7efcda5de3dfdf6a93f07314ed58
and the others are on top of this one (but it will apply on top of the current
mainline, so I'd suggest to pull the latest Linus' tree and then rebase the
commits from my async branch on top of it).

The "upfront * async" results were obtained with the full patchset applied.
The "sync" results where with /sys/power/pm_async = 0 and the "bare async"
results were with the last two commits reverted.
 
> By the way, I haven't forgotten about sending some real patches for
> swsusp (ie more than just cleanups). I'm just busy with other things and
> also thinking carefully about what order to do things in.

Great, I hope you're in contact with Jiri Slaby, as he's also been working on
this.

Rafael
