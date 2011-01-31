From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH] i2c: OMAP: fix static suspend vs. runtime
	suspend
Date: Mon, 31 Jan 2011 20:58:29 +0530
Message-ID: <266a2f0ec446d693cf9583681ca346e0__28159.6598135822$1296487770$gmane$org@mail.gmail.com>
References: <1a4ad626f3cb73267847e8ac7bd47545@mail.gmail.com>
	<Pine.LNX.4.44L0.1101311010580.1931-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1101311010580.1931-100000@iolanthe.rowland.org>
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
Cc: linux-i2c@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

> -----Original Message-----
> From: Alan Stern [mailto:stern@rowland.harvard.edu]
> Sent: Monday, January 31, 2011 8:43 PM
> To: Rajendra Nayak
> Cc: Kevin Hilman; Ben Dooks; linux-i2c@vger.kernel.org;
linux-pm@lists.linux-foundation.org; linux-
> omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> Subject: Re: [linux-pm] [PATCH] i2c: OMAP: fix static suspend vs.
runtime suspend
>
> On Mon, 31 Jan 2011, Rajendra Nayak wrote:
>
> > Can you elaborate a bit more on how/why runtime PM transitions
> > are disabled during system suspend, and how is it taken care
> > of that a runtime resume of a device works however a subsequent
> > runtime (re)suspend does not?
>
> I'll answer for Kevin.  This is done by the PM core, in order to
> prevent runtime power transitions from interfering with a system power
> transition.  The PM core increments the device's usage_count; this
> prevents the device from being runtime-suspended but it allows
> runtime-resume calls to go through.

Thanks, I did remember seeing the pm_runtime_get_noresume()
in dpm_prepare(). Just did not correlate it was the same Kevin
was trying to say.

Regards,
Rajendra

>
> Alan Stern
