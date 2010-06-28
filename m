From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: wait_for_completion_interruptible does not wait !!
Date: Mon, 28 Jun 2010 13:28:18 +0100
Message-ID: <20100628122817.GA27811__32106.386908754$1277728266$gmane$org@sirena.org.uk>
References: <AANLkTikPOcNZk5ISX2WDHSmsPDw_a5_3Ic3owAbO4o0y@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <AANLkTikPOcNZk5ISX2WDHSmsPDw_a5_3Ic3owAbO4o0y@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Suresh Rajashekara <suresh.raj+linuxomap@gmail.com>
Cc: linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sat, Jun 19, 2010 at 11:52:10PM -0700, Suresh Rajashekara wrote:
> I have an application which calls the ioctl of the codec driver to
> know the status of the headset.

> The ioctl waits on a completion variable (using
> wait_for_completion_interruptible).

There is standard support for headset status reporting via the input
layer in mainline, I would recommend implementing your headset detection
in terms of this.

> The problem starts when we suspend the OMAP. The moment we suspend,
> the wait_for_completion_interruptible is interrupted and the ioctl
> returns. Application ends up thinking that the headset was either
> removed/inserted. Our system does an aggressive sleep (wakes up every
> 500 ms and sleeps again) and hence the application gets the event of
> headset every 500 ms.

The input layer does not have this problem.
