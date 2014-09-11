From: Oliver Neukum <oneukum@suse.de>
Subject: Re: error returns of pm_runtime_get()
Date: Thu, 11 Sep 2014 15:27:06 +0200
Message-ID: <1410442026.4966.8.camel@linux-fkkt.site>
References: <1409921016.9532.15.camel@linux-fkkt.site>
	 <3017868.AFCp3kOadE@vostro.rjw.lan>
	 <1410354270.12706.22.camel@linux-fkkt.site>
	 <2871114.Byp9HpPsJ7@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:35685 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755131AbaIKN1I (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 11 Sep 2014 09:27:08 -0400
In-Reply-To: <2871114.Byp9HpPsJ7@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Alan Stern <stern@rowland.harvard.edu>

On Thu, 2014-09-11 at 02:03 +0200, Rafael J. Wysocki wrote:
> > The alternative is to make a conversion helper and to go through all
> > drivers. Not nice, but if necessary I'll do it.
> 
> I honestly would prefer that.

Very well, then I shall do that.

	Regards
		Oliver


