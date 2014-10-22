From: Santosh Shilimkar <santosh.shilimkar@gmail.com>
Subject: Re: [PATCH v2 02/47] memory: emif: Use API function to determine
 poweroff capability
Date: Wed, 22 Oct 2014 11:48:20 -0700
Message-ID: <5447FBF4.8020702@gmail.com>
References: <1413864783-3271-1-git-send-email-linux@roeck-us.net> <1413864783-3271-3-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f177.google.com ([209.85.214.177]:64550 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753424AbaJVSsN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 22 Oct 2014 14:48:13 -0400
In-Reply-To: <1413864783-3271-3-git-send-email-linux@roeck-us.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, Santosh Shilimkar <ssantosh@kernel.org>



On 10/20/2014 09:12 PM, Guenter Roeck wrote:
> Use have_kernel_power_off() to determine if the kernel is able
> to power off the system.
>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v2:
> - poweroff -> power_off
>
Acked-by: Santosh Shilimkar <ssantosh@kernel.org>

