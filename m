From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Singlethread vs. freezable workqueues
Date: Mon, 21 May 2007 21:54:33 +0200
Message-ID: <200705212154.34490.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0705211531530.5679-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0705211531530.5679-100000@iolanthe.rowland.org>
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
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Oleg Nesterov <oleg@tv-sign.ru>
List-Id: linux-pm@vger.kernel.org

Hi,

On Monday, 21 May 2007 21:33, Alan Stern wrote:
> Raphael:
> 
> Are we now committed to making freezable workqueues always 
> singlethreaded?  Is it at all likely to change back?  Or should I 
> introduce a "create_singlethread_freezeable_workqueue" macro?

This was done as a quick fix of an issue with one driver that started to use
(broken) freezable workqueues when we were not watching. ;-)

We are going to have multithread freezable workqueues as well, but that'll
take some time.  We've discussed this a bit with Oleg and I believe he has an
idea of how it can be done cleanly.

Greetings,
Rafael
