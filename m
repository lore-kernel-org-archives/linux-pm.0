From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: 2.6.32-rc1-git2: Reported regressions from 2.6.31
Date: Fri, 02 Oct 2009 15:00:37 +0200
Message-ID: <4AC5F975.6060505__1322.69485989145$1254488792$gmane$org@s5r6.in-berlin.de>
References: <9UCePxij8cB.A.VCG.-3SxKB@chimera>
	<1254469139.3531.19.camel@ht.satnam>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1254469139.3531.19.camel@ht.satnam>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jaswinder Singh Rajput <jaswinder@kernel.org>
Cc: Adrian Bunk <bunk@kernel.org>, DRI <dri-devel@lists.sourceforge.net>, Linux SCSI List <linux-scsi@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, Linux Wireless List <linux-wireless@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Natalie Protasevich <protasnb@gmail.com>, Linux ACPI <linux-acpi@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Kernel Testers List <kernel-testers@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Linux PM List <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Jaswinder Singh Rajput wrote:
> If you add one more entry say "Suspected commit :" then it will be great
> and will solve regressions much faster.

Will?  Might.

> You can request submitter to
> submit 'suspected commit' by git bisect and also specify git bisect
> links like : (for more information about git bisect check
> http://kerneltrap.org/node/11753)

I disagree.  A reporter should only be asked to bisect (using git or
other tools) /if/ a developer determined that bisection may speed up the
debugging process or is the only remaining option to make progress with
a bug.

It would be wrong to steal a reporter's valuable time by asking for
bisection before anybody familiar with the matter even had a first look
at the report.

Remember:
  - Not all bugs can be economically narrowed down by bisection.
  - Bisection requires skills, rigor, and time.
  - Alas there are considerable sections in our kernel history which
    are not bisectable.
-- 
Stefan Richter
-=====-==--= =-=- ---=-
http://arcgraph.de/sr/
