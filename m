From: Alan Cox <alan@linux.intel.com>
Subject: Re: [PATCH 2/2] goldfish: Enable ACPI-based enumeration for
 goldfish battery
Date: Tue, 01 Mar 2016 23:27:47 +0000
Message-ID: <1456874867.7064.23.camel@linux.intel.com>
References: <20160226184455.2962.92705.stgit@localhost.localdomain>
	 <20160226184541.2962.40016.stgit@localhost.localdomain>
	 <20160226200326.GA19840@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:57436 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750850AbcCAX2G (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 1 Mar 2016 18:28:06 -0500
In-Reply-To: <20160226200326.GA19840@earth>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: dbaryshkov@gmail.com, dwmw2@infradead.org, linux-pm@vger.kernel.org

On Fri, 2016-02-26 at 21:03 +0100, Sebastian Reichel wrote:
> Hi Alan,
> 
> On Fri, Feb 26, 2016 at 06:45:50PM +0000, Alan wrote:
> > From: Yu Ning <yu.ning@intel.com>
> > 
> > Besides adding ACPI bindings to the goldfish battery driver, modify
> > the
> > ACPI driver to inform it that goldfish battery is a platform
> > device.
> > The latter step is necessary with kernel 3.16 or newer.
> 
> I don't understand the second part of the commit message. The patch
> only seems to add ACPI bindings to the goldfish battery driver. Did
> you forget to add something?

No I forgot to trim the message. Will revise and resend


