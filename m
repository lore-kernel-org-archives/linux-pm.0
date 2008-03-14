From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 0/2] PM: Remove legacy PM
Date: Thu, 13 Mar 2008 21:59:08 -0800
Message-ID: <200803132259.09518.david-b__40450.7646141157$1205474581$gmane$org@pacbell.net>
References: <200803132351.19794.rjw@sisk.pl> <47DA0DDB.7010403@davidnewall.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <47DA0DDB.7010403@davidnewall.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
Cc: David Newall <davidn@davidnewall.com>, LKML <linux-kernel@vger.kernel.org>, Ralf Baechle <ralf@linux-mips.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thursday 13 March 2008, David Newall wrote:
> > The first of the following two patches removes the legacy PM infrastructure
> > and the second one removes some of its remnants from the MIPS tree.
> 
> What does "legacy PM" mean?

It's stuff that's so ancient nobody uses it any more... it's been
deprecated over a year (f89bce3d9afc6b1fb898ae176df4962c1303ee86),
and at that time only one ancient (Amiga?) driver even tried to
use the notification scheme it provided.

Glad to see this finally go away!

- Dave
