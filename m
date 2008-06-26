From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] x86 ACPI: normalize segment descriptor
	register on	resume
Date: Thu, 26 Jun 2008 10:29:43 +0200
Message-ID: <20080626082943.GC10973__42976.1423882612$1214469125$gmane$org@elte.hu>
References: <200806242303.49498.rjw@sisk.pl>
	<20080624214610.GC18679@elf.ucw.cz> <20080625170126.GA2482@elte.hu>
	<200806252217.27059.rjw@sisk.pl>
	<20080626011716.e8c412dd.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20080626011716.e8c412dd.akpm@linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Pavel Machek <pavel@suse.cz>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org


* Andrew Morton <akpm@linux-foundation.org> wrote:

> Len seems to think that Rafael seems to think that Ingo seems to think 
> that this patch broke one of his boxes.
> 
> Is it so?

No! :-)

it found a pre-existing suspend+resume breakage on a testbox. (I.e. the 
debug patch worked as i'd expect it to work. Every good debug patch 
starts its lifetime with a sharp spike of breakages it finds.)

( my kernel test-setup does in excess of 100,000 random kernel bootups 
  per year and me not having to hit the keyboard or close+open the lid a 
  hundred thousand times, day and night, to find the occasional 
  suspend+resume regression is a not to be under-estimated plus. )

	Ingo
