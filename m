From: Imre Deak <imre.deak@intel.com>
Subject: ACPI target state during S4 quiesce phase
Date: Wed, 12 Jul 2017 22:10:09 +0300
Message-ID: <20170712191009.pylvv4kpjmyi7lny@ideak-desk.fi.intel.com>
Reply-To: imre.deak@intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:17254 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752673AbdGLTKM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 12 Jul 2017 15:10:12 -0400
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org

Hi,

I noticed that acpi_target_system_state() returns ACPI_STATE_S0
when called from a dev pm->freeze hook before restoring the hibernation
image (PMSG_QUIESCE). Is this on purpose? One could argue that it should
be ACPI_STATE_S4, matching the target state before creating the
hibernation image (PMSG_FREEZE).

Thanks,
Imre
