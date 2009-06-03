From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 02/04] Driver Core: Add idle and wakeup
	functions
Date: Wed, 3 Jun 2009 11:05:21 +0200
Message-ID: <200906031105.21977.rjw__25634.9550946199$1244019979$gmane$org@sisk.pl>
References: <20090527100625.29671.43166.sendpatchset@rx1.opensource.se>
	<200905282329.09804.rjw@sisk.pl>
	<aec7e5c30905282210h23f0edc0vad4e29dd52c2e99c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <aec7e5c30905282210h23f0edc0vad4e29dd52c2e99c@mail.gmail.com>
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
To: Magnus Damm <magnus.damm@gmail.com>
Cc: paul@pwsan.com, linux-sh@vger.kernel.org, gregkh@suse.de, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Friday 29 May 2009, Magnus Damm wrote:
> 2009/5/29 Rafael J. Wysocki <rjw@sisk.pl>:
> > On Wednesday 27 May 2009, Magnus Damm wrote:
> >> From: Magnus Damm <damm@igel.co.jp>
> >>
> >> Add platform_device_idle() and platform_device_wakeup()
> >> and allow architectures to implement their own versions
> >> of these if CONFIG_HAVE_PLATFORM_IDLE_WAKEUP is set.
> >>
> >> Signed-off-by: Magnus Damm <damm@igel.co.jp>
> >> ---
> >>
> >>  Yes, this needs documentation. See [00/04] for now.
> >>
> >>  arch/Kconfig                    |    3 +++
> >>  include/linux/platform_device.h |    8 ++++++++
> >>  2 files changed, 11 insertions(+)
> >>
> >> --- 0002/arch/Kconfig
> >> +++ work/arch/Kconfig 2009-05-26 12:31:06.000000000 +0900
> >> @@ -115,3 +115,6 @@ config HAVE_DEFAULT_NO_SPIN_MUTEXES
> >>
> >>  config HAVE_PLATFORM_DEVICE_ARCHDATA
> >>       bool
> >> +
> >> +config HAVE_PLATFORM_DEVICE_IDLE_WAKEUP
> >
> > Again, I'm not sure if the new CONFIG_ option is really necessary.
> 
> At least it could be combined into a single option for platform device
> runtime pm. So no need to have separate kconfig options for [02/04]
> and [03/04].
> 
> We could also drop the #ifdef stuff and go for weak symbols that can
> be overriden by architecture code.

The weak symbols don't work really AFAICS.  People have been replacing them
with alternative things recently.

> I'm open to suggestions. =)

Well, that depends on what exactly you want to achieve. :-)

Best,
Rafael
