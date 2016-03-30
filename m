From: Matt Longnecker <mlongnecker@nvidia.com>
Subject: Re: [PATCH v3 2/4] thermal: send notifications for tz temperature
Date: Wed, 30 Mar 2016 09:53:37 -0700
Message-ID: <56FC0491.10309@nvidia.com>
References: <1459298497-29481-1-git-send-email-srikars@nvidia.com>
 <1459298497-29481-3-git-send-email-srikars@nvidia.com>
 <56FC0215.1060802@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate16.nvidia.com ([216.228.121.65]:3715 "EHLO
	hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755224AbcC3Qxj (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 30 Mar 2016 12:53:39 -0400
In-Reply-To: <56FC0215.1060802@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srikar Srimath Tirumala <srikars@nvidia.com>, edubezval@gmail.com, rui.zhang@intel.com, srinivas.pandruvada@intel.com, linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org



On 03/30/2016 09:43 AM, Matt Longnecker wrote:
>
>
> On 03/29/2016 05:41 PM, Srikar Srimath Tirumala wrote:
>>     struct thermal_trip {
>> @@ -355,6 +366,7 @@ struct thermal_trip {
>>       unsigned long int temperature;
>>       unsigned long int hysteresis;
>>       enum thermal_trip_type type;
>> +    enum thermal_trip_state state;
> This looks vestigial. Remove it?
>
>
nevermind. I see that it's used in the next patch. And it really does 
belong here, not in the next patch.
