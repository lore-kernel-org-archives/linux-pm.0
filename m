From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 2/2] PM: fix async resume following suspend
	failure
Date: Sat, 18 Jun 2011 21:36:59 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1106182134290.3523-100000__29987.633197061$1308447483$gmane$org@netrider.rowland.org>
References: <201106182242.27814.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201106182242.27814.rjw@sisk.pl>
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
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sat, 18 Jun 2011, Rafael J. Wysocki wrote:

> > Okay; I should have been more careful.  Thanks for fixing this up.
> 
> No problem. :-)
> 
> Appended is what I'm going to push to Linus.
> 
> Thanks,
> Rafael
> 
> ---
> From: Alan Stern <stern@rowland.harvard.edu>
> Subject: PM: Fix async resume following suspend failure

This looks fine.  It's a little hard to test; you have to create an 
artificial suspend failure.  Have you tried doing that?

Alan Stern
