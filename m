From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH ver. 2] PM: allow for usage_count > 0 in
 pm_runtime_get()
Date: Thu, 3 Dec 2009 15:24:09 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0912031507410.4795-100000@iolanthe.rowland.org>
References: <200912032103.34989.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200912032103.34989.rjw@sisk.pl>
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
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 3 Dec 2009, Rafael J. Wysocki wrote:

> > and obtain the same effect.  So I don't know...  Should
> > pm_runtime_get() call pm_request_resume() always, or only when the
> > state is SUSPENDING or SUSPENDED?  Should we offer two routines and let
> > people choose which they want?
> 
> I'd prefer to keep the current semantics, ie. drop the patch, at least for now.

Okay.  I'll rewrite my own code to avoid calling it.

Alan Stern
