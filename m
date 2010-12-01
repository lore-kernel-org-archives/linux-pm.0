From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] PM: Prevent dpm_prepare() from returning
 errors unnecessarily
Date: Wed, 1 Dec 2010 10:15:54 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1012011013500.1629-100000__40891.2852676169$1291216659$gmane$org@iolanthe.rowland.org>
References: <201011302327.24222.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201011302327.24222.rjw@sisk.pl>
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

On Tue, 30 Nov 2010, Rafael J. Wysocki wrote:

> > Provided you repair the error that Lei Ming pointed out.  That's the 
> > problem with functions that return Boolean values -- you have to name 
> > them very carefully.  Ideally the name should be a predicate or a
> > question.
> 
> I already have fixed it.
> 
> The name is unfortunate indeed, perhaps it's better to call that function
> pm_new_wakeup_events() or something like this.

Or pm_any_wakeup_events().  And reverse the meaning of the return
value, of course -- it would be good to explain the return value in 
the kerneldoc.

Alan Stern
