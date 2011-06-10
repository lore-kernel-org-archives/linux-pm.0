From: Kyungmin Park <kmpark@infradead.org>
Subject: Re: [PATCH 00/10] mm: Linux VM Infrastructure to support
	Memory Power Management
Date: Fri, 10 Jun 2011 09:51:53 +0900
Message-ID: <BANLkTinxeeSby_+tta8EhzCg3VbD6+=g+g__38730.5441232913$1307680700$gmane$org@mail.gmail.com>
References: <1306499498-14263-1-git-send-email-ankita@in.ibm.com>
	<20110528005640.9076c0b1.akpm@linux-foundation.org>
	<20110609185259.GA29287@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110609185259.GA29287@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: paulmck@linux.vnet.ibm.com
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, thomas.abraham@linaro.org, Ankita Garg <ankita@in.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Fri, Jun 10, 2011 at 3:52 AM, Paul E. McKenney
<paulmck@linux.vnet.ibm.com> wrote:
> On Sat, May 28, 2011 at 12:56:40AM -0700, Andrew Morton wrote:
>> On Fri, 27 May 2011 18:01:28 +0530 Ankita Garg <ankita@in.ibm.com> wrote:
>>
>> > This patchset proposes a generic memory regions infrastructure that ca=
n be
>> > used to tag boundaries of memory blocks which belongs to a specific me=
mory
>> > power management domain and further enable exploitation of platform me=
mory
>> > power management capabilities.
>>
>> A couple of quick thoughts...
>>
>> I'm seeing no estimate of how much energy we might save when this work
>> is completed. =A0But saving energy is the entire point of the entire
>> patchset! =A0So please spend some time thinking about that and update and
>> maintain the [patch 0/n] description so others can get some idea of the
>> benefit we might get from all of this. =A0That estimate should include an
>> estimate of what proportion of machines are likely to have hardware
>> which can use this feature and in what timeframe.
>>
>> IOW, if it saves one microwatt on 0.001% of machines, not interested ;)
>
> FWIW, I have seen estimates on the order of a 5% reduction in power
> consumption for some common types of embedded devices.

Wow interesting. I can't expect it can reduce 5% power reduction.
If it uses the 1GiBytes LPDDR2 memory. each memory port has 4Gib,
another has 4Gib. so one bank size is 64MiB (512MiB / 8).
So I don't expect it's difficult to contain the free or inactive
memory more than 64MiB during runtime.

Anyway can you describe the exact test environment? esp., memory type?
As you know there are too much embedded devices which use the various
environment.

Thank you,
Kyungmin Park
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Thanx, Paul
>
>> Also, all this code appears to be enabled on all machines? =A0So machines
>> which don't have the requisite hardware still carry any additional
>> overhead which is added here. =A0I can see that ifdeffing a feature like
>> this would be ghastly but please also have a think about the
>> implications of this and add that discussion also.
>>
>> If possible, it would be good to think up some microbenchmarks which
>> probe the worst-case performance impact and describe those and present
>> the results. =A0So others can gain an understanding of the runtime costs.
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-kernel" =
in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at =A0http://www.tux.org/lkml/
>>
>
> --
> To unsubscribe, send a message with 'unsubscribe linux-mm' in
> the body to majordomo@kvack.org. =A0For more info on Linux MM,
> see: http://www.linux-mm.org/ .
> Fight unfair telecom internet charges in Canada: sign http://stopthemeter=
.ca/
> Don't email: <a href=3Dmailto:"dont@kvack.org"> email@kvack.org </a>
>
