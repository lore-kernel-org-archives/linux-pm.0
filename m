From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC][PATCH 4/4] PM: Permit registrarion of
 parentless devices during system suspend
Date: Wed, 15 Dec 2010 15:58:38 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1012151546320.2171-100000__34386.4981703975$1292453130$gmane$org@iolanthe.rowland.org>
References: <201012150134.27858.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201012150134.27858.rjw@sisk.pl>
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
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 15 Dec 2010, Rafael J. Wysocki wrote:

> > You could clear in_suspend at the start of device_resume.
> 
> The patch below (replacing [3/4]) does that (the second clearing is for
> devices whose ->suspend() methods have not been called, which can happen if
> there's a suspend error).
> 
> I hope the USB part is still valid?

It is.  Although now that I look at it, the third USB test is (and has
always been) totally wrong.  It should be removed completely.  I'll do 
that separately; for now your update won't affect the way it works.

Alan Stern
