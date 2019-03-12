From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 0/6] PM / Domains: A few clean up and minor fixes
Date: Tue, 12 Mar 2019 10:38:15 +0100
Message-ID: <3110829.dntMgzSNtC@aspire.rjw.lan>
References: <1551878302-8146-1-git-send-email-aisheng.dong@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1551878302-8146-1-git-send-email-aisheng.dong@nxp.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Aisheng Dong <aisheng.dong@nxp.com>
Cc: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "dongas86@gmail.com" <dongas86@gmail.com>, "khilman@kernel.org" <khilman@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday, March 6, 2019 2:25:08 PM CET Aisheng Dong wrote:
> A few clean up and minor fixes
> 
> Dong Aisheng (6):
>   PM / Domains: Improve warn for multiple states but no governor in
>     genpd
>   PM / Domains: Return for all error cases in _genpd_power_off
>   PM / Domains: Remove the unnecessary ->power_off() check in
>     genpd_power_off
>   PM / Domains: Move the Subdomain check into _genpd_power_off
>   PM / QoS: Fix a typo in file description
>   PM / domains: Remove one unnecessary blank line
> 
>  drivers/base/power/domain.c          | 44 ++++++++++++++++--------------------
>  drivers/base/power/domain_governor.c |  1 -
>  drivers/base/power/qos.c             |  2 +-
>  3 files changed, 21 insertions(+), 26 deletions(-)

I've applied patches [1-2/6] (with tags from Ulf) and [5-6/6] from this series
and I'm expecting an update to replace patches [3-4/6].
