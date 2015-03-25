From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 00/09] Some kernel/time cleanups (related to timer_suspend/resume)
Date: Wed, 25 Mar 2015 13:04:23 +0100
Message-ID: <4241632.Wi7SZdKMQs@vostro.rjw.lan>
References: <20150216121435.203983131@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150216121435.203983131@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org, tglx@linutronix.de, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi,

On Monday, February 16, 2015 01:14:35 PM Peter Zijlstra wrote:
> Hi,
> 
> While working with Rafael on the suspend to idle machinery Thomas made these
> cleanups; since one might as well clean code up while you've done the work of
> thinking through it again.
> 
> As it stands there's very little overlap between Rafael's series and this one
> aside from a few trivial fixups. So we'll merge them seperately.

Since some of the original Thomas' patches needed to be rebased on top of the
suspend-to-idle material that went in during the 4.0 merge window, I did
that with the patches related to the suspending/resuming of ticks which
follow.

Thanks,
Rafael
