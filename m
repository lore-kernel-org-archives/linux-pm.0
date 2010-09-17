From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] opp: introduce library for device-specific
	OPPs
Date: Fri, 17 Sep 2010 10:05:44 -0500
Message-ID: <4C9383C8.4020608__8001.73631073466$1284736019$gmane$org@ti.com>
References: <1284686973-13993-1-git-send-email-nm@ti.com>
	<AANLkTin2fBriymD7p-YfhPL24hMfYttsZBdighCSJxV2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTin2fBriymD7p-YfhPL24hMfYttsZBdighCSJxV2@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linus Walleij <linus.ml.walleij@gmail.com>
Cc: Phil Carmody <ext-phil.2.carmody@nokia.com>, linux-doc <linux-doc@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, "Chikkature Rajashekar,
	Madhusudhan" <madhu.cr@ti.com>, "Aguirre,
	Sergio" <saaguirre@ti.com>, Andi Kleen <ak@linux.intel.com>, Len@smtp1.linux-foundation.org, linux-pm <linux-pm@lists.linux-foundation.org>, Matthew Garrett <mjg@redhat.com>, Brown <len.brown@intel.com>, Eduardo Valentin <eduardo.valentin@nokia.com>, linux-omap <linux-omap@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, "Granados
	Dorado, Roberto" <x0095451@ti.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, lkml <linux-kernel@vger.kernel.org>, Romit Dasgupta <ro.mit@ti.com>
List-Id: linux-pm@vger.kernel.org

Linus Walleij had written, on 09/17/2010 08:41 AM, the following:
> 2010/9/17 Nishanth Menon <nm@ti.com>:
> 
>> diff --git a/Documentation/power/00-INDEX b/Documentation/power/00-INDEX
>> index fb742c2..45e9d4a 100644
>> --- a/Documentation/power/00-INDEX
>> +++ b/Documentation/power/00-INDEX
>> @@ -14,6 +14,8 @@ interface.txt
>>        - Power management user interface in /sys/power
>>  notifiers.txt
>>        - Registering suspend notifiers in device drivers
>> +opp.txt
>> +       - Operating Performance Point library
>>  pci.txt
>>        - How the PCI Subsystem Does Power Management
> 
> Hm you add the documentation to the index but not the documentation
> itself (easy slip) would you mind posting it?
ouch.. Sorry.. I realized that I missed adding MAINTAINER entry as 
well.. v2 coming up..

-- 
Regards,
Nishanth Menon
