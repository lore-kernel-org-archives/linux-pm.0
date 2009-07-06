From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: PM interface to suspend/resume individual/specific
	device
Date: Mon, 6 Jul 2009 22:32:42 +0200
Message-ID: <200907062232.42682.rjw@sisk.pl>
References: <F12CE1A68F023D498A2691C7B539311503655A9A@ZMY16EXM66.ds.mot.com>
	<200907052330.48382.rjw@sisk.pl>
	<F12CE1A68F023D498A2691C7B539311503655C1B@ZMY16EXM66.ds.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <F12CE1A68F023D498A2691C7B539311503655C1B@ZMY16EXM66.ds.mot.com>
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
To: HU TAO-TGHK48 <taohu@motorola.com>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Monday 06 July 2009, HU TAO-TGHK48 wrote:
> 
> Hi, Rafael
> 
> Thank for the answer.
> 
> 2 more things
> A) The suspend/resume API assumes that  all user space process/kthread
> access to driver will be frozen first
>     This avoids race condition that processes/threads  are accessing
> driver while suspend()/resume() of the driver is called at the same
> time.
>     
>     Is my understanding correct?

Generally, it is, but while all user space processes are frozen before every
attempt to put the system into a sleep state, only some of the kernel threads
are frozen.

> B) I noticed your "Run-time PM framework" patch was submitted recently
>     Do you think it is fair to allow user space to trigger run-time
> suspend/resume for specific device?
>
>     Sine the run-time suspend/resume would be system independent per my
> understanding.

There's a problem that the user space can potentially trigger a run-time
suspend of a device at a wrong time.  It's probably better to let the driver
decide.

Best,
Rafael
