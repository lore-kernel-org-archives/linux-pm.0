From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [GIT PULL] Thermal-SoC management updates for v4.4-rc1 #1
Date: Tue, 3 Nov 2015 09:13:43 -0800
Message-ID: <20151103171341.GA4277@localhost.localdomain>
References: <20151101203036.GA9793@localhost.localdomain>
 <744357E9AAD1214791ACBA4B0B9092633A909D91@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <744357E9AAD1214791ACBA4B0B9092633A909D91@SHSMSX101.ccr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Zhang, Rui" <rui.zhang@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Rui, Rafael,

On Tue, Nov 03, 2015 at 03:10:28AM +0000, Zhang, Rui wrote:
> 
> > Javi Merino (2):
> >       PM / OPP: get the voltage for all OPPs
> 
> I think this patch should be took by Rafael, right?
> 
> Thanks,
> Rui
> 
> >  drivers/base/power/opp.c                           |   4 +-

Well, yes. I included it here because the devfreq support has a
(functional) dependency on this change. As it is a small change, and
I did not notice any break in linux-next, I included it in my pull
request.

Rafael, I think it is your call. Do you want collect this one and send
it via your tree, or are you fine having it going through Ruis?

BR,

Eduardo Valentin
