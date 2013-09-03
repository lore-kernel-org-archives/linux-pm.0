From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 00/27] ACPI AML helper conversion
Date: Tue, 03 Sep 2013 13:24:41 +0200
Message-ID: <3311378.XfhVXN0rZ3@vostro.rjw.lan>
References: <1378168335-22556-1-git-send-email-rui.zhang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:53882 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759925Ab3ICLNx (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 3 Sep 2013 07:13:53 -0400
In-Reply-To: <1378168335-22556-1-git-send-email-rui.zhang@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Tuesday, September 03, 2013 08:31:48 AM Zhang Rui wrote:
> Hi, all,
> 
> ACPI has some fine grained helpers for evaluating AML,
> which can be used to simplify the code a lot.
> And there are a couple of new helpers introduced recently,
> say, acpi_has_method/acpi_execute_simple_method, etc.
> 
> This patch set does some cleanup and converts the code to use
> the AML helpers when possible.
> 
> Patch 01/27 ~ Patch 09/27:
> converts acpi_evaluate_object() to acpi_execute_simple_method()
> Patch 10/27 ~ Patch 20/27:
> converts acpi_get_handle() to acpi_has_method()
> Patch 21/27 ~ Patch 27/27:
> converts acpi_evaluate_object() to acpi_evaluate_integer()
> 
> Given that there is no functional change in this patch set, and most of the
> patches are not able for me to test as they are platform driver changes,
> I just did build test and reboot with acpi_processor, i915 driver loaded
> on an Lenovo Ultrabook, and everything works well.

Nice series, I'm going to queue it up for 3.13.

Thanks!


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
