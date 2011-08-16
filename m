From: Santosh <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 12/15] OMAP4: powerdomain data: add wake-up
	latency figures
Date: Tue, 16 Aug 2011 19:56:45 +0530
Message-ID: <4E4A7E25.8020701__44243.9815415584$1313505130$gmane$org@ti.com>
References: <1313502198-9298-1-git-send-email-j-pihet@ti.com>
	<1313502198-9298-13-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1313502198-9298-13-git-send-email-j-pihet@ti.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: jean.pihet@newoldbits.com
Cc: markgross@thegnar.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>
List-Id: linux-pm@vger.kernel.org

On Tuesday 16 August 2011 07:13 PM, jean.pihet@newoldbits.com wrote:
> From: Vishwanath BS<vishwanath.bs@ti.com>
>
> This patch adds wake up latency numbers for OMAP4. Note that these are
> preliminary numbers and need to be relooked.
>
> Signed-off-by: Vishwanath BS<vishwanath.bs@ti.com>
>
> The INACTIVE state is added as unsupported.
>
In that case, don't add that support in first place. When INA support is
getting added, you can update these as well.
