From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 01/13] PM: Add wake lock api.
Date: Wed, 11 Feb 2009 09:58:23 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0902110955490.3056-100000@iolanthe.rowland.org>
References: <20090211044736.GB9980@bulgaria.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090211044736.GB9980@bulgaria.corp.google.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Brian Swetland <swetland@google.com>
Cc: ncunningham@crca.org.au, u.luckas@road.de, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Tue, 10 Feb 2009, Brian Swetland wrote:

> [Pavel Machek <pavel@ucw.cz>]
> > > 
> > > wake_lock never blocks.
> > 
> > Wakelock is really bad name: it is not a lock and it does not protect
> > wake. I'd say we need better name here.
> 
> I agree with you here -- I've had this discussion with Arve previously,
> but have been unable to offer a compelling alternative name.  Anybody
> have a good idea?

delay_sleep or delaysleep?  block_sleep or blocksleep?  Any of the 
above with "sleep" replaced by "suspend"?

Alan Stern
