From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: 2.6.38-rc7-git4: Reported regressions from 2.6.37
Date: Sun, 6 Mar 2011 10:47:05 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1103061041440.13175-100000__26134.5623679974$1299426492$gmane$org@netrider.rowland.org>
References: <t0W8Ea1iKeB.A.6xD.Lp3cNB@chimera>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <t0W8Ea1iKeB.A.6xD.Lp3cNB@chimera>
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
Cc: Florian Mickler <florian@mickler.org>, Linux PM List <linux-pm@lists.linux-foundation.org>, Kernel Testers List <kernel-testers@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Maciej Rutecki <maciej.rutecki@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Sun, 6 Mar 2011, Rafael J. Wysocki wrote:

> Bug-Entry	: http://bugzilla.kernel.org/show_bug.cgi?id=29902
> Subject		: System suspend failed after 1-2 successful resumes
> Submitter	: Alex Terekhov <a.terekhov@gmail.com>
> Date		: 2011-02-25 22:24 (10 days old)

As far as I know, this isn't a regression.  Most likely it is present 
in earlier kernels too, but the OP hasn't tried any.

Anyway, it appears to be a combination of problems.  One is a bug, for 
which a patch has been written and will be submitted soon.  The other 
is unclear, it is probably a hardware issue.

Alan Stern
