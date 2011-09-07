From: Oleg Nesterov <oleg@redhat.com>
Subject: [PATCH 0/1] freezer: fix
	wait_event_freezable/__thaw_task races
Date: Wed, 7 Sep 2011 20:21:56 +0200
Message-ID: <20110907182156.GA13909__4530.81095261059$1315420074$gmane$org@redhat.com>
References: <1314988070-12244-1-git-send-email-tj@kernel.org>
	<1314988070-12244-7-git-send-email-tj@kernel.org>
	<20110904184626.GA30101@redhat.com>
	<20110905023315.GB9807@htj.dyndns.org>
	<20110905162012.GA4445@redhat.com>
	<20110906032846.GA18425@mtj.dyndns.org>
	<20110906151836.GA15568@redhat.com>
	<20110906152539.GA16899@redhat.com>
	<20110906155332.GF18425@mtj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20110906155332.GF18425@mtj.dyndns.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Tejun Heo <tj@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: containers@lists.linux-foundation.org, paul@paulmenage.org, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi,

On 09/07, Tejun Heo wrote:
> >
> > I meant, unless the caller plays with allow_signal(), it has all rights to do
> >
> > 	if (wait_event_freezable(...))
> > 		BUG();
> >
> > This becomes correct with the code above.
>
> Yeap, sure, w/ freezable_with_signal gone, the above should work fine.
> Care to create a patch?

Sure.

But. Tejun, Rafael, I have to rely on your review. I have no idea how
can I test this change. Hopfully it is simple enough, though.

And. wait_event_freezable_timeout() obviously has another problem,
although I hope this is fine. The caller can spend a lot of time in
refrigerator, shouldn't we update "timeout" in this case? I hope we
shouldn't.

Oleg.
