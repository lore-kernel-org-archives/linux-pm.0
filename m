From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Subject: Re: [2/2] 2.6.22-rc2: known regressions with patches
Date: Sun, 20 May 2007 00:06:52 +0200
Message-ID: <464F74FC.8000800@googlemail.com>
References: <464F7400.2070701@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <464F7400.2070701@googlemail.com>
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
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Greg Kroah-Hartman <gregkh@suse.de>, Avuton Olrich <avuton@gmail.com>, David Chinner <dgc@sgi.com>, LKML <linux-kernel@vger.kernel.org>, Andrea Righi <righiandr@users.sourceforge.net>, xfs-masters@oss.sgi.com, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Christoph Lameter <clameter@sgi.com>
List-Id: linux-pm@vger.kernel.org

Hi all,

Here is a list of some known regressions in 2.6.22-rc2
with patches available.

Feel free to add new regressions/remove fixed etc.
http://kernelnewbies.org/known_regressions



File systems

Subject    : 2.6.21-git10/11: files getting truncated on xfs
References : http://lkml.org/lkml/2007/5/9/410
Submitter  : Jeremy Fitzhardinge <jeremy@goop.org>
Handled-By : David Chinner <dgc@sgi.com>
Patch      : http://lkml.org/lkml/2007/5/12/93
Status     : patch available



Memory management

Subject    : bug in i386 MTRR initialization
References : http://lkml.org/lkml/2007/5/19/93
Submitter  : Andrea Righi <righiandr@users.sourceforge.net>
Status     : patch available



Suspend

Subject    : resume after suspend-to-disk broken when USB compiled in
References : http://bugzilla.kernel.org/show_bug.cgi?id=8498
Submitter  : Avuton Olrich <avuton@gmail.com>
Patch      : http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/gregkh-04-usb/usb-make-the-autosuspend-workqueue-thread-freezable.patch
Status     : patch available



Regards,
Michal

--
Michal K. K. Piotrowski
Kernel Monkeys
(http://kernel.wikidot.com/start)
