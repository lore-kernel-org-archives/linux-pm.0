From: Tejun Heo <htejun@gmail.com>
Subject: Re: 2.6.33-rc6 crashes on resume
Date: Tue, 09 Feb 2010 12:32:42 +0900
Message-ID: <4B70D75A.7010600__26702.0857696936$1265732167$gmane$org@gmail.com>
References: <4B70982F.8090208@roadwarrior3.tmr.com>
	<201002090016.18027.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201002090016.18027.rjw@sisk.pl>
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
Cc: pm list <linux-pm@lists.linux-foundation.org>, linux-ext4@vger.kernel.org, davidsen@tmr.com, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 02/09/2010 08:16 AM, Rafael J. Wysocki wrote:
> On Tuesday 09 February 2010, Bill Davidsen wrote:
>> Pretty simple to reproduce, boot, suspend, press shift
>>
>> Acer Aspire 1681, Celeron, 2.6.33-rc6. Trace and config attached.
> 
> This looks suspicious:
> 
> Feb  8 17:32:47 roadwarrior3 kernel: ata2.00: ACPI cmd 03/42:00:00:00:a0:ef (CFA REQUEST EXTENDED ERROR) rejected by device (Stat=0x51 Err=0x04)
> Feb  8 17:32:47 roadwarrior3 kernel: sd 0:0:0:0: [sda] Starting disk
> Feb  8 17:32:47 roadwarrior3 kernel: ata2.00: ACPI cmd 00/0c:00:00:00:a0:ef (NOP) rejected by device (Stat=0x51 Err=0x04)
> Feb  8 17:32:47 roadwarrior3 kernel: ata2.00: configured for UDMA/33
> Feb  8 17:32:47 roadwarrior3 kernel: firewire_core: rediscovered device fw0
> Feb  8 17:32:47 roadwarrior3 kernel: ata1.00: ACPI cmd 03/45:00:00:00:a0:ef (CFA REQUEST EXTENDED ERROR) rejected by device (Stat=0x51 Err=0x04)
> Feb  8 17:32:47 roadwarrior3 kernel: ata1.00: ACPI cmd 00/0c:00:00:00:a0:ef (NOP) rejected by device (Stat=0x51 Err=0x04)
> Feb  8 17:32:47 roadwarrior3 kernel: ata1.00: configured for UDMA/100

These aren't harmful in themselves.  It just means that the device
failed commands BIOS requested via ACPI.  Just in case, does
"libata.noacpi=1" make any difference to the oops?

Thanks.

-- 
tejun
