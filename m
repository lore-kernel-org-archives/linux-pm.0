From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: [PATCH] libata: pm: differentiate system and runtime pm for ata
 port
Date: Tue, 22 Jan 2013 16:48:54 +0800
Message-ID: <20130122084854.GA26256@aaronlu.sh.intel.com>
References: <1346143791-2995-1-git-send-email-aaron.lu@intel.com>
 <50FDA8B3.6090100@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <50FDA8B3.6090100@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, Aaron Lu <aaron.lwe@gmail.com>, Jeff Wu <jeff.wu@amd.com>
List-Id: linux-pm@vger.kernel.org

On Mon, Jan 21, 2013 at 03:44:35PM -0500, Jeff Garzik wrote:
> On 08/28/2012 04:49 AM, Aaron Lu wrote:
> >For sata port, only runtime pm needs to be taken care of;
> >For IDE port, only system pm needs to be taken care of.
> >Currently, we use PMSG_SUSPEND for both system suspend and runtime
> >suspend and PMSG_ON for both system resume and runtime resume.
> >
> >Change this by using PMSG_AUTO_SUSPEND for runtime suspend and
> >PMSG_AUTO_RESUME for runtime resume.
> >
> >The ata_acpi_set_state is modified accordingly. And the sata case and
> >pata case is seperated for easy understanding.
> >
> >Signed-off-by: Aaron Lu <aaron.lu@intel.com>
> >---
> >  drivers/ata/libata-acpi.c | 83 ++++++++++++++++++++++++++++++++---------------
> >  drivers/ata/libata-core.c | 22 +++++++++----
> >  drivers/ata/libata-eh.c   |  9 ++---
> >  3 files changed, 78 insertions(+), 36 deletions(-)
> 
> 
> Can you rediff this on top of libata-dev.git #upstream?

Sure. Will send out when it's ready, thanks.

-Aaron

