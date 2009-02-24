From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] pm: rework includes, remove arch ifdefs
Date: Tue, 24 Feb 2009 15:45:56 -0800
Message-ID: <20090224154556.7f4fa1db.akpm__17980.4137013436$1235519309$gmane$org@linux-foundation.org>
References: <20090223080204.13536.67018.sendpatchset@rx1.opensource.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090223080204.13536.67018.sendpatchset@rx1.opensource.se>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-pm@lists.linux-foundation.org, linux-sh@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon, 23 Feb 2009 17:02:04 +0900
Magnus Damm <magnus.damm@gmail.com> wrote:

> This patch contains the following header file changes:
>  - remove arch ifdefs and asm/suspend.h from linux/suspend.h
>  - add asm/suspend.h to disk.c (for arch_prepare_suspend())
>  - add linux/io.h to swsusp.c (for ioremap())

x86_64 allmodconfig:

In file included from arch/x86/kernel/asm-offsets.c:4:
arch/x86/kernel/asm-offsets_64.c: In function 'main':
arch/x86/kernel/asm-offsets_64.c:109: error: invalid use of undefined type 'struct saved_context'
arch/x86/kernel/asm-offsets_64.c:110: error: invalid use of undefined type 'struct saved_context'
arch/x86/kernel/asm-offsets_64.c:111: error: invalid use of undefined type 'struct saved_context'
arch/x86/kernel/asm-offsets_64.c:112: error: invalid use of undefined type 'struct saved_context'
arch/x86/kernel/asm-offsets_64.c:113: error: invalid use of undefined type 'struct saved_context'
