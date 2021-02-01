Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B67C433E0
	for <linux-pm@archiver.kernel.org>; Mon,  1 Feb 2021 18:46:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B54960C3D
	for <linux-pm@archiver.kernel.org>; Mon,  1 Feb 2021 18:46:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbhBASqs (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 1 Feb 2021 13:46:48 -0500
Received: from smtprelay0139.hostedemail.com ([216.40.44.139]:44048 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231873AbhBASqn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 Feb 2021 13:46:43 -0500
X-Greylist: delayed 614 seconds by postgrey-1.27 at vger.kernel.org; Mon, 01 Feb 2021 13:46:43 EST
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave02.hostedemail.com (Postfix) with ESMTP id 8D9E21801DFA0
        for <linux-pm@vger.kernel.org>; Mon,  1 Feb 2021 18:36:47 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id C9901182CF66A;
        Mon,  1 Feb 2021 18:35:37 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: sound29_52137f3275c4
X-Filterd-Recvd-Size: 2116
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Mon,  1 Feb 2021 18:35:35 +0000 (UTC)
Message-ID: <ab62890a1128b0d3109553208379015fcb36e0c7.camel@perches.com>
Subject: Re: [PATCH v1 2/5] ACPI: battery: Clean up printing messages
From:   Joe Perches <joe@perches.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Erik Kaneda <erik.kaneda@intel.com>
Date:   Mon, 01 Feb 2021 10:35:33 -0800
In-Reply-To: <1996712.1aSbzQgNOC@kreacher>
References: <2367702.B5bJTmGzJm@kreacher> <1996712.1aSbzQgNOC@kreacher>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 2021-02-01 at 19:16 +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Replace the ACPI_DEBUG_PRINT() and ACPI_EXCEPTION() instances
> in battery.c with acpi_handle_debug() and acpi_handle_info() calls,
> respectively, drop the _COMPONENT and ACPI_MODULE_NAME() definitions
> that are not used any more, drop the no longer needed
> ACPI_BATTERY_COMPONENT definition from the headers and update the
> documentation accordingly.
> 
> While at it, update the pr_fmt() definition and drop the unneeded
> PREFIX sybmbol definition from battery.c.
[]
> --- linux-pm.orig/drivers/acpi/battery.c
[]
> @@ -466,7 +460,8 @@ static int extract_package(struct acpi_b
>  static int acpi_battery_get_status(struct acpi_battery *battery)
>  {
>  	if (acpi_bus_get_status(battery->device)) {
> -		ACPI_EXCEPTION((AE_INFO, AE_ERROR, "Evaluating _STA"));
> +		acpi_handle_info(battery->device->handle,
> +				 "_STA evaluation failed\n");

I believe this changes the logging level from KERN_ERR to KERN_INFO.

Perhaps this and others should instead use acpi_handle_err()


