From: Mark Lord <kernel@teksavvy.com>
Subject: Re: 2.6.37-rc2-git4: Reported regressions 2.6.35 ->
	2.6.36
Date: Thu, 18 Nov 2010 19:47:21 -0500
Message-ID: <4CE5C919.7090504__42249.9812244952$1290127799$gmane$org@teksavvy.com>
References: <tTUH_XeInOH.A.dMF.c3b5MB@chimera>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <tTUH_XeInOH.A.dMF.c3b5MB@chimera>
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
Cc: Linux SCSI List <linux-scsi@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, Linux Wireless List <linux-wireless@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, DRI <dri-devel@lists.freedesktop.org>, Florian Mickler <florian@mickler.org>, Andrew Morton <akpm@linux-foundation.org>, Kernel Testers List <kernel-testers@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Linux PM List <linux-pm@lists.linux-foundation.org>, Maciej Rutecki <maciej.rutecki@gmail.com>
List-Id: linux-pm@vger.kernel.org

On 10-11-18 06:50 PM, Rafael J. Wysocki wrote:
> This message contains a list of some post-2.6.35 regressions introduced before
> 2.6.36, for which there are no fixes in the mainline known to the tracking team.
> If any of them have been fixed already, please let us know.
>
> If you know of any other unresolved post-2.6.35 regressions, please let us know
> either and we'll add them to the list.  Also, please let us know if any
> of the entries below are invalid.

> Bug-Entry	: http://bugzilla.kernel.org/show_bug.cgi?id=21652
> Subject		: several problems with intel graphics since 2.6.36
> Submitter	: Norbert Preining<preining@logic.at>
> Date		: 2010-10-27 14:32 (23 days old)
> Message-ID	:<20101027143252.GA8676@gamma.logic.tuwien.ac.at>
> References	: http://marc.info/?l=linux-kernel&m=128818998630241&w=2

That one is interesting to me.. I suspect it may be the same cause
as for https://bugzilla.kernel.org/show_bug.cgi?id=21952

I have one of those Samsung (N210) Netbooks here: works fine with 2.6.34 and 
earlier,
but fails to come out of suspend on 2.6.35/2.6.36 (haven't tried 2.6.37).

So perhaps add 21952 to the list, or link it to the 21652
(kind of amusing how similar the bug numbers are..).


My non-Intel graphics notebook (has ATI X1400 graphics) also has a resume
regression with 2.6.36.  But it does work fine with 2.6.35 (and earlier,
back many years).  As a result, I'm stuck with 2.6.35 for the time being,
and lack the time for a concerted debug effort on 2.6.36+ right now.

Cheers
