From: Heinz Diehl <htd@fancy-poultry.org>
Subject: Re: [2.6.30-rc1-git2 regressions] Hibernation broken	and
	(minor but annoying) audio problem
Date: Sat, 11 Apr 2009 21:00:37 +0200
Message-ID: <20090411190037.GA5230__9502.67149969495$1239634974$gmane$org@fancy-poultry.org>
References: <200904100057.43827.rjw@sisk.pl>
	<alpine.LFD.2.00.0904091605080.4583@localhost.localdomain>
	<200904101439.43480.rjw@sisk.pl>
	<alpine.LFD.2.00.0904102233330.8559@localhost.localdomain>
	<alpine.LFD.2.00.0904111109500.4583@localhost.localdomain>
Reply-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0904111109500.4583@localhost.localdomain>
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
Cc: Takashi Iwai <tiwai@suse.de>, LKML <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, pm list <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On 11.04.2009, Linus Torvalds wrote: 

[Len Brown:]
> > fastboot also causes the S3 regression here:
> > http://bugzilla.kernel.org/show_bug.cgi?id=12936
 
> Looks like the same issue. Does my one-liner fix that case too?

http://bugzilla.kernel.org/show_bug.cgi?id=13063

Your one-liner fixes this bug, too. Without the revertion mentioned in the
bugreport applied!

Regards,
Heinz.
