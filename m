From: Dave Jones <davej@redhat.com>
Subject: Re: [3/3] 2.6.21-rc6: known regressions
Date: Sat, 14 Apr 2007 03:40:30 -0400
Message-ID: <20070414074030.GA29635@redhat.com>
References: <Pine.LNX.4.64.0704051944230.6730@woody.linux-foundation.org>
	<20070414003808.GU5907@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20070414003808.GU5907@stusta.de>
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
Cc: Len Brown <len.brown@intel.com>, Jeremy Fitzhardinge <jeremy@goop.org>, James Simmons <jsimmons@infradead.org>, Jeff Chua <jeff.chua.linux@gmail.com>, adaplas@gmail.com, linux-acpi@vger.kernel.org, gregkh@suse.de, linux-pm@lists.osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tobias Diedrich <ranma+kernel@tdiedrich.de>, Tobias Doerffel <tobias.doerffel@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, "Eric W. Biederman" <ebiederm@xmission.com>, Ingo Molnar <mingo@elte.hu>, linux-pci@atrey.karlin.mff.cuni.cz, Marcus Better <marcus@better.se>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sat, Apr 14, 2007 at 02:38:08AM +0200, Adrian Bunk wrote:

 > Subject    : ThinkPad X60: resume no longer works  (PCI related?)
 >              workaround: booting with "hpet=3Ddisable"
 > References : http://lkml.org/lkml/2007/3/13/3
 > Submitter  : Dave Jones <davej@redhat.com>
 >              Jeremy Fitzhardinge <jeremy@goop.org>
 > Caused-By  : PCI merge
 >              commit 78149df6d565c36675463352d0bfe0000b02b7a7
 > Handled-By : Eric W. Biederman <ebiederm@xmission.com>
 >              Rafael J. Wysocki <rjw@sisk.pl>
 > Status     : problem is being debugged

I'm at a loss on this one. git bisect was non-conclusive.
I even tried beating up on Eric's console-over-usb to try
and get more useful info, but I failed miserably.

	Dave

-- =

http://www.codemonkey.org.uk
