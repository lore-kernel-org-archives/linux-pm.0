From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [2.6 patch] make suspend_device() static
Date: Mon, 28 Jan 2008 23:21:24 +0100
Message-ID: <200801282321.25567.rjw__39800.3181013793$1201559222$gmane$org@sisk.pl>
References: <20080128221024.GO8767@does.not.exist>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080128221024.GO8767@does.not.exist>
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
To: Adrian Bunk <bunk@kernel.org>
Cc: pavel@suse.cz, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Monday, 28 of January 2008, Adrian Bunk wrote:
> suspend_device() can become static.

That's correct.  I'll push the patch to Len.

> Signed-off-by: Adrian Bunk <bunk@kernel.org>
> 
> ---
> 344fcfcea0df8cbaa83e10d7e66b826ead67290b 
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index 200ed5f..cfcc54f 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -414,7 +414,7 @@ EXPORT_SYMBOL_GPL(device_power_down);
>   *	@dev:	Device.
>   *	@state:	Power state device is entering.
>   */
> -int suspend_device(struct device *dev, pm_message_t state)
> +static int suspend_device(struct device *dev, pm_message_t state)
>  {
>  	int error = 0;
>  
> 
