From: "Li, Shaohua" <shaohua.li@intel.com>
Subject: Re: [RFC 4/5] PCIe native PME detection
Date: Tue, 9 Sep 2008 09:21:22 +0800
Message-ID: <76780B19A496DC4B80439008DAD7076C01AC7F3091__34792.7906703719$1220923475$gmane$org@PDSMSX501.ccr.corp.intel.com>
References: <20080908091926.785882370@sli10-desk.sh.intel.com>
	<20080908092305.546278414@sli10-desk.sh.intel.com>
	<200809082336.34091.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200809082336.34091.rjw@sisk.pl>
Content-Language: en-US
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, "dbrownell@users.sourceforge.net" <dbrownell@users.sourceforge.net>, Jesse Barnes <jbarnes@virtuousgeek.org>
List-Id: linux-pm@vger.kernel.org


>On Monday, 8 of September 2008, shaohua.li@intel.com wrote:
>> This implements PCIe native PME detection.
>
>Could you please describe how this is done?
>
>Generally, please add kerneldoc comments to all of the functions and make
>it
>clear what they are for.
Sorry, I'll do it later. Currently the main goal is to discuss the device core changes. We need generic implementation not just for x86.

>It looks like 'dev' will always be the root complex.  Is that correct?
Right, and the port driver is just for root complex.

>> +     struct work_struct work;
>> +     u16 bdf; /* device which invokes PME */
>> +     int exit;
>> +};
>> +
>
>This one is analogous to pci_pme_active(), isn't it?
>
>Why don't you want it to clear the status bit as well?
No, they are some pcie root complex's native pme bits, I'll document them later. Also, I'll address your other comments later.

Thanks,
Shaohua
