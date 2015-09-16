From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v4 08/10] power: bq24257: Allow input current limit sysfs
 access
Date: Wed, 16 Sep 2015 15:31:06 +0900
Message-ID: <55F90CAA.5090701@samsung.com>
References: <1442339914-25843-1-git-send-email-dannenberg@ti.com>
 <1442339914-25843-9-git-send-email-dannenberg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.w1.samsung.com ([210.118.77.14]:19746 "EHLO
	mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752533AbbIPGbK (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 16 Sep 2015 02:31:10 -0400
In-reply-to: <1442339914-25843-9-git-send-email-dannenberg@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andreas Dannenberg <dannenberg@ti.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Laurentiu Palcu <laurentiu.palcu@intel.com>
Cc: Ramakrishna Pallala <ramakrishna.pallala@intel.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org

On 16.09.2015 02:58, Andreas Dannenberg wrote:
> This patch allows reading (and writing, if the D+/D- USB signal-based
> charger type detection is disabled) of the input current limit through
> the POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT sysfs property. This allows
> userspace to see what charger was detected and to re-configure the
> maximum current drawn from the external supply at runtime based on
> system-level knowledge or user input.
> 
> Signed-off-by: Andreas Dannenberg <dannenberg@ti.com>
> ---
>  drivers/power/bq24257_charger.c | 67 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 67 insertions(+)
> 

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

BTW you are exposing more and more sysfs attributes which are userspace
interfaces. They should be documented:
Documentation/SubmitChecklist - point 19
Documentation/ABI/README

Although not all new drivers (and perhaps not all reviewers) follow this
rule...

Best regards,
Krzysztof

