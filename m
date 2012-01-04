From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 0/3] coupled cpuidle state support
Date: Wed, 4 Jan 2012 18:27:29 +0100
Message-ID: <CAMQu2gwsw+RC+Y9P8r9Yjy+ADuQ-tPzcXPPncLxMjjb3tvdbbQ__27096.0106900477$1325698089$gmane$org@mail.gmail.com>
References: <1324426147-16735-1-git-send-email-ccross@android.com>
	<87sjjw70zs.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <87sjjw70zs.fsf@ti.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Kevin Hilman <khilman@ti.com>
Cc: Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org, Amit Kucheria <amit.kucheria@linaro.org>, Colin Cross <ccross@android.com>, linux-tegra@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, Arjan van de Ven <arjan@linux.intel.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Wed, Jan 4, 2012 at 1:41 AM, Kevin Hilman <khilman@ti.com> wrote:
> Colin Cross <ccross@android.com> writes:
>
>
>> This patch series implements an alternative solution, where each
>> cpu will wait in the WFI state until all cpus are ready to enter
>> a coupled state, at which point the coupled state function will
>> be called on all cpus at approximately the same time.
>
> This looks great, and is certainly preferred to hotplug IMO.
>
> [...]
>
>> None of the platforms I work with have an SMP idle implementation
>> upstream, so I can't easily show a patch that converts a platform
>> from hotplug governor to coupled cpuidle states.
>
> Basic OMAP4 CPUidle support is in now queued for v3.3 (see omap4
> branch Tony's tree[1].)
>
> Can you (or Santosh) send a patch that adds coupled support to that
> driver so it can see some broader testing on OMAP4?
>
I briefly attempted OMAP4 idle with this series but had some lock
up related issues which we faced in the older development.

Then I got busy into other activities which will keep me occupied for
next few weeks. I will be happy to share the patches in case some one
would like to have a look till then.

Regards
Santosh
