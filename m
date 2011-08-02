From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 03/13] PM: QoS: extend the in-kernel API with
	per-device latency constraints
Date: Tue, 02 Aug 2011 11:01:07 -0700
Message-ID: <87zkjrk80s.fsf__39104.1345465512$1312308193$gmane$org@ti.com>
References: <1311841821-10252-1-git-send-email-j-pihet@ti.com>
	<1311841821-10252-4-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1311841821-10252-4-git-send-email-j-pihet@ti.com> (jean pihet's
	message of "Thu, 28 Jul 2011 10:30:10 +0200")
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
Cc: markgross@thegnar.org, broonie@opensource.wolfsonmicro.com, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>
List-Id: linux-pm@vger.kernel.org

jean.pihet@newoldbits.com writes:

> From: Jean Pihet <j-pihet@ti.com>
>
> Extend the PM QoS kernel API:
> - add a new PM QoS class PM_QOS_DEV_LATENCY for device wake-up latency
> constraints
> - make the pm_qos_add_request API more generic by using a parameter of
> type struct pm_qos_parameters
> - minor clean-ups and rename of struct fields:
>   . rename pm_qos_class to class and pm_qos_req to req in internal code
>   . consistenly use req and params as the API parameters
>   . rename struct pm_qos_request_list to struct pm_qos_request
> - update the in-kernel API callers to the new API
>
> Signed-off-by: Jean Pihet <j-pihet@ti.com>
> ---
>  arch/arm/plat-omap/i2c.c               |   20 -----
>  drivers/i2c/busses/i2c-omap.c          |   35 ++++++---

More on breaking this patch up...

Since the OMAP I2C driver is not a current PM QoS API user, it doesn't
really belong in this patch which is converting existing PM QoS API
users.  The OMAP I2C conversion should be its own patch.

Kevin
