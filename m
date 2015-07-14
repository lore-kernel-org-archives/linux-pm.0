From: Joseph Salisbury <joseph.salisbury@canonical.com>
Subject: Re: Subject:  [v3.19 Regression] x86, irq, acpi: Get rid of special
 handling of GSI for ACPI SCI
Date: Tue, 14 Jul 2015 13:22:08 -0400
Message-ID: <55A54540.9050300@canonical.com>
References: <55A4132B.4030801@canonical.com> <55A47716.9070605@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:36699 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751729AbbGNRWR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 14 Jul 2015 13:22:17 -0400
In-Reply-To: <55A47716.9070605@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jiang Liu <jiang.liu@linux.intel.com>
Cc: konrad.wilk@oracle.com, tony.luck@intel.com, joro@8bytes.org, Greg KH <gregkh@linuxfoundation.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Bjorn Helgaas <bhelgaas@google.com>, rdunlap@infradead.org, Yinghai Lu <yinghai@kernel.org>, bp@alien8.de, len.brown@intel.com, pavel@ucw.cz, Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, linux-pm@vger.kernel.org

On 07/13/2015 10:42 PM, Jiang Liu wrote:
> On 2015/7/14 3:36, Joseph Salisbury wrote:
>> Hello Jiang,
>>
>> A kernel bug report was opened against Ubuntu [0]. It was found that
>> reverting the following commit resolves this bug:
>>
>> commit cd68f6bd53cf89d1d5ed889b8af65e9c3574a079
>> Author: Jiang Liu <jiang.liu@linux.intel.com>
>> Date:   Mon Oct 27 16:11:52 2014 +0800
>>
>>     x86, irq, acpi: Get rid of special handling of GSI for ACPI SCI
>>
>> The regression was introduced as of v3.19-rc1.
>>     
>> I was hoping to get your feedback, since you are the patch author.  Do
>> you think gathering any additional data will help diagnose this issue,
>> or would it be best to submit a revert request?
> Hi Joseph,
> 	Sorry for the trouble. It would be great if we could get
> more information about the bug, such as bug report info, dmesg and
> acpidump from the reporting system.
> Thanks!
> Gerry
Comments 3 and 4 have the requested information in the bugzilla bug:
https://bugzilla.kernel.org/show_bug.cgi?id=101301

Thanks again for the help!

Joe

