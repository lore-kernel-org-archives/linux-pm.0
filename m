From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH 1/4 -mm] kexec based hibernation -v7 : kexec
	jump
Date: Sat, 08 Dec 2007 18:06:02 -0700
Message-ID: <m1prxgoex1.fsf__18591.8791140013$1197162539$gmane$org@ebiederm.dsl.xmission.com>
References: <1197042810.24045.61.camel@caritas-dev.intel.com>
	<20071208235344.GA17005@elf.ucw.cz> <200712090119.57826.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200712090119.57826.rjw@sisk.pl> (Rafael J. Wysocki's message of
	"Sun, 9 Dec 2007 01:19:56 +0100")
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
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

"Rafael J. Wysocki" <rjw@sisk.pl> writes:

>> I'm not kexec hacker... but maybe this is in good enough state to be
>> merged? It is useful on its own: kexec jump and back means we can dump
>> system then continue running, for example...
>
> As far as I'm concerned, patches [1/4] and [2/4] can go.
>
> The other two are not in that shape yet (especially the [3/4] patch).

Ok.  Then I will see if I can review these in the next couple days
and give some feedback.

At a quick skim through the code it appears there is some more infrastructure
then we need and things can still be simplified.

Since this applies in particular to the user space interface I'm not comfortable
with these patches going in just yet.

The unused KEXEC_PRESERVE_ flags especially give me pause.  Having something
like that, that isn't currently wired up sounds like a bad place to start.

Eric
