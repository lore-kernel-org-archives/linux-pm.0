From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] X86: Cleanup idle= internal variables by
	getting rid of idle_halt idle_nomwait
Date: Fri, 5 Nov 2010 11:24:49 +0100
Message-ID: <201011051124.49973.trenn__5328.33920228786$1288952802$gmane$org@suse.de>
References: <201011021441.09258.trenn@suse.de>
	<alpine.LFD.2.00.1011030150560.3378@localhost.localdomain>
	<201011031706.15248.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201011031706.15248.trenn@suse.de>
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
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, stable@kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Len,

On Wednesday 03 November 2010 17:06:14 Thomas Renninger wrote:
> On Wednesday 03 November 2010 07:33:54 Len Brown wrote:
...
> > That function and all these idle workaround flags
> > need to be re-whacked.
> Whatabout this (compile tested (on x86_64/ia64)).
> Adding lkml as this affects x86 core code.
as this mostly affects intel_idle and acpi processor driver,
can you apply this one to your acpi test branch if you are
ok with it.

Thanks,

     Thomas
