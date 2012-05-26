From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: ehci_hcd related S3 lockup on ASUS laptops, again
Date: Sat, 26 May 2012 22:28:05 +0200
Message-ID: <201205262228.06053.rjw@sisk.pl>
References: <20120419163055.GB11484@belkar.wrar.name>
	<Pine.LNX.4.44L0.1205252157430.24286-100000@saphir.localdomain>
	<20120526085135.GB5012@belkar.wrar.name>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20120526085135.GB5012@belkar.wrar.name>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
Cc: Andrey Rahmatullin <wrar@wrar.name>, Steven Rostedt <rostedt@goodmis.org>
List-Id: linux-pm@vger.kernel.org

On Saturday, May 26, 2012, Andrey Rahmatullin wrote:
> On Fri, May 25, 2012 at 10:01:44PM -0400, Alan Stern wrote:
> > Steve and Andrey:
> > 
> > It turns out that the proposed solution for your problem causes a
> > regression on other ASUS computers (see Bugzilla 43278).  Rafael's got a
> > proposal for a replacement.
> > 
> > Can you try out the patch attached to comment #61 of Bugzilla 42728?  It
> > may even allow USB wakeup to work for you (but I wouldn't count on it!).
> > Thanks.
> With the patch from #61 and with 151b61284776 reverted suspending works,
> though USB resuming doesn't.

Thanks for testing!

Rafael
