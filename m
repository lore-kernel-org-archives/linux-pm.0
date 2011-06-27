From: Todd Poynor <toddpoynor@google.com>
Subject: Re: [RFC/PATCH 8/9] OMAP: PM CONSTRAINTS: implement the
 devices wake-up latency constraints
Date: Mon, 27 Jun 2011 11:33:45 -0700
Message-ID: <20110627183345.GA6187__2482.07064946673$1309199699$gmane$org@google.com>
References: <1308926286-30445-1-git-send-email-j-pihet@ti.com>
	<1308926286-30445-9-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1308926286-30445-9-git-send-email-j-pihet@ti.com>
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
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>
List-Id: linux-pm@vger.kernel.org

On Fri, Jun 24, 2011 at 04:38:05PM +0200, jean.pihet@newoldbits.com wrote:
...
> +	/* Find the associated omap_device for dev */
> +	od = container_of(pdev, struct omap_device, pdev);
> +	if (!od || (od->hwmods_cnt != 1)) {
> +		pr_err("%s: Error: No unique hwmod for device %s\n",
> +		       __func__, dev_name(pm_qos_req->dev));
> +		return -EINVAL;

Check for !od can be dropped... if there's a check for !pdev needed
can add that, but container_of() won't return NULL for a valid
contained field.


Todd
