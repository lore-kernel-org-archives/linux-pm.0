From: "Huang, Ying" <ying.huang@intel.com>
Subject: Re: [PATCH 2/2] Kexec jump: Kexec jump
Date: Fri, 13 Jul 2007 17:20:23 +0000
Message-ID: <1184347223.4523.22.camel__32655.975680291$1184318522$gmane$org@caritas-dev.intel.com>
References: <1184167836.12556.15.camel@caritas-dev.intel.com>
	<200707122158.39024.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200707122158.39024.rjw@sisk.pl>
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
Cc: linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

On Thu, 2007-07-12 at 21:58 +0200, Rafael J. Wysocki wrote:

> I know a little about kexec.
> 
> Could you please tell me what I should know/read to understand this patch?
> 

It is sufficient to read the kernel/kexec.c,
arch/i386/kernel/machine_kexec.c and arch/i386/kernel/relocate_kernel.S.

Best Regards,
Huang Ying
