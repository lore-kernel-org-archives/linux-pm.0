From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PATCH] ACPI patches for 2.6.25-rc5
Date: Wed, 12 Mar 2008 23:45:16 -0700
Message-ID: <20080312234516.bb079cc5.akpm@linux-foundation.org>
References: <200803130214.36861.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200803130214.36861.lenb@kernel.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Len Brown <lenb@kernel.org>
Cc: Andrea Arcangeli <andrea@qumranet.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 13 Mar 2008 02:14:36 -0400 Len Brown <lenb@kernel.org> wrote:

> please pull from: 
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.git release
> 
> A bunch of small regression fixes, bug fixes, and a couple of minor cleanups.

I hope Rafael knows how to cross-reference the regression fixes against his list?



I'm sitting on five ACPI patches which look like they (or alternatives?) should
be in 2.6.25:


http://userweb.kernel.org/~akpm/mmotm/broken-out/acpi-ec-revert-208c70a45624400fafd7511b96bc426bf01f8f5e.patch

  This was too poorly changelogged for me to remember what problem it
  solves, but it seemed important at the time.

http://userweb.kernel.org/~akpm/mmotm/broken-out/drivers-acpi-asus_acpic-correct-use-of-and.patch

  Fix logic error in asus_acpi.c

http://userweb.kernel.org/~akpm/mmotm/broken-out/drivers-acpi-asus_acpic-correct-use-of-and.patch

  Fix an overrun.

http://userweb.kernel.org/~akpm/mmotm/broken-out/revert-acpi-thermal-fixup.patch

  Hopeully fix a regression which Andrea Arcangeli hit.  Although I'm not sure
  that he has confirmed that this revert actually works?

http://userweb.kernel.org/~akpm/mmotm/broken-out/acpi-set-flag-dock_undocking-when-triggered-via-sysfs.patch

  Fix a system lockup related to undocking.
