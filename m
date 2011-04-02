From: Trinabh Gupta <trinabh@linux.vnet.ibm.com>
Subject: Re: [PATCH 04/18] x86 idle: EXPORT_SYMBOL(default_idle,
 pm_idle) only when APM demands it
Date: Sat, 02 Apr 2011 17:51:55 +0530
Message-ID: <4D9714E3.8010302__2822.28279761529$1301746986$gmane$org@linux.vnet.ibm.com>
References: <alpine.LFD.2.02.1104010020280.2797@x980>
	<1301725380-10579-1-git-send-email-lenb@kernel.org>
	<dba24a423948935d0a0c1eb32414a476f3f90e02.1301724243.git.len.brown@intel.com>
	<20110402122857.5fb7d2b7@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110402122857.5fb7d2b7@lxorguk.ukuu.org.uk>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Len Brown <len.brown@intel.com>, Jiri Kosina <jkosina@suse.cz>, x86@kernel.org, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org



On 04/02/2011 04:58 PM, Alan Cox wrote:
> On Sat, 02 Apr 2011 02:22:46 -0400
> Len Brown<lenb@kernel.org>  wrote:
>
>> From: Len Brown<len.brown@intel.com>
>>
>> In the long run, we don't want default_idle() or (pm_idle)() to
>> be exported outside of process.c.  Start by not exporting them
>> to modules, unless the APM build demands it.
>
> Pointless added complexity. Why are you so determined to minimise this -
> it makes no odds to anyone.

Hi Alan,

I am not sure if I have understood you correctly but
I think one problem is that modules such as APM
save the value of pm_idle pointer, set it and restore it back.

At module init:

original_pm_idle = pm_idle;
pm_idle  = apm_cpu_idle;

At module exit:

pm_idle = original_pm_idle;

There is no guarantee that the pointer stored
is still valid. I think people have problem with such
usage; see http://lkml.org/lkml/2009/8/28/50

Thanks,
-Trinabh
