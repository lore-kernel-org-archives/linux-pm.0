From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC] Add the "icebox"
Date: Wed, 7 Nov 2007 15:02:26 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0711071500590.6432-100000@iolanthe.rowland.org>
References: <20071107194934.GA31138@linux.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20071107194934.GA31138@linux.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Mark Gross <mgross@linux.intel.com>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 7 Nov 2007, Mark Gross wrote:

> On Mon, Nov 05, 2007 at 04:27:47PM -0500, Alan Stern wrote:
> > Rafael:
> > 
> > This patch adds the icebox, for use by kernel threads that want to 
> > freeze themselves without using the freezer -- which is likely to crop 
> > up when the freezer gets eliminated.
> 
> Why can't we have a runque per cpu that never gets scheduled and we simply
> migrate the treads to those?  no more yield loops.

Indeed.  Why stop there?  Why not eliminate wait_event() entirely, or
rather, re-implement it as you suggest?  :-)

Alan Stern
