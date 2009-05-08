From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 3/9] PM: suspend_block: Abort task freezing
	if a suspend_blocker is active.
Date: Fri, 8 May 2009 02:22:24 +0200
Message-ID: <200905080222.25101.rjw@sisk.pl>
References: <1241583529-5092-1-git-send-email-arve@android.com>
	<1241583529-5092-4-git-send-email-arve@android.com>
	<20090505195753.GE1379@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090505195753.GE1379@ucw.cz>
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
To: Pavel Machek <pavel@ucw.cz>
Cc: ncunningham@crca.org.au, u.luckas@road.de, swetland@google.com, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Tuesday 05 May 2009, Pavel Machek wrote:
> Hi!
> 
> > If a suspend_blocker is active, suspend will fail anyway. Since
> > try_to_freeze_tasks can take up to 20 seconds to complete or fail, aborting
> 
> Please fix try_to_freeze not to take significant time rather than
> this...

FYI, I agree with this patch.

Best,
Rafael
