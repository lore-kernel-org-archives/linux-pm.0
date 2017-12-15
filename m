From: Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH] cpupower: Remove FSF address
Date: Fri, 15 Dec 2017 08:26:01 -0700
Message-ID: <7b59f027-844c-deb5-c214-7b6b0d275b9a@kernel.org>
References: <20171215011629.15655-1-labbott@redhat.com>
 <20171215132316.GA23316@isilmar-4.linta.de>
Reply-To: shuah@kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout.easymail.ca ([64.68.200.34]:57620 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756767AbdLOP0N (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Dec 2017 10:26:13 -0500
In-Reply-To: <20171215132316.GA23316@isilmar-4.linta.de>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dominik Brodowski <linux@dominikbrodowski.net>, Laura Abbott <labbott@redhat.com>
Cc: Thomas Renninger <trenn@suse.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Shuah Khan <shuahkh@osg.samsung.com>, Shuah Khan <shuah@kernel.org>

On 12/15/2017 06:23 AM, Dominik Brodowski wrote:
> On Thu, Dec 14, 2017 at 05:16:29PM -0800, Laura Abbott wrote:
>>
>> Checkpatch in the kernel now complains about having the FSF address
>> in comments. Other tools such as rpmlint are now starting to do the
>> same thing. Remove the FSF address to reduce warnings on multiple tools.
>>
>> Signed-off-by: Laura Abbott <labbott@redhat.com>
> 
> Acked-by: Dominik Brodowski <linux@dominikbrodowski.net>
> 
> 

Thanks. I will apply this for 4.16-rc1

-- Shuah
