From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [3/4] 2.6.21-rc5: known regressions (v2)
Date: Sat, 31 Mar 2007 22:39:02 -0700
Message-ID: <460F4576.6010904@goop.org>
References: <Pine.LNX.4.64.0703251559560.6730@woody.linux-foundation.org>
	<20070330213220.GO14134@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070330213220.GO14134@stusta.de>
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
Cc: linux-pm@lists.osdl.org, Thomas Gleixner <tglx@linutronix.de>, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, gregkh@suse.de, Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Adrian Bunk wrote:
> Subject    : ThinkPad X60: resume no longer works  (PCI related?)
> References : http://lkml.org/lkml/2007/3/13/3
> Submitter  : Dave Jones <davej@redhat.com>
>              Jeremy Fitzhardinge <jeremy@goop.org>
> Caused-By  : PCI merge
>              commit 78149df6d565c36675463352d0bfe0000b02b7a7
> Handled-By : Eric W. Biederman <ebiederm@xmission.com>
>              Rafael J. Wysocki <rjw@sisk.pl>
> Status     : problem is being debugged
>   =


I know this is currently a subject of discussion on lkml, but I wanted
to confirm that booting with "hpet=3Ddisable" fixes this, and resume works
for me.  It ends up using acpi_pm as the clocksource.

    J
