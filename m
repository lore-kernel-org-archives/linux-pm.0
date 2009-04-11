From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [2.6.30-rc1-git2 regressions] Hibernation broken and
 (minor but annoying) audio problem
Date: Sat, 11 Apr 2009 12:55:23 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.0904111253520.4583__38378.0006821782$1239480097$gmane$org@localhost.localdomain>
References: <200904100057.43827.rjw@sisk.pl>
	<alpine.LFD.2.00.0904101817100.4583@localhost.localdomain>
	<49DFFC05.7070509@linux.intel.com>
	<200904112138.26518.rjw@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200904112138.26518.rjw@suse.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Takashi Iwai <tiwai@suse.de>, LKML <linux-kernel@vger.kernel.org>, linux-pm@lists.linux-foundation.org, Arjan van de Ven <arjan@linux.intel.com>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org



On Sat, 11 Apr 2009, Rafael J. Wysocki wrote:
> 
> FWIW, I applied the appended patch and it fixed the problem for me.

I think that patch is probably the right thing to do regardless, but I 
also think it doesn't obviate the need for also doing so at module loading 
time. 

I'm pretty sure that calling scsi_complete_async_scans() won't protect 
against an async USB bus scan, for example.

But I do think your patch is probably worth doing anyway.

		Linus
