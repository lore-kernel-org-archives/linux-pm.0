From: Dave Jones <davej@redhat.com>
Subject: Re: [2/2] 2.6.21-rc7: known regressions
Date: Sun, 15 Apr 2007 20:54:46 -0400
Message-ID: <20070416005446.GB21217@redhat.com>
References: <Pine.LNX.4.64.0704151659570.5473@woody.linux-foundation.org>
	<20070416003723.GM3691@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20070416003723.GM3691@stusta.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Adrian Bunk <bunk@stusta.de>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, gregkh@suse.de, "Antonino A. Daplas" <adaplas@gmail.com>, Jeff Chua <jeff.chua.linux@gmail.com>, Ingo Molnar <mingo@elte.hu>, linux-pm@lists.osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tobias Diedrich <ranma+kernel@tdiedrich.de>, linux-pci@atrey.karlin.mff.cuni.cz, "Eric W. Biederman" <ebiederm@xmission.com>, James Simmons <jsimmons@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Marcus Better <marcus@better.se>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Apr 16, 2007 at 02:37:23AM +0200, Adrian Bunk wrote:

 > Subject    : ThinkPad X60: resume no longer works  (PCI related?)
 >              workaround: booting with "hpet=3Ddisable"
 > References : http://lkml.org/lkml/2007/3/13/3
 > Submitter  : Dave Jones <davej@redhat.com>
 >              Jeremy Fitzhardinge <jeremy@goop.org>
 > Caused-By  : PCI merge
 >              commit 78149df6d565c36675463352d0bfe0000b02b7a7
 > Handled-By : Eric W. Biederman <ebiederm@xmission.com>
 >              Rafael J. Wysocki <rjw@sisk.pl>
 > Status     : unknown

note that this workaround doesn't seem to work in all cases.
Mine may a slightly different model (I have the tablet version)
but disabling hpet shows the same regression.
I've been fighting Eric's USB debug cable code in the hope
of getting _something_ useful out of it other than a black screen,
but I've been getting nowhere with it.

	Dave

-- =

http://www.codemonkey.org.uk
