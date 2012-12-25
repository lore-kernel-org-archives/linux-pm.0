From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 11/25] pm: don't use [delayed_]work_pending()
Date: Tue, 25 Dec 2012 08:44:33 -0800
Message-ID: <20121225164433.GG10220@mtj.dyndns.org>
References: <1356141435-17340-1-git-send-email-tj@kernel.org>
 <1356141435-17340-12-git-send-email-tj@kernel.org>
 <1652427.IL3F6yol0I@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1652427.IL3F6yol0I@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hello, Rafael.

On Sat, Dec 22, 2012 at 12:53:29PM +0100, Rafael J. Wysocki wrote:
> On Friday, December 21, 2012 05:57:01 PM Tejun Heo wrote:
> > There's no need to test whether a (delayed) work item in pending
> > before queueing, flushing or cancelling it.  Most uses are unnecessary
> > and quite a few of them are buggy.
> 
> Can you please say why they are buggy?

Usually one of the following two reasons.

* The user gets confused and fails to handle !PENDING && currently
  executing properly.

* work_pending() doesn't have any memory barrier and the caller
  assumes work_pending() is somehow properly synchronized by itself.

Thanks.

-- 
tejun
