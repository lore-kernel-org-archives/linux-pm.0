From: Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [PATCH 3/3] cpuidle,menu: smooth out measured_us calculation
Date: Wed, 4 Nov 2015 08:02:41 -0800
Message-ID: <563A2C21.8020308@linux.intel.com>
References: <1446590059-18897-1-git-send-email-riel@redhat.com>
 <1446590059-18897-4-git-send-email-riel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:49002 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753556AbbKDQCz (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 4 Nov 2015 11:02:55 -0500
In-Reply-To: <1446590059-18897-4-git-send-email-riel@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: riel@redhat.com, linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, rafael.j.wysocki@intel.com, len.brown@intel.com, daniel.lezcano@linaro.org

On 11/3/2015 2:34 PM, riel@redhat.com wrote:

> Furthermore, for smaller sleep intervals, we know the chance that
> all the cores in the package went to the same idle state are fairly
> small. Dividing the measured_us by two, instead of subtracting the
> full exit latency when hitting a small measured_us, will reduce the
> error.

there is no perfect answer for this issue; but at least this makes the situation
a lot better, so

Acked-by: Arjan van de Ven <arjan@linux.intel.com>
