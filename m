From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Subject: Re: [PATCH 05/12] cpufreq: governor: rename cur_policy as policy
Date: Mon, 15 Jun 2015 09:54:37 +0530
Message-ID: <557E5385.8060605@linux.vnet.ibm.com>
References: <cover.1434019473.git.viresh.kumar@linaro.org> <fcb0238e0129700cd090f6199b44fbf3edc0b63b.1434019473.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-6
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e17.ny.us.ibm.com ([129.33.205.207]:43778 "EHLO
	e17.ny.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751492AbbFOEYq (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 15 Jun 2015 00:24:46 -0400
Received: from /spool/local
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <preeti@linux.vnet.ibm.com>;
	Mon, 15 Jun 2015 00:24:46 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
	by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 3BFDD6E803C
	for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2015 00:16:30 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t5F4OhEg64028818
	for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2015 04:24:43 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
	by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t5F4Ofaq028463
	for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2015 00:24:42 -0400
In-Reply-To: <fcb0238e0129700cd090f6199b44fbf3edc0b63b.1434019473.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, ke.wang@spreadtrum.com
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, ego@linux.vnet.ibm.com, paulus@samba.org, shilpa.bhat@linux.vnet.ibm.com, prarit@redhat.com, robert.schoene@tu-dresden.de, skannan@codeaurora.org

On 06/11/2015 04:21 PM, Viresh Kumar wrote:
> Just call it 'policy', cur_policy is unnecessarily long and doesn't
> have any special meaning.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Reviewed-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>

