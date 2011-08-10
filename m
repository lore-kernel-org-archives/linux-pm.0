From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v2 2/2] cpu: update cpu_hotpluggable_mask in
	register_cpu
Date: Wed, 10 Aug 2011 22:54:45 +0200
Message-ID: <4E42F015.1090801__6223.41850908032$1313009732$gmane$org@linaro.org>
References: <1313006614-28702-1-git-send-email-mturquette@ti.com>
	<1313006614-28702-3-git-send-email-mturquette@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1313006614-28702-3-git-send-email-mturquette@ti.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Mike Turquette <mturquette@ti.com>
Cc: linux-pm@lists.linux-foundation.org, gregkh@suse.de, linaro-dev@lists.linaro.org, linux-kernel@vger.kernel.org, patches@linaro.org
List-Id: linux-pm@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 08/10/2011 10:03 PM, Mike Turquette wrote:
> Update the cpu_hotpluggable_mask for each registered CPU which supports
> hotplug.  This makes it trivial for kernel code to know which CPUs
> support hotplug operations.
> 
> Signed-off-by: Mike Turquette <mturquette@ti.com>

Reviewed-by: <Daniel Lezcano> daniel.lezcano@linaro.org

- -- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQEcBAEBAgAGBQJOQvAUAAoJEAKBbMCpUGYADTYH/3jGeK5pryiVKaxQ7wUBwsG6
7ugSLCCgBVUL6ueuVmlphhfW8Vv9Uz72LlJnaJUmJ0deK/Rf5x1ccFulBTtIsyjK
Zbw4Wg0MYxfNo0OAi7OSjWMUw31PC8kKVBSUZd3zHeqi6TanKUtxR5im4EWGhQbc
+Njhx2jAqZBEEcPnODiRx+CbYJX17N2Cesmk8Z+Tk00LIpM30iGGX15ZWXnV6KWM
zD3vG7ATLa/rv1/xPa67SDXdZIo99wDodjtjTFPClygM/XTSNBiIxsm9LnnUkmyw
gw1Q6Ng+wo2XyhxJ//b+kM0natnc7Tl6RtDIL7T+j9rIAdf8Sz9DPgmafWQRxYY=
=hwkF
-----END PGP SIGNATURE-----
