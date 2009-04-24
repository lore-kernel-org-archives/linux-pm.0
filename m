From: Kalle Valo <kalle.valo@nokia.com>
Subject: Re: 2.6.30-rc2-git2: Reported regressions from 2.6.29
Date: Fri, 24 Apr 2009 16:44:22 +0300
Message-ID: <87ljpqqi89.fsf__24482.7072056525$1240856855$gmane$org@nokia.com>
References: <EJaiQ4Wfaz.A.3YG.4v85JB@chimera>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <EJaiQ4Wfaz.A.3YG.4v85JB@chimera> (ext Rafael J. Wysocki's
	message of "Thu\, 16 Apr 2009 23\:42\:31 +0200")
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "ext Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Adrian Bunk <bunk@kernel.org>, Linux SCSI List <linux-scsi@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Natalie Protasevich <protasnb@gmail.com>, Linux ACPI <linux-acpi@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Kernel Testers List <kernel-testers@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Linux PM List <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

"Rafael J. Wysocki" <rjw@sisk.pl> writes:

> This message contains a list of some regressions from 2.6.29, for
> which there are no fixes in the mainline I know of. If any of them
> have been fixed already, please let me know.
>
> If you know of any other unresolved regressions from 2.6.29, please
> let me know either and I'll add them to the list. Also, please let
> me know if any of the entries below are invalid.
>
> Each entry from the list will be sent additionally in an automatic reply to
> this message with CCs to the people involved in reporting and handling the
> issue.
>

[...]

> Bug-Entry       : http://bugzilla.kernel.org/show_bug.cgi?id=13067
> Subject         : iwl3945: wlan0: beacon loss from AP - sending probe request
> Submitter       : Maciej Rutecki <maciej.rutecki@gmail.com>
> Date            : 2009-04-05 9:11 (12 days old)
> References      : http://marc.info/?l=linux-kernel&m=123892272218266&w=4

The regression here is that I added a printk() to inform about beacon
loss. The issue has been there a long time, the printk() just exposed
it.

Michael wrote a patch which silences the printk:

http://git.kernel.org/?p=linux/kernel/git/linville/wireless-testing.git;a=commit;h=16eaea5faa37d552b14e246ca56a436e55ca67b3

I fixed the beacon loss detection here:

http://git.kernel.org/?p=linux/kernel/git/linville/wireless-testing.git;a=commit;h=3b6dc5a431e4fef35717cba53544a95209f49b68

John, I think Michael's patch should be sent to 2.6.30. Any chances
for that?

Rafael, is it possible to send your regression mails to
linux-wireless@vger.kernel.org as well? Very few wireless developers
have time to follow netdev or lkml.

-- 
Kalle Valo
