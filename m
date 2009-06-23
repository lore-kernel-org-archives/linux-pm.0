From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [patch update 3] PM: Introduce core framework for
 run-time PM of I/O devices
Date: Tue, 23 Jun 2009 13:02:15 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0906231043290.3209-100000__35854.4690687724$1245776655$gmane$org@iolanthe.rowland.org>
References: <200906221749.50784.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200906221749.50784.rjw@sisk.pl>
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
Cc: Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-pm@lists.linux-foundation.org, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

On Mon, 22 Jun 2009, Rafael J. Wysocki wrote:

> > And of course, synchronous pm_runtime_resume should always increment the 
> > counter.
> 
> Sure.

Now that I've thought about it some more, I decided that we might want
to be more flexible.  Without subjecting you to the entire line of
reasoning, let's just say that I'm starting to wonder whether it's such
a good idea to tie the counter increments to the PM core runtime resume
calls at all.

Maybe it would be better (easier to use, less constraining) to require
the runtime_resume callback to do its own pm_runtime_get.  That way the
driver would be entirely responsible for managing the usage counter;
the PM core wouldn't be involved.  pm_runtime_get would simply
increment the counter, so it could be used even in interrupt context.  
At the moment, I don't see any need for it to queue an autoresume
request if the device happens to be suspended.

Something like this was probably your intention all along.  :-)

Alan Stern
