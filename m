From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [2.6.30-rc1-git2 regressions] Hibernation broken and
 (minor but annoying) audio problem
Date: Sat, 11 Apr 2009 11:11:52 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.0904111109500.4583__8518.49797550148$1239474036$gmane$org@localhost.localdomain>
References: <200904100057.43827.rjw@sisk.pl>
	<alpine.LFD.2.00.0904091605080.4583@localhost.localdomain>
	<200904101439.43480.rjw@sisk.pl>
	<alpine.LFD.2.00.0904102233330.8559@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.00.0904102233330.8559@localhost.localdomain>
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
Cc: Takashi Iwai <tiwai@suse.de>, LKML <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, pm list <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org



On Fri, 10 Apr 2009, Len Brown wrote:
>
> fastboot also causes the S3 regression here:
> 
> http://bugzilla.kernel.org/show_bug.cgi?id=12936

Looks like the same issue. Does my one-liner fix that case too?

		Linus
