From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PATCH] ACPI patches for 2.6.26-rc0
Date: Wed, 30 Apr 2008 11:55:57 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0804301153100.2980__35562.1149683886$1209581888$gmane$org@woody.linux-foundation.org>
References: <200804301420.11696.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200804301420.11696.lenb@kernel.org>
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
Cc: linux-acpi@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org



On Wed, 30 Apr 2008, Len Brown wrote:
> 
> please pull from: 
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.git release

Ok, this clashed in some nasty ways in drivers/acpi/video.c due to the 
non-racy /proc file creation changes that came through Andrew. I fixed up 
the result, and it *looks* sane (and compiles), but I didn't actually test 
it, and I don't know the code well. Can you double-check.

There were some (smaller) rejects in drivers/misc/intel_menlow.c due to 
two different versions of the same patch from Julia Lawall (again, the 
other came through Andrew), and I picked the one from Andrew because it 
had the later date. But again, you should double-check.

		Linus
