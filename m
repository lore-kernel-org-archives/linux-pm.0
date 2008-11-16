From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.6.28-rc5: Reported regressions from 2.6.27
Date: Sun, 16 Nov 2008 18:29:53 +0000
Message-ID: <20081116182953.6231ae8c__39082.0815846839$1226860345$gmane$org@lxorguk.ukuu.org.uk>
References: <VwdsQNEjR_C.A.CiD.9_FIJB@chimera>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <VwdsQNEjR_C.A.CiD.9_FIJB@chimera>
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
Cc: Adrian Bunk <bunk@kernel.org>, Linux SCSI List <linux-scsi@vger.kernel.org>, Linus@smtp1.linux-foundation.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Natalie Protasevich <protasnb@gmail.com>, Linux ACPI <linux-acpi@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Kernel Testers List <kernel-testers@vger.kernel.org>, Torvalds <torvalds@linux-foundation.org>, Linux PM List <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

>      the majority of these patches have not been merged for over two weeks
>      (for almost three weeks in many cases and for over a _month_ in one case).
>      IMO, this is insane.]

Some of them are quite serious too - some stuff is basically unusable in
2.6.28rc due to the vmalloc bug.

Is there any reason why someone (Rafael ?) shouldn't simply submit all of
those patches that look sensible, are reported to fix regressions and
whose maintainer has not provided a reason to NOT apply them into the
tree ?

Alan
