From: Sachin Kamat <spk.linux@gmail.com>
Subject: Re: [PATCH] cpufreq: tests: Providing cpufreq regression test
Date: Tue, 22 Jul 2014 09:43:45 +0530
Message-ID: <CAK5sBcGdrmfkc_hyV3DewwLjGa3=1xjctzqcTNC9C2yPFmEFCg@mail.gmail.com>
References: <1405678985-21677-1-git-send-email-l.majewski@samsung.com>
	<CAK5sBcH=L-7=BHNPQUjuoQfQx5QeFmBSdwdow+RXBExgCOP0Ww@mail.gmail.com>
	<20140718135933.0837e094@amdc2363>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <20140718135933.0837e094@amdc2363>
Sender: cpufreq-owner@vger.kernel.org
To: Lukasz Majewski <l.majewski@samsung.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Thomas Abraham <ta.omasab@gmail.com>, "thomas.ab@samsung.com" <thomas.ab@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Tomasz Figa <t.figa@samsung.com>
List-Id: linux-pm@vger.kernel.org

Hi Lukasz,

On Fri, Jul 18, 2014 at 5:29 PM, Lukasz Majewski <l.majewski@samsung.com> wrote:
> Hi Sachin,
>
>> Hi Lukasz,
>>
>> I tested this script on 4210 based Origen board.
>> This is the output:
>> ./cpufreq_freq_test.sh
>> CURRENT GOVERNOR: performance
>> SET GOVERNOR: performance
>> ######################################
>> TEST AVAILABLE FREQS
>> ######################################
>> FREQ: 1200000 sleep: invalid number '0.1'
>> [    5.918347] random: gzip urandom read with 61 bits of entropy
>> available OK
>> FREQ: 1000000 sleep: invalid number '0.1'
>>          OK
>> FREQ: 800000 sleep: invalid number '0.1'
>>          OK
>> FREQ: 500000 sleep: invalid number '0.1'
>>          OK
>> FREQ: 200000 sleep: invalid number '0.1'
>>          OK
>> ######################################
>> TEST FREQS SWITCHING
>> ######################################
>> REFERENCE FREQ: 1200000
>> FREQ: 1200000 ----> FREQ: 1200000 sleep: invalid number '0.1'
>>          OK
>> FREQ: 1200000 ----> FREQ: 1000000 sleep: invalid number '0.1'
>>          OK
>> FREQ: 1200000 ----> FREQ: 800000 sleep: invalid number '0.1'
>>          OK
>> FREQ: 1200000 ----> FREQ: 500000 sleep: invalid number '0.1'
>>          OK
>> FREQ: 1200000 ----> FREQ: 200000 sleep: invalid number '0.1'
>>          OK
>> REFERENCE FREQ: 1000000
>> FREQ: 1000000 ----> FREQ: 1200000 sleep: invalid number '0.1'
>>          OK
>> FREQ: 1000000 ----> FREQ: 1000000 sleep: invalid number '0.1'
>>          OK
>> FREQ: 1000000 ----> FREQ: 800000 sleep: invalid number '0.1'
>>          OK
>> FREQ: 1000000 ----> FREQ: 500000 sleep: invalid number '0.1'
>>          OK
>> FREQ: 1000000 ----> FREQ: 200000 sleep: invalid number '0.1'
>>          OK
>> REFERENCE FREQ: 800000
>> FREQ: 800000 ----> FREQ: 1200000 sleep: invalid number '0.1'
>>          OK
>> FREQ: 800000 ----> FREQ: 1000000 sleep: invalid number '0.1'
>>          OK
>> FREQ: 800000 ----> FREQ: 800000 sleep: invalid number '0.1'
>>          OK
>> FREQ: 800000 ----> FREQ: 500000 sleep: invalid number '0.1'
>>          OK
>> FREQ: 800000 ----> FREQ: 200000 sleep: invalid number '0.1'
>>          OK
>> REFERENCE FREQ: 500000
>> FREQ: 500000 ----> FREQ: 1200000 sleep: invalid number '0.1'
>>          OK
>> FREQ: 500000 ----> FREQ: 1000000 sleep: invalid number '0.1'
>>          OK
>> FREQ: 500000 ----> FREQ: 800000 sleep: invalid number '0.1'
>>          OK
>> FREQ: 500000 ----> FREQ: 500000 sleep: invalid number '0.1'
>>          OK
>> FREQ: 500000 ----> FREQ: 200000 sleep: invalid number '0.1'
>>          OK
>> REFERENCE FREQ: 200000
>> FREQ: 200000 ----> FREQ: 1200000 sleep: invalid number '0.1'
>>          OK
>> FREQ: 200000 ----> FREQ: 1000000 sleep: invalid number '0.1'
>>          OK
>> FREQ: 200000 ----> FREQ: 800000 sleep: invalid number '0.1'
>>          OK
>> FREQ: 200000 ----> FREQ: 500000 sleep: invalid number '0.1'
>>          OK
>> FREQ: 200000 ----> FREQ: 200000 sleep: invalid number '0.1'
>>          OK
>> ######################################
>> ERRORS: 0
>> ######################################
>>
>> Though it says 0 errors, what does the "invalid number..." signify?
>
> I guess that this message is caused by your default sleep
> implementation.
>
> Could you type 'sleep 0.1' and then 'sleep 1' in your console on the
> target system?
> Is the "invalid number" not present with the second case?

Only with first case (sleep 0.1) I get the "invalid number" message.
sleep 1 seems to be OK.


-- 
Regards,
Sachin.
