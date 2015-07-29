From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v6 8/8] mfd: Add support for Intel Sunrisepoint LPSS devices
Date: Thu, 30 Jul 2015 01:30:48 +0200
Message-ID: <5162784.iHqgML8p9o@vostro.rjw.lan>
References: <1438009443-55317-1-git-send-email-andriy.shevchenko@linux.intel.com> <1438009443-55317-9-git-send-email-andriy.shevchenko@linux.intel.com> <20150729224434.642.39803@quantum>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:42612 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752911AbbG2XDv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 29 Jul 2015 19:03:51 -0400
In-Reply-To: <20150729224434.642.39803@quantum>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vinod Koul <vinod.koul@intel.com>, Lee Jones <lee.jones@linaro.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, sboyd@codeaurora.org

On Wednesday, July 29, 2015 03:44:34 PM Michael Turquette wrote:
> Hi Andy,

[cut]

> Do ACPI tables encode any meaningful data about clock signals? I gave
> some advice on this topic a couple of years ago to folks hacking on ACPI
> stuff in Linux, but I haven't kept up with the topic.
> 
> By comparison, most ARM-based platforms use Devicetree to link up a
> clock provider to a clock consumer. I do not think similar
> infrastructure exists yet for ACPI-based designs, but I wonder if the
> clock data exists in newer ACPI tables to at least make it possible?

No, it doesn't.

Thanks,
Rafael

