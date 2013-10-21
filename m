From: Dirk Brandewie <dirk.brandewie@gmail.com>
Subject: Re: [PATCH 0/4] intel_pstate updates
Date: Mon, 21 Oct 2013 15:40:04 -0700
Message-ID: <5265AD44.6010805@gmail.com>
References: <1382372435-29778-1-git-send-email-dirk.j.brandewie@intel.com> <52655686.7000406@intel.com> <4839646.Ilm2lvf4gq@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:46944 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752128Ab3JUWkH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 21 Oct 2013 18:40:07 -0400
Received: by mail-pa0-f53.google.com with SMTP id kq14so8730490pab.40
        for <linux-pm@vger.kernel.org>; Mon, 21 Oct 2013 15:40:07 -0700 (PDT)
In-Reply-To: <4839646.Ilm2lvf4gq@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org

On 10/21/2013 03:46 PM, Rafael J. Wysocki wrote:
> On Monday, October 21, 2013 09:29:58 AM Dirk Brandewie wrote:
>> Forgot to add this patch set is based on linux-pm/bleeding-edge
>> commit 1a1da369261c3ee2c3caa078b6ace46adcdffbb6
>
> So do I assume correctly that is is all 3.13 material?
>
> Or are patches [1-2/4] for 3.12?
>

1-2 are for 3.12

3-4 are for 3.13 Baytrail support requires ther refactoring to take
into account that the P state enumeration is different on Baytrail.



> Rafael
>

