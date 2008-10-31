From: "Peter Teoh" <htmldeveloper@gmail.com>
Subject: Re: [Question] AMD opteron can support CPUfreq by per
	core ?
Date: Fri, 31 Oct 2008 12:10:30 +0800
Message-ID: <804dabb00810302110u7e8ef285j5ebe54c0e09433f4__41129.8692496077$1225464339$gmane$org@mail.gmail.com>
References: <28c262360810292306x2f3fb6bag559943c59fa83006@mail.gmail.com>
	<804dabb00810302006x7d59474bg27b716ffadf4515a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <804dabb00810302006x7d59474bg27b716ffadf4515a@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: MinChan Kim <minchan.kim@gmail.com>
Cc: Kernelnewbies <kernelnewbies@nl.linux.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

and check this out:

http://ubuntuforums.org/archive/index.php/t-80494.html

in-depth steps for setting up cpufreq for one processor, which i
supposed can be extended for multicore?

On Fri, Oct 31, 2008 at 11:06 AM, Peter Teoh <htmldeveloper@gmail.com> wrote:
> check this out:
>
> http://osdir.com/ml/kernel.cpufreq/2004-07/msg00012.html
>
> from the reply, since the power management flag is at the per-core
> level (check /proc/cpuinfo), all control can be done at the per-core
> level, hard-ware wise.   (not sure of Linux Kernel itself)
>
> But at least 4 flags must be present (read above email):   ts, ttp, fid, vid.
>
> I must also say this is the first time I am aware of these flags too :-).
>
> On Thu, Oct 30, 2008 at 2:06 PM, MinChan Kim <minchan.kim@gmail.com> wrote:
>> Hi,  all,
>>
>> I want to test CPUfreq function in  AMD opteron quad-core series.
>> But I am not sure linux in now can support CPUfreq for ADM opteron by per core ?
>> What I mean is not controling to put together 2 core by one package
>> but control by per core.
>> After all, I want to control all 4 cpu separetely.
>>
>> Is is possible? If it is possible, What kinds of model can support ?
>>
>>  --
>> Kinds regards,
>> MinChan Kim
>>
>> --
>> To unsubscribe from this list: send an email with
>> "unsubscribe kernelnewbies" to ecartis@nl.linux.org
>> Please read the FAQ at http://kernelnewbies.org/FAQ
>>
>>
>
>
>
> --
> Regards,
> Peter Teoh
>



-- 
Regards,
Peter Teoh
