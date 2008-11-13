From: Jens Axboe <jens.axboe@oracle.com>
Subject: Re: Suspend to disk broken in latest 2.6.28-rc3
Date: Thu, 13 Nov 2008 12:40:02 +0100
Message-ID: <20081113114001.GC26778__21441.3836751648$1226576664$gmane$org@kernel.dk>
References: <20081109195033.GA1335@mobydick> <20081112184236.GR26778@kernel.dk>
	<200811122237.03882.rjw@sisk.pl>
	<200811121357.02233.jbarnes@virtuousgeek.org>
	<20081113073341.GV26778@kernel.dk>
	<20081113084144.GX26778@kernel.dk> <491C0C31.1090003@upcomillas.es>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <491C0C31.1090003@upcomillas.es>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Romano Giannetti <romanol@upcomillas.es>
Cc: Mathieu Chouquet-Stringer <mchouque@free.fr>, linux-kernel@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>, Pavel Machek <pavel@suse.cz>, Alex Deucher <alexdeucher@gmail.com>, Dave Airlie <airlied@redhat.com>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thu, Nov 13 2008, Romano Giannetti wrote:
> 
> Jens Axboe wrote:
> >On Thu, Nov 13 2008, Jens Axboe wrote:
> >>On Wed, Nov 12 2008, Jesse Barnes wrote:
> 
> >>Yep, it's intel graphics, sorry I should have mentioned that!
> >>
> >>>Jens, does suspend/resume work if you just do it from the console
> >>>(echo mem > /sys/power/state) with i915 loaded?
> >>Let me try that right away.
> >
> >Seems to work fine from the console, even with i915 loaded and X on the
> >login screen on a different vt.
> >
> 
> Isn't a VC switch used on suspend/resume? If yes, this could be an
> incarnation of http://bugzilla.kernel.org/show_bug.cgi?id=11947

Nope, no vc switch in my setup. This is on ubuntu, when I ran opensuse
on this machine it did do vc switches by default. The vc switch can help
work around mode setting restore problems, but it seems the intel
graphics doesn't need it.

-- 
Jens Axboe
