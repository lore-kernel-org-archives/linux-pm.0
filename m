From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 6/7] power: supply: bq24190_charger: Cleanup
 error-exit labels in probe()
Date: Wed, 22 Mar 2017 08:45:04 -0700
Message-ID: <20170322154503.GW8575@atomide.com>
References: <20170322145536.30570-1-hdegoede@redhat.com>
 <20170322145536.30570-7-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:41230 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1760241AbdCVPyd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 22 Mar 2017 11:54:33 -0400
Content-Disposition: inline
In-Reply-To: <20170322145536.30570-7-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Sebastian Reichel <sre@kernel.org>, Takashi Iwai <tiwai@suse.de>, linux-pm@vger.kernel.org, Liam Breck <kernel@networkimprov.net>

* Hans de Goede <hdegoede@redhat.com> [170322 07:57]:
> Names like out1, out2, etc. do not make it easier to follow what is
> going on and make it harder (require renaming) if any steps are
> later added / removed. Rename the labels to sane names.
> 
> This also folds out1 and out2 into one pm_runtime_disable step,
> if pm_runtime_get_sync fails we still need to do the put, it
> failing means that the device failed to resume, but the refcount
> will have been incremented and we need to decrement it.

Seems OK to me:

Acked-by: Tony Lindgren <tony@atomide.com>
