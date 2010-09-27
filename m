From: Ike Panhc <ike.pan@canonical.com>
Subject: Re: intel_idle (Lenovo ideapad S10-3)
Date: Mon, 27 Sep 2010 14:55:55 +0800
Message-ID: <4CA03FFB.2030307__15962.753215763$1285570658$gmane$org@canonical.com>
References: <4C8DE00F.7070801@canonical.com>
	<alpine.LFD.2.00.1009251201150.17910@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.00.1009251201150.17910@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Len Brown <lenb@kernel.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, linux-pm@lists.linux-foundation.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Len,

Thanks a lot. I apply the patch and the kernel boots fine on S10-3


On 09/26/2010 12:09 AM, Len Brown wrote:
> 
>> I test myself which says when CONFIG_CPU_IDLE=y, Lenovo ideapad S10-3 can
>> not boot. The CPU is Atom N450, and I also find the report[2] that says intel_idle
>> works fine with N450.
>>
>> I do not have much knowledge about intel_idle. is there any similar report that on
>> some machine intel_idle halt the system or any suggestion for next step debug?
>>
>>
>> [1] http://launchpad.net/bugs/634702
>> [2] http://www.spinics.net/lists/linux-pm/msg21334.html
> 
> Please test the fix here:
> http://bugs.meego.com/show_bug.cgi?id=7093
> 
> thanks,
> -Len
> 
