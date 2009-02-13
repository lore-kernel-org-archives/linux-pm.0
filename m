From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 01/13] PM: Add wake lock api.
Date: Fri, 13 Feb 2009 14:06:54 +0000
Message-ID: <20090213140654.GC26549@srcf.ucam.org>
References: <1233802226-23386-1-git-send-email-arve@android.com>
	<13B9B4C6EF24D648824FF11BE89671620377169672@dlee02.ent.ti.com>
	<20090213011035.GA8664@srcf.ucam.org>
	<200902131155.07530.u.luckas@road.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200902131155.07530.u.luckas@road.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Uli Luckas <u.luckas@road.de>
Cc: "swetland@google.com" <swetland@google.com>, linux-pm@lists.linux-foundation.org, "ncunningham@crca.org.au" <ncunningham@crca.org.au>
List-Id: linux-pm@vger.kernel.org

On Fri, Feb 13, 2009 at 11:55:06AM +0100, Uli Luckas wrote:
> On Friday, 13. February 2009, Matthew Garrett wrote:
> > I dislike the kernel-side use of wakelocks. They're basically equivalent
> > to a device returning -EBUSY during the suspend phase, which is
> > something that can be done without any kernel modifications. 
> That's absouletely wrong. With wake locks, you are in a pre suspend state and 
> stay there until all wakelocks are released. Then you go to sleep.
> 
> With -EBUSY the kernel gives up on suspend until some source triggers it 
> again. When exactly should suspend then be retried?

Ok, so let's think about this differently. What we want is simply for 
drivers to be able to block an automatic suspend. For performance 
reasons we want to keep track of this state without calling into the 
entire driver tree. Now that the userspace API can automatically clean 
up after itself, why is this not just a simple counter? Kernel API would 
be something like:

(input arrives)
inhibit_suspend();
(input queue is emptied)
uninhibit_suspend();

perhaps using the device struct or something as a token for debug 
purposes. Userland ABI would then be a single /dev/inhibit_suspend, 
with the counter being bumped each time an application opens it. It'll 
automatically be dropped if the application exits without cleaning up.

This seems simpler and also avoids any arguments about the naming 
scheme. What am I missing?
-- 
Matthew Garrett | mjg59@srcf.ucam.org
