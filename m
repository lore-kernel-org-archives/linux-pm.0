From: Kapileshwar Singh <kapileshwar.singh@arm.com>
Subject: Re: thermal: cpu_cooling: Power calculation when CPUs are hotplugged
Date: Wed, 25 Mar 2015 15:55:41 +0000
Message-ID: <5512DA7D.4040504@arm.com>
References: <1426507251-26613-1-git-send-email-kapileshwar.singh@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from eu-smtp-delivery-143.mimecast.com ([146.101.78.143]:29795 "EHLO
	eu-smtp-delivery-143.mimecast.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932537AbbCYQCO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 25 Mar 2015 12:02:14 -0400
In-Reply-To: <1426507251-26613-1-git-send-email-kapileshwar.singh@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Cc: "edubezval@gmail.com" <edubezval@gmail.com>, "rui.zhang@intel.com" <rui.zhang@intel.com>, Javi Merino <Javi.Merino@arm.com>, Punit Agrawal <Punit.Agrawal@arm.com>

A gentle ping for a review.

On 16/03/15 12:00, Kapileshwar Singh wrote:
> The following patch series aims at correcting the requested power
> calculation when CPUs are hotplugged out. These patches are based on
> the "linus" branch of Eduardo's tree.
> 
> There is no need to update the cpu_dev pointer (cached) on the reception of a
> policy CPU update notifier from cpufreq. This is not required as OPPs
> can be ascertained even if the CPU is offline.
> 
> cpufreq_get_requested power ensures that a CPU is online before calculating
> the frequency for the CPUs and returns the power as 0 if all the CPUs
> are offline in the cooling device.
> 
> Regards,
> KP
> 
> Changes in v2:
> 
> * Added the Fixes entry in "thermal: cpu_cooling: Remove cpu_dev update on policy"
> * Using the correct mailserver config
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

