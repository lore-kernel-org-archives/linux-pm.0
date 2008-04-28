From: David Brownell <david-b@pacbell.net>
Subject: Re: [RESEND patch 2.6.25] ACPI uses device_may_wakeup()
	policy inputs
Date: Mon, 28 Apr 2008 15:28:14 -0700
Message-ID: <200804281528.14629.david-b__32939.5231594846$1209421923$gmane$org@pacbell.net>
References: <200803201408.33466.david-b@pacbell.net>
	<1209386885.884.9.camel@yakui_zhao.sh.intel.com>
	<1209372607.3538.107.camel@rzhang-crestline.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1209372607.3538.107.camel@rzhang-crestline.sh.intel.com>
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
To: Zhang Rui <rui.zhang@intel.com>
Cc: Zhao Yakui <yakui.zhao@intel.com>, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Monday 28 April 2008, Zhang Rui wrote:
> > > 
> > Yes. What your said is right. If your patch is applied, whether the PCI
> > device can wake the sleeping system is controlled by device driver.
> 
> This may cause some "regressions", something like system resumes
> immediately after enter S3. This should rather be a driver/device
> problem which rises a wake up event when it's suspend.
> The right thing to do is to disable the wake up flag for this device.
> The patch was dropped for this reason last time it's merged and we
> should take good care of it this time. :)
> 
> Dave,
> Maybe we should state this in the change log?

I already seem to have added that in the changelog for the last
version of the patch I sent ...

- dave
