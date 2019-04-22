From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH] tools/power turbostat: fix file descriptor leaks
Date: Mon, 22 Apr 2019 10:15:58 -0500
Message-ID: <1c208944-9162-0245-c3bd-016f4274511f@embeddedor.com>
References: <20190408161240.GA30623@embeddedor>
 <16370c2e-c5f9-a4cf-02fc-6b5b4ab65e1c@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <16370c2e-c5f9-a4cf-02fc-6b5b4ab65e1c@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Prarit Bhargava <prarit@redhat.com>, Len Brown <lenb@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi all,

Friendly ping:

Who can take this?

Thanks
--
Gustavo

On 4/8/19 12:04 PM, Prarit Bhargava wrote:
> 
> 
> On 4/8/19 12:12 PM, Gustavo A. R. Silva wrote:
>> Fix file descriptor leaks by closing fp before return.
>>
>> Addresses-Coverity-ID: 1444591 ("Resource leak")
>> Addresses-Coverity-ID: 1444592 ("Resource leak")
>> Fixes: 5ea7647b333f ("tools/power turbostat: Warn on bad ACPI LPIT data")
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> 
> Reviewed-by: Prarit Bhargava <prarit@redhat.com>
> 
> P.
> 
>> ---
>>  tools/power/x86/turbostat/turbostat.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
>> index c7727be9719f..78d9acba8e9b 100644
>> --- a/tools/power/x86/turbostat/turbostat.c
>> +++ b/tools/power/x86/turbostat/turbostat.c
>> @@ -2924,6 +2924,7 @@ int snapshot_cpu_lpi_us(void)
>>  	if (retval != 1) {
>>  		fprintf(stderr, "Disabling Low Power Idle CPU output\n");
>>  		BIC_NOT_PRESENT(BIC_CPU_LPI);
>> +		fclose(fp);
>>  		return -1;
>>  	}
>>  
>> @@ -2950,6 +2951,7 @@ int snapshot_sys_lpi_us(void)
>>  	if (retval != 1) {
>>  		fprintf(stderr, "Disabling Low Power Idle System output\n");
>>  		BIC_NOT_PRESENT(BIC_SYS_LPI);
>> +		fclose(fp);
>>  		return -1;
>>  	}
>>  	fclose(fp);
>>
